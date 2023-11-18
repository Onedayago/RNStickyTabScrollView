#import <React/RCTViewComponentView.h>
#import <UIKit/UIKit.h>
#import "NestScrollView.h"
#import "RNScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNPageScrollView : RCTViewComponentView


@property NestScrollView *rootView;
@property NSMutableArray *childView;
@property bool scrollEnable;
@property NestScrollView *parentView;


- (void)setContentOffset:(float) x  y:(float)y;

- (void)setScroll: (bool) enable;

@end


NS_ASSUME_NONNULL_END
