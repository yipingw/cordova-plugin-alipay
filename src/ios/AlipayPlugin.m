/********* AlipayPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "AlipayPlugin.h"
#import <AlipaySDK/AlipaySDK.h>


@implementation AlipayPlugin

- (void)pay:(CDVInvokedUrlCommand*)command
{
    
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"mankr";

    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = [command.arguments objectAtIndex:0];
  
    if (orderString != nil) {
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            CDVPluginResult* pluginResult = nil;
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDic];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
        
    }
}
@end
