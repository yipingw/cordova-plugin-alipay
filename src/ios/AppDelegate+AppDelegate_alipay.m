//
//  AppDelegate+AppDelegate_alipay.m
//  mankr
//
//  Created by Yiping Wang on 10/15/15.
//
//

#import "AppDelegate+AppDelegate_alipay.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation AppDelegate (alipay)

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
    NSLog(@"result");
  }];
  
  return YES;
}

@end
