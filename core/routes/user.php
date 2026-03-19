<?php

use Illuminate\Support\Facades\Route;

Route::namespace('User\Auth')->middleware('guest')->name('user.')->group(function () {

    Route::controller('LoginController')->group(function () {
        Route::get('/login', 'showLoginForm')->name('login');
        Route::post('/login', 'login');
        Route::get('logout', 'logout')->middleware('auth')->withoutMiddleware('guest')->name('logout');
    });

    Route::controller('RegisterController')->middleware(['guest'])->group(function () {
        Route::get('register', 'showRegistrationForm')->name('register');
        Route::post('register', 'register');
        Route::post('check-user', 'checkUser')->name('checkUser')->withoutMiddleware('guest');
    });

    Route::controller('ForgotPasswordController')->prefix('password')->name('password.')->group(function () {
        Route::get('reset', 'showLinkRequestForm')->name('request');
        Route::post('email', 'sendResetCodeEmail')->name('email');
        Route::get('code-verify', 'codeVerify')->name('code.verify');
        Route::post('verify-code', 'verifyCode')->name('verify.code');
    });

    Route::controller('ResetPasswordController')->group(function () {
        Route::post('password/reset', 'reset')->name('password.update');
        Route::get('password/reset/{token}', 'showResetForm')->name('password.reset');
    });

    Route::controller('SocialiteController')->group(function () {
        Route::get('social-login/{provider}', 'socialLogin')->name('social.login');
        Route::get('social-login/callback/{provider}', 'callback')->name('social.login.callback');
    });
});

Route::middleware('auth')->name('user.')->group(function () {

    Route::get('user-data', 'User\UserController@userData')->name('data');
    Route::post('user-data-submit', 'User\UserController@userDataSubmit')->name('data.submit');

    //authorization
    Route::middleware('registration.complete')->namespace('User')->controller('AuthorizationController')->group(function () {
        Route::get('authorization', 'authorizeForm')->name('authorization');
        Route::get('resend-verify/{type}', 'sendVerifyCode')->name('send.verify.code');
        Route::post('verify-email', 'emailVerification')->name('verify.email');
        Route::post('verify-mobile', 'mobileVerification')->name('verify.mobile');
    });

    Route::middleware(['check.status', 'registration.complete'])->group(function () {

        Route::namespace('User')->group(function () {

            Route::controller('UserController')->group(function () {
                Route::get('dashboard', 'home')->name('home');
                Route::any('payment/history', 'depositHistory')->name('deposit.history');
                Route::post('add-device-token', 'addDeviceToken')->name('add.device.token');
                Route::get('notifications', 'notifications')->name('notifications');
                Route::get('read-notification/{id}', 'readNotification')->name('notification.read');
            });

            Route::controller('UserController')->prefix('orders')->name('orders.')->group(function () {
                Route::get('', 'OrderController@allOrders')->name('all');
                Route::get('pending', 'OrderController@pendingOrders')->name('pending');
                Route::get('processing', 'OrderController@processingOrders')->name('processing');
                Route::get('dispatched', 'OrderController@dispatchedOrders')->name('dispatched');
                Route::get('completed', 'OrderController@completedOrders')->name('completed');
                Route::get('canceled', 'OrderController@canceledOrders')->name('canceled');
                Route::get('{order_number}', 'OrderController@orderDetails')->name('details');
            });

            //Profile setting
            Route::controller('ProfileController')->group(function () {
                Route::get('profile-setting', 'profile')->name('profile.setting');
                Route::post('profile-setting', 'submitProfile');
                Route::get('change-password', 'changePassword')->name('change.password');
                Route::post('change-password', 'submitPassword');

                Route::get('shipping-address', 'shippingAddress')->name('shipping.address');
                Route::post('shipping-address/store/{id?}', 'saveShippingAddress')->name('shipping.address.store');
                Route::post('shipping-address/delete/{id}', 'deleteShippingAddress')->name('shipping.address.delete');
            });

            Route::controller('ReviewController')->middleware('checkModule:product_review')->name('review.')->group(function () {
                Route::get('product-reviews', 'index')->name('index');
                Route::post('review/add', 'add')->name('add');
                Route::post('review/reply/{id}/{reply_id?}', 'reviewReply')->name('reply');
            });
        });
    });
});
