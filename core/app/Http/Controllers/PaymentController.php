<?php

namespace App\Http\Controllers;

use App\Constants\Status;
use App\Http\Controllers\Controller;
use App\Lib\CartManager;
use App\Lib\ProductManager;
use App\Models\AdminNotification;
use App\Models\AppliedCoupon;
use App\Models\GatewayCurrency;
use App\Models\Order;
use App\Models\OrderDetail;
use App\Models\ShippingAddress;
use App\Models\ShippingMethod;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Str;

class PaymentController extends Controller {
    private $cartManager;

    public function __construct(CartManager $cartManager) {
        parent::__construct();
        $this->cartManager = $cartManager;
    }

    public function paymentMethods() {
        $pageTitle = 'Payment Methods';
        $gatewayCurrencies = GatewayCurrency::whereHas('method', function ($gate) {
            $gate->where('status', Status::ENABLE);
        })->with('method')->orderby('method_code', 'desc')->get();

        $shippingMethod = ShippingMethod::active()->where('id', @session('shipping_info')['shipping_method_id'])->first();

        $hasPhysicalProduct = $this->cartManager->checkPhysicalProductExistence();

        $subtotal       = $this->cartManager->subtotal();
        $coupon         = session('coupon');

        return view('Template::checkout_steps.payment_methods', compact('pageTitle', 'gatewayCurrencies', 'shippingMethod', 'subtotal', 'coupon', 'hasPhysicalProduct'));
    }

    public function completeCheckout(Request $request) {
        $this->validation($request);

        $gatewayCurrency = $this->getGatewayCurrency($request);

        $hasPhysicalProduct = $this->cartManager->checkPhysicalProductExistence();

        // If there is no physical product in the cart COD can not be selected
        if (!$hasPhysicalProduct && $gatewayCurrency->id == 0) {
            $notify[] = ['error', 'Invalid gateway'];
            return back()->withNotify($notify);
        }

        $cartData = $this->cartManager->getCart();

        if (blank($cartData)) {
            $notify[] = ['error', 'No product found to place order'];
            return to_route('cart.page')->withNotify($notify);
        }

        $checkStock = $this->checkStock($cartData);

        if ($checkStock instanceof RedirectResponse) {
            return $checkStock;
        }

        $checkPrice = $this->cartManager->checkProductsPrice($cartData);

        if (!$checkPrice['status']) {
            $notify[] = ['error', $checkPrice['message']];
            return to_route('cart.page')->withNotify($notify);
        }

        $subtotal = $this->cartManager->subtotal();
        $coupon   = $this->appliedCoupon($cartData, $subtotal);

        if (isset($coupon['error'])) {
            $notify[] = ['error', $coupon['error']];
            return back()->withNotify($notify);
        }

        $orderId = session()->get('order_id');
        session()->forget('order_id');

        $order = null;

        if ($orderId) {
            $order = Order::find($orderId);

            if (!$order) {
                $notify[] = ['error', 'Session expired'];
                return to_route('home')->withNotify($notify);
            }

            if ($order->payment_status == 1 || $order->payment_status == 2) {
                $notify[] = ['error', 'Order already paid'];
                return to_route('home')->withNotify($notify);
            }

            if (auth()->user() && $order->user_id && $order->user_id != auth()->id()) {
                abort(403);
            } else {
                $guestUser = session('guest_user_data');
                if (session('guest_user_data') && $order->guest_id != ($guestUser->id ?? NULL)) {
                    abort(403);
                }
            }
            session()->forget('order_id');
            session()->save();
        }

        if (!$order) {
            $order = $this->saveOrder($subtotal, $coupon, $gatewayCurrency, $cartData, $hasPhysicalProduct);
        }

        if ($coupon) {
            $this->saveAppliedCoupon($coupon, $order);
        }

        $this->sendAdminNotification($order);

        $trx = $order->initiatePayment($gatewayCurrency);

        if (!$order->is_cod) {
            session()->put('Track', $trx);
            session()->put('order_id', $order->id);
            return to_route('deposit.confirm');
        }

        if ($order->user_id) {
            $this->cartManager->clearUserCart('user_id', $order->user_id);
        } else {
            $this->cartManager->clearUserCart('session_id', $order->guest->session_id);
        }

        $notify[] = ['success', 'Your order has submitted successfully'];

        $user = $order->guest;

        sendOrderPlacedNotification($user, $order);
        session()->forget('shipping_info');
        session()->forget('guest_user_data');
        return redirect()->route("checkout.confirmation", $order->order_number)->withNotify($notify);
    }

    private function sendAdminNotification($order) {
        $adminNotification = new AdminNotification();
        $adminNotification->user_id = $order->user_id;
        $adminNotification->title = 'New order #' . $order->order_number . ' has been created';
        $adminNotification->click_url = urlPath('admin.order.index') . '?search=' . $order->order_number;
        $adminNotification->save();
    }

    private function validation($request) {
        $request->validate([
            'gateway'     => 'required',
            'currency'    => 'required',
        ]);
    }

    private function getGatewayCurrency($request) {
        $gatewayCurrency = null;

        if ($request->gateway != 0) {
            $gatewayCurrency = GatewayCurrency::whereHas('method', function ($gatewayCurrency) {
                $gatewayCurrency->where('status', Status::ENABLE);
            })->where('method_code', $request->gateway)->where('currency', $request->currency)->first();
        } else {
            // COD is selected
            if (!gs('cod')) {
                $gatewayCurrency = null;
            } else {
                $gatewayCurrency = (new GatewayCurrency())->codMethod();
            }
        }

        if (!$gatewayCurrency) {
            throw ValidationException::withMessages(['error' => 'Invalid gateway selected']);
        }

        return $gatewayCurrency;
    }

    private function getCheckoutData($hasPhysicalProduct) {
        $checkoutData = session('shipping_info');

        if (!$checkoutData && $hasPhysicalProduct) {
            throw ValidationException::withMessages(['error' => 'Invalid session data']);
        }

        return $checkoutData;
    }


    private function getShippingAddress($hasPhysicalProduct, $checkoutData) {
        $shippingAddress = null;

        if ($hasPhysicalProduct) {
            if (auth()->check()) {
                $shippingAddress = ShippingAddress::where('user_id', auth()->id())->find($checkoutData['shipping_address_id']);
            } else {
                $shippingAddress = (object) $checkoutData;
            }

            if (!$shippingAddress) {
                throw ValidationException::withMessages(['error' => 'Invalid session data']);
            }
        }

        return $shippingAddress;
    }

    private function getShippingMethod($hasPhysicalProduct, $checkoutData) {
        $shippingMethod = null;

        if ($hasPhysicalProduct) {
            $shippingMethod = ShippingMethod::active()->find($checkoutData['shipping_method_id']);

            if (!$shippingMethod) {
                throw ValidationException::withMessages(['error' => 'Invalid session data']);
            }
        }

        return $shippingMethod;
    }

    private function saveOrder($subtotal, $coupon, $gatewayCurrency, $cartData, $hasPhysicalProduct) {
        $checkoutData = $this->getCheckoutData($hasPhysicalProduct);

        $shippingAddress = $this->getShippingAddress($hasPhysicalProduct, $checkoutData);
        $shippingMethod  = $this->getShippingMethod($hasPhysicalProduct, $checkoutData);
        $guestUser       = session('guest_user_data');

        $couponAmount = $coupon->discount_amount ?? 0;
        $couponAmount = $couponAmount > $subtotal ? $subtotal : $couponAmount;

        $order               = new Order();
        $order->order_number = $this->getOrderNumber();
        $order->user_id      = auth()->id() ?? 0;
        $order->guest_id     = $guestUser->id ?? 0;

        if (auth()->check()) {
            $order->shipping_address   = $shippingAddress ? $this->setShippingAddress($shippingAddress) : null;
        } else {
            $order->shipping_address   = $shippingAddress ? $shippingAddress : null;
        }

        $order->shipping_method_id = $shippingMethod->id ?? 0;
        $order->shipping_charge    = $shippingMethod->charge ?? 0;
        $order->is_cod             = $gatewayCurrency->id ? 0 : 1;
        $order->payment_status     = Status::PAYMENT_INITIATE;
        $order->subtotal           = $subtotal;
        $order->total_amount       = getAmount($subtotal + ($shippingMethod->charge ?? 0) - $couponAmount);
        $order->save();

        $this->saveOrderDetails($cartData, $order->id);

        return $order;
    }

    private function getOrderNumber($digit = 5) {
        $prefix = 'OID-';
        $last = Order::max('id') + 1;
        $formattedLast = str_pad($last, $digit, '0', STR_PAD_LEFT);
        return $prefix . $formattedLast;
    }

    private function checkStock($cartData) {
        foreach ($cartData as $cart) {
            if ($cart->product->track_inventory) {
                $stockQuantity = $cart->product->inStock($cart->productVariant);

                if ($cart->quantity > $stockQuantity) {
                    $notify[] = ['error', 'Some products are stocked out'];
                    return to_route('cart.page')->withNotify($notify);
                }
            }
        }
    }

    private function  setShippingAddress(ShippingAddress $address) {
        return [
            'firstname' => $address->firstname,
            'lastname'  => $address->lastname,
            'mobile'    => $address->mobile,
            'country'   => $address->country,
            'city'      => $address->city,
            'state'     => $address->state,
            'zip'       => $address->zip,
            'address'   => $address->address,
        ];
    }

    private function saveOrderDetails($cartData, $orderId) {
        foreach ($cartData as $cartItem) {
            $prices = $cartItem->product->prices($cartItem->productVariant);
            $orderDetail                     = new OrderDetail();
            $orderDetail->order_id           = $orderId;
            $orderDetail->product_id         = $cartItem->product_id;
            $orderDetail->product_variant_id = $cartItem->product_variant_id ?? 0;
            $orderDetail->quantity           = $cartItem->quantity;
            $orderDetail->price              = $prices->sale_price;
            $orderDetail->discount           = $prices->regular_price - $prices->sale_price;
            $orderDetail->save();
            $this->updateStock($cartItem, $orderId);
        }
    }

    private function appliedCoupon($cartData, $subtotal) {
        $coupon = session('coupon');

        if (!$coupon) {
            return null;
        }

        // Match the coupon code with database and check is exists
        $coupon  = $this->cartManager->getCouponByCode($coupon['code']);

        if (!$coupon) {
            return ['error' => "Applied coupon is invalid or expired"];
        }


        $checkCoupon = $this->cartManager->isValidCoupon($coupon, $subtotal, $cartData);

        if (isset($checkCoupon['error'])) {
            return $checkCoupon;
        }

        $coupon->discount_amount = $coupon->discountAmount($subtotal);

        return $coupon;
    }

    private function updateStock($cartItem, $orderId) {
        if ($cartItem->productVariant) {
            $item = $cartItem->productVariant;
        } else {
            $item = $cartItem->product;
        }

        if ($item->track_inventory) {
            $item->in_stock -= $cartItem->quantity;
            $item->save();

            $description = "Sold $cartItem->quantity " . Str::plural('product', $cartItem->quantity);
            $productManager = new ProductManager();
            $productManager->createStockLog($cartItem->product, $cartItem->quantity, $description, $cartItem->productVariant, '-', $orderId);
        }
    }

    private function saveAppliedCoupon($coupon, $order) {
        $appliedCoupon            = new AppliedCoupon();
        $appliedCoupon->user_id   = auth()->id();
        $appliedCoupon->coupon_id = $coupon->id;
        $appliedCoupon->order_id  = $order->id;
        $appliedCoupon->amount    = $coupon->discount_amount > $order->subtotal ? $order->subtotal : $coupon->discount_amount;
        $appliedCoupon->save();
        session()->forget('coupon');
    }
}
