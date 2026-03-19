<?php

namespace App\Http\Controllers\Gateway;

use App\Constants\Status;
use App\Http\Controllers\Controller;
use App\Lib\FormProcessor;
use App\Models\AdminNotification;
use App\Models\Deposit;
use Illuminate\Http\Request;

class PaymentController extends Controller {
    public function depositConfirm() {
        $track = session()->get('Track');

        $deposit = Deposit::where('trx', $track)
            ->where('status', Status::PAYMENT_INITIATE)
            ->orderBy('id', 'DESC')
            ->with('gateway')
            ->firstOrFail();

        if ($deposit->method_code >= 1000) {
            return  to_route('deposit.manual.confirm');
        }

        $dirName = $deposit->gateway->alias;
        $new = __NAMESPACE__ . '\\' . $dirName . '\\ProcessController';

        $data = $new::process($deposit);
        $data = json_decode($data);

        if (isset($data->error)) {
            $notify[] = ['error', $data->message];
            return back()->withNotify($notify);
        }
        if (isset($data->redirect)) {
            return redirect($data->redirect_url);
        }

        // for Stripe V3
        if(isset($data->session)){
            $deposit->btc_wallet = $data->session->id;
            $deposit->save();
        }

        $pageTitle = 'Payment Confirm';
        return view("Template::$data->view", compact('data', 'pageTitle', 'deposit'));
    }


    public static function userDataUpdate($deposit, $isManual = null) {
        if ($deposit->status == Status::PAYMENT_INITIATE || $deposit->status == Status::PAYMENT_PENDING) {
            $deposit->status = Status::PAYMENT_SUCCESS;
            $deposit->save();


            $order = $deposit->order;
            $order->payment_status = Status::PAYMENT_SUCCESS;
            $order->save();

            if (!$isManual) {

                if ($order->user_id) {
                    cartManager()->clearUserCart('user_id', $order->user_id);
                } else {
                    cartManager()->clearUserCart('session_id', $order->guest->session_id);
                }

                session()->forget('shipping_info');
                session()->forget('order_id');

                $adminNotification            = new AdminNotification();
                $adminNotification->user_id   = $deposit->user_id;
                $adminNotification->title     = 'Payment succeeded via ' . $deposit->methodName();
                $adminNotification->click_url = urlPath('admin.deposit.successful');
                $adminNotification->save();
            }

            notify($deposit->customer, $isManual ? 'PAYMENT_APPROVE' : 'PAYMENT_COMPLETE', [
                'method_name'     => $deposit->methodName(),
                'method_currency' => $deposit->method_currency,
                'method_amount'   => showAmount($deposit->final_amount, currencyFormat: false),
                'amount'          => showAmount($deposit->amount, currencyFormat: false),
                'charge'          => showAmount($deposit->charge, currencyFormat: false),
                'rate'            => showAmount($deposit->rate, currencyFormat: false),
                'trx'             => $deposit->trx,
            ]);

            sendOrderPlacedNotification($deposit->customer, $order);
        }
    }

    public function manualDepositConfirm() {
        $track = session()->get('Track');
        $data = Deposit::with('gateway')->where('status', Status::PAYMENT_INITIATE)->where('trx', $track)->first();
        abort_if(!$data, 404);
        if ($data->method_code > 999) {
            $pageTitle = 'Confirm Payment';
            $method = $data->gatewayCurrency();
            $gateway = $method->method;
            return view('Template::user.payment.manual', compact('data', 'pageTitle', 'method', 'gateway'));
        }
        abort(404);
    }

    public function manualDepositUpdate(Request $request) {
        $track = session()->get('Track');
        $deposit = Deposit::with('gateway', 'order')->where('status', Status::PAYMENT_INITIATE)->where('trx', $track)->first();
        abort_if(!$deposit, 404);
        $gatewayCurrency = $deposit->gatewayCurrency();
        $gateway = $gatewayCurrency->method;
        $formData = $gateway->form->form_data ?? [];

        $formProcessor = new FormProcessor();
        $validationRule = $formProcessor->valueValidation($formData);
        $request->validate($validationRule);
        $userData = $formProcessor->processFormData($request, $formData);

        if ($deposit->order->user_id) {
            cartManager()->clearUserCart('user_id', $deposit->order->user_id);
        } else {
            cartManager()->clearUserCart('session_id', $deposit->order->guest->session_id);
        }

        session()->forget('shipping_info');
        session()->forget('order_id');

        $deposit->detail = $userData;
        $deposit->status = Status::PAYMENT_PENDING;
        $deposit->save();

        $adminNotification = new AdminNotification();
        $adminNotification->user_id = $deposit->user_id;
        $adminNotification->title = 'Payment request from ' . ($deposit->customer->fullname);
        $adminNotification->click_url = urlPath('admin.deposit.details', $deposit->id);
        $adminNotification->save();

        notify($deposit->customer, 'PAYMENT_REQUEST', [
            'method_name' => $deposit->methodName(),
            'method_currency' => $deposit->method_currency,
            'method_amount' => showAmount($deposit->final_amount, currencyFormat: false),
            'amount' => showAmount($deposit->amount, currencyFormat: false),
            'charge' => showAmount($deposit->charge, currencyFormat: false),
            'rate' => showAmount($deposit->rate, currencyFormat: false),
            'trx' => $deposit->trx
        ]);

        $notify[] = ['success', 'Your payment request has been taken'];
        return  to_route('checkout.confirmation', $deposit->order->order_number)->withNotify($notify);
    }
}
