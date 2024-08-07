

#import "NSString+LocalizedString.h"

NSString * const BUDemoStrings = @"BUDemoLanguage";

NSString * const Testads = @"test ads";
NSString * const AdsTitle = @"adsTitle";
NSString * const Width = @"width";
NSString * const Height = @"height";
NSString * const StartLocation = @"StartLocation";
NSString * const PermissionDenied = @"PermissionDenied";
NSString * const Coordinate = @"coordinate";
NSString * const LocationFailure = @"LocationFailure";
NSString * const Unknown = @"unknown";
NSString * const DrawTitle = @"drawTitle";
NSString * const DrawDescription = @"drawDescription";
NSString * const TestDescription = @"testDescription";
NSString * const Download = @"Download";
NSString * const LoadCollectionView = @"loadCollectionView";
NSString * const LoadView = @"loadView";
NSString * const CustomBtn = @"customBtn";
NSString * const NativeInterstitial = @"nativeInterstitial";
NSString * const ShowBanner = @"showBanner";
NSString * const ShowInterstitial = @"showInterstitial";
NSString * const ShowScrollBanner = @"showScrollBanner";
NSString * const Splash = @"splash";
NSString * const CustomCloseBtn = @"customCloseBtn";
NSString * const Skip = @"Skip";
NSString * const ShowFullScreenVideo = @"showFullScreenVideo";
NSString * const ShowRewardVideo = @"showRewardVideo";
NSString * const LocationOn = @"LocationOn";
NSString * const GetIDFA = @"getIDFA";
NSString * const ClickDownload = @"clickDownload";
NSString * const Call = @"call";
NSString * const ExternalLink = @"externalLink";
NSString * const InternalLink = @"internalLink";
NSString * const NoClick = @"noClick";
NSString * const CustomClick = @"customClick";
NSString * const Detail = @"detail";
NSString * const DownloadLinks = @"downloadLinks";
NSString * const URLLinks = @"URLLinks";

@implementation NSString (LocalizedString)

+ (NSString *)localizedStringForKey:(NSString *)key {
    if (key && [key isKindOfClass:[NSString class]]) {
        NSString *localizedString = NSLocalizedStringFromTable(key, BUDemoStrings, nil);
        return localizedString;
    }
    return @"Can’t find localizedString";
}

@end
