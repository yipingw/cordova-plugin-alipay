package com.vapps.alipay;

/**
 * 这个插件是基于支付宝实现的的phonegap插件.
 * 该插件封装了支付宝的快捷支付模块.
 * 其中的一些业务数据还需要再次根据需求来处理.
 *
 * Copyright (c) Ruijin Xia
 *
 */

import com.alipay.sdk.app.PayTask;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;

public class AlipayPlugin extends CordovaPlugin  {

    public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) {

        if (action.equals("pay")) {
            try{
                // 完整的符合支付宝参数规范的订单信息
                final String payInfo = args.optString(0);
                Runnable payRunnable = new Runnable() {

                    @Override
                    public void run() {
                        // 构造PayTask 对象
                        PayTask alipay = new PayTask(cordova.getActivity());
                        // 调用支付接口
                        String result = alipay.pay(payInfo, true);

                        //Log.i(TAG, "result = " + result);
                        callbackContext.success(result); // Thread-safe.
                    }
                };

                Thread payThread = new Thread(payRunnable);
                payThread.start();

                return true;

            }catch(Exception ex){
                callbackContext.error("支付不成功！");
                return false;
            }

        }else {

            callbackContext.error("Invalid Action");
            return false;
        }

    }
}