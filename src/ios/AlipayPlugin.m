/********* AlipayPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "AlipayPlugin.h"
#import <AlipaySDK/AlipaySDK.h>


@implementation AlipayPlugin

NSString *appScheme;

- (void)pay:(CDVInvokedUrlCommand*)command
{
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
  NSString *path = [[NSBundle mainBundle] bundlePath];
  NSString *finalPath = [path stringByAppendingPathComponent:@"Info.plist"];
  NSMutableDictionary* plistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:finalPath];
  appScheme = [[[plistDictionary objectForKey:@"CFBundleURLTypes"] firstObject] objectForKey:@"CFBundleURLSchemes"][0];
    
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

- (void)handleOpenURL:(NSNotification *)notification {
  if (appScheme == nil) return;
  
  NSURL *url = [notification object];
  if ([url isKindOfClass:[NSURL class]] && [url.absoluteString hasPrefix:[appScheme stringByAppendingString:@"://safepay/"]]) {
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
      
    }];
  }
}
@end