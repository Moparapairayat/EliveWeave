<?php

namespace App\Http\Controllers\User;

use App\Constants\Status;
use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\OrderDetail;

class OrderController extends Controller {

    protected $pageTitle;

    protected function orders($scope = null) {
        $orders = Order::isValidOrder()->where('user_id', auth()->id());

        if ($scope) {
            $orders->$scope();
        }

        $orders = $orders->with('orderDetail')->latest()->paginate(getPaginate());
        $pageTitle = $this->pageTitle;
        return view('Template::user.orders.index', compact('pageTitle', 'orders'));
    }

    function allOrders() {
        $this->pageTitle = 'All Orders';
        return $this->orders();
    }

    function pendingOrders() {
        $this->pageTitle = 'Pending Orders';
        return $this->orders('pending');
    }

    function processingOrders() {
        $this->pageTitle = 'Processing Orders';
        return $this->orders('processing');
    }

    function dispatchedOrders() {
        $this->pageTitle = 'Dispatched Orders';
        return $this->orders('dispatched');
    }

    function completedOrders() {
        $this->pageTitle = 'Completed Orders';
        return $this->orders('delivered');
    }

    function canceledOrders() {
        $this->pageTitle = 'Cancelled Orders';
        return $this->orders('canceled');
    }

    public function orderDetails($orderNumber) {
        $pageTitle = 'Order Details';

        $order = Order::where('order_number', $orderNumber)->with('deposit', 'orderDetail.product', 'orderDetail.productVariant', 'appliedCoupon')->firstOrFail();

        if ($order->user_id && $order->user_id !=  auth()->id()) {
            abort(404);
        }

        $layout = $order->user_id ? 'user': 'master';

        return view('Template::user.orders.details', compact('order', 'pageTitle', 'layout'));
    }

    public function download($id) {
        try {
            $id = decrypt($id);

            $orderDetail = OrderDetail::whereHas('order', function ($query) {
                $query->delivered()->where('payment_status', Status::PAYMENT_SUCCESS);
            })->with('digitalFile.fileable', 'product.digitalFile')->findOrFail($id);

            if ($orderDetail->order->user_id && $orderDetail->order->user_id != auth()->id()) {
                abort(403);
            }

            $digitalFile = $orderDetail->digitalFile ?? $orderDetail->product->digitalFile;

            if (!$digitalFile) {
                $notify[] = ['error', 'The file you are looking for does not exist.'];
                return back()->withNotify($notify);
            }

            $fullPath = getFilePath('digitalProductFile') . '/' . $digitalFile->name;
            $mimetype = mime_content_type($fullPath);
            header('Content-Disposition: attachment; filename="' . slug($orderDetail->product->name) . '.' . pathinfo($digitalFile->name, PATHINFO_EXTENSION) . '";');
            header("Content-Type: " . $mimetype);
            return readfile($fullPath);
        } catch (\Exception $e) {
            $notify[] = ['error', 'The file you are looking for does not exist.'];
            return back()->withNotify($notify);
        }
    }
}
