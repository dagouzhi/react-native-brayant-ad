

#import "FeedAd.h"
#include "AdBoss.h"
#import <BUAdSDK/BUNativeExpressAdManager.h>
#import <BUAdSDK/BUNativeExpressAdView.h>

#import <BUAdSDK/BUAdSDK.h>

@interface FeedAd ()<BUNativeExpressAdViewDelegate,BUNativeAdsManagerDelegate>

@property (strong, nonatomic) NSMutableArray<__kindof BUNativeExpressAdView *> *expressAdViews;
@property (strong, nonatomic) BUNativeExpressAdManager *nativeExpressAdManager;
@property (nonatomic, strong) BUNativeAdsManager *adManager;

@property(nonatomic, strong) NSString *_codeid;
@property(nonatomic) NSInteger _adwidth ;

@end

@implementation FeedAd


- (void)setCodeId:(NSString *)codeid {
  self._codeid = codeid;
  NSLog(@"开始 加载Feed广告 codeid: %@", self._codeid);
  [self loadFeedAd];
}

- (void)setAdWidth:(NSString *)width {
  self._adwidth = [width integerValue];
  NSLog(@"开始 加载Feed广告 adwidth: %ld", self._adwidth);
  [self loadFeedAd];
}

/**
 模版渲染
 */
-(void) loadFeedAd{
  if(self._codeid == nil) {
    return;
  }
  
  if(!self._adwidth){
    self._adwidth  = 228;  //默认feed尺寸 228 * 150
  }
  BUAdSlot *slot1 = [[BUAdSlot alloc] init];
  slot1.ID = self._codeid;
  slot1.AdType = BUAdSlotAdTypeFeed;
  BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Banner600_150];
  slot1.imgSize = imgSize;
  slot1.position = BUAdSlotPositionFeed;
  // self.nativeExpressAdManager可以重用
  if (!self.nativeExpressAdManager) {
    self.nativeExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot1 adSize:CGSizeMake(self._adwidth, 180)];
  }
  self.nativeExpressAdManager.adSize = CGSizeMake(self._adwidth,180);
  self.nativeExpressAdManager.delegate = self;
  [self.nativeExpressAdManager loadAdDataWithCount:1];
}

/**
 自渲染
 */
//- (void)loadFeedAd{
//    
//    if(self._codeid == nil) {
//        return;
//    }
//    
//    if(!self._adwidth){
//        self._adwidth  = 228;  //默认feed尺寸 228 * 150
//    }
//    
//    if (!self.expressAdViews) {
//        self.expressAdViews = [NSMutableArray arrayWithCapacity:20];
//    }
//    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
//    slot1.ID = self._codeid;
//    slot1.AdType = BUAdSlotAdTypeFeed;
//  slot1.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
//  BUNativeAdsManager *nad = [[BUNativeAdsManager alloc]initWithSlot:slot1];
//  nad.adSize = CGSizeMake(400, 0);
//  // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
//  nad.delegate = self;
//  nad.nativeExpressAdViewDelegate = self;
//  self.adManager = nad;
//  [nad loadAdDataWithCount:3];
//}

#pragma mark - BUNativeExpressAdViewDelegate
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAd views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
  BUD_Log(@"feed ad success to load");
  //清空准备显示
  [self.expressAdViews removeAllObjects];
  
  //【重要】不能保存太多view，需要在合适的时机手动释放不用的，否则内存会过大
  if (views.count) {
    [self.expressAdViews addObjectsFromArray:views];
    [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)obj;
      dispatch_async(dispatch_get_main_queue(), ^{
        [expressView render];
      });
    }];
  }
  BUD_Log(@"feed ad 个性化模板拉取广告成功回调");
}

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error {
  BUD_Log(@"feed ad faild to load");
  self.onAdError(@{
    @"message":[error localizedDescription],
  });
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
  BUD_Log(@"feed ad render success");
  [self addSubview:nativeExpressAdView];
}

- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {
  BUD_Log(@"feed ad render fail %@", error);
  self.onAdError(@{
    @"message":[error localizedDescription],
  });
}

- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView {
  CGFloat adWidth = nativeExpressAdView.bounds.size.width;
  BUD_Log(@"adWidth %f", adWidth);
  CGFloat adHeight = nativeExpressAdView.bounds.size.height;
  BUD_Log(@"adHeight %f", adHeight);
  self.onAdLayout(@{
    @"width":@(adWidth),
    @"height":@(adHeight)
  });
}

- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView {
  //FIXME: 模拟器里点击详情按钮没反应
  BUD_Log(@"feed ad clicked");
  self.onAdClick(@{
    @"message": @"ad been clicked",
  });
}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
  //【重要】需要在点击叉以后 在这个回调中移除视图，否则，会出现用户点击叉无效的情况
  [self.expressAdViews removeObject:nativeExpressAdView];
  [self willRemoveSubview:nativeExpressAdView];
  self.onAdClose(@{
     @"message":filterWords[0].name,
    });
}

- (void)nativeExpressAdViewDidClosed:(BUNativeExpressAdView *)nativeExpressAdView {
  //FIXME: 模拟器里点击关闭按钮没反应
  self.onAdClose(@{
    @"message": @"ad closed",
  });
}

- (void)nativeExpressAdViewWillPresentScreen:(BUNativeExpressAdView *)nativeExpressAdView {
  
}

#pragma mark - BUNativeAdsManagerDelegate

- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
  BUD_Log(@"feed ad 个性化模板拉取广告成功回调 --- nativeAds");
}



- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
  BUD_Log(@"feed ad 个性化模板拉取广告成功回调 --- didFailWithError---%@",error);
}

@end
