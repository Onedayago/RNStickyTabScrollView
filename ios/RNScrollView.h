

#import <React/RCTViewComponentView.h>
#import <UIKit/UIKit.h>
#import "NestScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNScrollView : RCTViewComponentView

@property NestScrollView *rootView;
@property CGFloat lastY;
@end

NS_ASSUME_NONNULL_END
