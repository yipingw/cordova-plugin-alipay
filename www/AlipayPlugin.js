var exec = require('cordova/exec');


var Alipay = function() {};

Alipay.prototype.alipay = function(payInfo, successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function() {}
    }

    if (typeof errorCallback != "function") {
        console.log("errorCallback failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("successCallback failure: success callback parameter must be a function");
        return;
    }

    if (!payInfo) {
        errorCallback('参数错误！');
        return;
    }
    //{"out_trade_no":out_trade_no, "subject": subject,"bodtxt":bodtxt, "total_fee": total_fee, "callbackUrl": callbackUrl}
    exec(successCallback, errorCallback, 'AlipayPlugin', 'pay', [payInfo]);
};

var alipay = new Alipay();
module.exports = alipay;