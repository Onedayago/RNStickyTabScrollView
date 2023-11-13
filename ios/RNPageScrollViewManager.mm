

#import <React/RCTLog.h>
#import <React/RCTUIManager.h>
#import <React/RCTViewManager.h>

@interface  RNScrollViewManager: RCTViewManager
@end

@implementation RNScrollViewManager

RCT_EXPORT_MODULE(RNScrollView)
RCT_EXPORT_VIEW_PROPERTY(width, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(stickyHeight, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(height, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(contentHeight, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(bounces, NSBoolean)
RCT_EXPORT_VIEW_PROPERTY(showIndicator, NSBoolean)
RCT_EXPORT_VIEW_PROPERTY(scrollEnable, NSBoolean)
RCT_EXPORT_VIEW_PROPERTY(scrollUp, NSBoolean)
RCT_EXPORT_VIEW_PROPERTY(scrollDown, NSBoolean)
@end
