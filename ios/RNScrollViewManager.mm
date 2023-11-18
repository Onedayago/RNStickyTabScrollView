

#import <React/RCTLog.h>
#import <React/RCTUIManager.h>
#import <React/RCTViewManager.h>

@interface  RNScrollViewManager: RCTViewManager
@end

@implementation RNScrollViewManager

RCT_EXPORT_MODULE(RNScrollView)
RCT_EXPORT_VIEW_PROPERTY(stickyHeight, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(contentHeight, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(bounces, bool)
RCT_EXPORT_VIEW_PROPERTY(showIndicator, bool)
RCT_EXPORT_VIEW_PROPERTY(scrollEnable, bool)
RCT_EXPORT_VIEW_PROPERTY(scrollUp, NSBoolean)
RCT_EXPORT_VIEW_PROPERTY(scrollDown, NSBoolean)
RCT_EXPORT_VIEW_PROPERTY(onScroll, RCTDirectEventBlock);
@end
