


#import <React/RCTLog.h>
#import <React/RCTUIManager.h>
#import <React/RCTViewManager.h>

@interface  RNPageScrollViewManager: RCTViewManager
@end

@implementation RNPageScrollViewManager

RCT_EXPORT_MODULE(RNPageScrollView)
RCT_EXPORT_VIEW_PROPERTY(width, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(height, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(contentWidth, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(bounce, NSBoolean)
RCT_EXPORT_VIEW_PROPERTY(showsIndicator, NSBoolean)
RCT_EXPORT_VIEW_PROPERTY(onScroll, RCTDirectEventBlock)

@end
