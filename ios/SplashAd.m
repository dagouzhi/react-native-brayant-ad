

#import "SplashAd.h"

@interface SplashAd ()

@end

@implementation SplashAd

RCT_EXPORT_MODULE();

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

- (NSArray<NSString *> *)supportedEvents {
    return @[
        @"SplashAd-onAdClose",
        @"SplashAd-onAdSkip",
        @"SplashAd-onAdError",
        @"SplashAd-onAdClick",
        @"SplashAd-onAdShow"
    ];
}

RCT_EXPORT_METHOD(loadSplashAd:(NSDictionary *)options resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
{
    
    NSString  *codeid = options[@"codeid"];
    if(codeid == nil) {
        return;
    }
    
    NSString  *appid = options[@"appid"];
    if(appid != nil) {
        [AdBoss init:appid];
    }
    
    NSLog(@"Bytedance splash 开屏ios 代码位id %@", codeid);
  
  BUSplashAd * _splashAd = [[BUSplashAd alloc] initWithSlotID:codeid adSize:CGSizeMake(200, 200)];
  // 设置开屏广告代理
  _splashAd.delegate = self;
  // 加载广告
  [_splashAd loadAdData];
    resolve(@"结果：Splash Ad 成功");
}

//穿山甲开屏广告 回调
#pragma mark - Splash
- (void)addSplashAD {
  BUD_Log(@"addSplashAD");
}

- (void)splashAdLoadSuccess:(nonnull BUSplashAd *)splashAd {
  BUD_Log(@"splashAdLoadSuccess");
}

- (void)splashAdLoadFail:(nonnull BUSplashAd *)splashAd error:(BUAdError * _Nullable)error {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdRenderFail:(nonnull BUSplashAd *)splashAd error:(BUAdError * _Nullable)error {
    [self pbu_logWithSEL:_cmd msg:@""];
}


- (void)splashAdRenderSuccess:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdWillShow:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidShow:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClick:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClose:(nonnull BUSplashAd *)splashAd closeType:(BUSplashAdCloseType)closeType {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashCardReadyToShow:(nonnull BUSplashAd *)splashAd {
  
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashCardViewDidClick:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashCardViewDidClose:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdViewControllerDidClose:(BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashDidCloseOtherController:(nonnull BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType {
    [self pbu_logWithSEL:_cmd msg:@""];
}


- (void)splashVideoAdDidPlayFinish:(nonnull BUSplashAd *)splashAd didFailWithError:(nullable NSError *)error {
    [self pbu_logWithSEL:_cmd msg:@""];
}


- (void)splashZoomOutViewDidClick:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}


- (void)splashZoomOutViewDidClose:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashZoomOutReadyToShow:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}


- (void)pbu_logWithSEL:(SEL)sel msg:(NSString *)msg {
    CFTimeInterval endTime = CACurrentMediaTime();
    BUD_Log(@"SplashAdView In AppDelegate (%@) , extraMsg:%@", NSStringFromSelector(sel), msg);
}

@end


