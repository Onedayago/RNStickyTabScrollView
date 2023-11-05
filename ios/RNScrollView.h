

#import <React/RCTViewComponentView.h>
#import <UIKit/UIKit.h>
#import "MyScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNScrollView : RCTViewComponentView


@property MyScrollView *scrollView;
@property UIView *firstView;
@property  CGFloat lastContainerY;

@end



NS_ASSUME_NONNULL_END
