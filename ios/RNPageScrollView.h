#import <React/RCTViewComponentView.h>
#import <UIKit/UIKit.h>
#import "MyScrollView.h"
#import "RNScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNPageScrollView : RCTViewComponentView


@property MyScrollView *scrollView;
@property (readwrite) NSMutableArray *containerScrollView;
@property RNScrollView *parentView;


- (void)setContentOffset:(float) x  y:(float)y;
@end


NS_ASSUME_NONNULL_END
