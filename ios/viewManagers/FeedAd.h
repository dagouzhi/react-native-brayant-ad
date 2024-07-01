

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

@interface FeedAd : UIView

-(void) setCodeId:(NSString *) codeid;
-(void) setAdWidth: (NSString *) width; 

-(void) loadFeedAd; 
@property (nonatomic, copy) RCTBubblingEventBlock onAdLayout;
@property (nonatomic, copy) RCTBubblingEventBlock onAdError;
@property (nonatomic, copy) RCTBubblingEventBlock onAdClick;
@property (nonatomic, copy) RCTBubblingEventBlock onAdClose;
@end
