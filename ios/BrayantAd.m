

#import "BrayantAd.h"

//穿山甲广告SDK
#import <BUAdSDK/BUAdSDK.h>
#import <BUAdSDK/BUAdSDKManager.h>
#import <BUAdSDK/BUNativeExpressRewardedVideoAd.h>
#import <BUAdSDK/BUNativeExpressFullscreenVideoAd.h>
#import <BUAdSDK/BURewardedVideoModel.h>

#import <React/RCTEventEmitter.h>
#import <React/RCTBridgeModule.h>
#if __has_include(<BUAdTestMeasurement/BUAdTestMeasurement.h>)
#import <BUAdTestMeasurement/BUAdTestMeasurement.h>
#endif

@implementation BrayantAd

static NSString *_appid = nil;

//缓存加载好的广告对象
static BUNativeExpressRewardedVideoAd *rewardAd = nil;
static BUNativeExpressFullscreenVideoAd *fullScreenAd = nil;

static BUNativeExpressRewardedVideoAd *rewardAdCache = nil;
static BUNativeExpressFullscreenVideoAd *fullScreenAdCache = nil;

static int rewardClicks = 0;

//保存js回调
static RCTPromiseResolveBlock adResolve;
static RCTPromiseRejectBlock adReject;

+ (void)saveResolve:(RCTPromiseResolveBlock)resolve {
    adResolve = resolve;
}

+ (RCTPromiseResolveBlock)getResolve{
    return adResolve;
}

+ (void)saveReject:(RCTPromiseRejectBlock)reject {
    adReject = reject;
}

+ (RCTPromiseRejectBlock)getReject {
    return adReject;
}

+(void)init:(NSString*) appid {
    _appid = appid;
#if __has_include(<BUAdTestMeasurement/BUAdTestMeasurement.h>)
    #if DEBUG
        // 测试工具
        [BUAdTestMeasurementConfiguration configuration].debugMode = YES;
    #endif
#endif
  BUAdSDKConfiguration *configuration = [BUAdSDKConfiguration configuration];
  configuration.appID = appid;//除appid外，其他参数配置按照项目实际需求配置即可。
  
  configuration.appLogoImage = [UIImage imageNamed:@"AppIcon"];
  [BUAdSDKManager startWithAsyncCompletionHandler:^(BOOL success, NSError *error) {
      if (success) {
          dispatch_async(dispatch_get_main_queue(), ^{
          //请求广告逻辑处理
          });
      }
  }];
    
}

+ (UIViewController *) getRootVC {
    return (UIViewController * )[UIApplication sharedApplication].delegate.window.rootViewController;
}


+ (void) initRewardAd:(NSString *)codeid userid:(NSString *)uid{
    //避免重复请求数据，每次加载会返回新的广告数据的
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = uid;
    rewardAd = [[BUNativeExpressRewardedVideoAd alloc] initWithSlotID:codeid rewardedVideoModel:model];
    [rewardAd loadAdData];
}

+ (BUNativeExpressRewardedVideoAd *)getRewardAd {
    return rewardAd;
}

+ (BUNativeExpressRewardedVideoAd *)getRewardAdCache {
    return rewardAdCache;
}

+ (void)setRewardAdCache: (BUNativeExpressRewardedVideoAd *)ad {
    rewardAdCache = ad;
}

+ (void)initFullScreenAd:(NSString *)codeid {
    //  # 避免重复请求数据，每次加载会返回新的广告数据的
    fullScreenAd = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:codeid];
    [fullScreenAd loadAdData];
}

+ (BUNativeExpressFullscreenVideoAd *)getFullScreenAd{
    return fullScreenAd;
}

+ (BUNativeExpressFullscreenVideoAd *)getFullScreenAdCache{
    return fullScreenAdCache;
}

+ (void)setFullScreenAdCache: (BUNativeExpressFullscreenVideoAd *)ad {
    fullScreenAdCache = ad;
}


//统计激励视频是否点击查看
+ (void)clickRewardVideo {
    rewardClicks = rewardClicks + 1;
}

+ (void)resetClickRewardVideo {
    rewardClicks = 0;
}

+ (int)getRewardVideoClicks {
    return rewardClicks;
}

@end
