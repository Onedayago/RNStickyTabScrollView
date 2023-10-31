

#import "RNScrollView.h"
#import <react/renderer/components/RNScrollViewSpecs/ComponentDescriptors.h>
#import <react/renderer/components/RNScrollViewSpecs/EventEmitters.h>
#import <react/renderer/components/RNScrollViewSpecs/Props.h>
#import <react/renderer/components/RNScrollViewSpecs/RCTComponentViewHelpers.h>
#import <react/renderer/components/RNScrollViewSpecs/RCTComponentViewHelpers.h>
#import "RCTFabricComponentsPlugins.h"
#import "RCTScrollViewComponentView.h"

using namespace facebook::react;

@interface MyScrollView : UIScrollView

@end

@implementation MyScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if(gestureRecognizer.state !=0 ){
        NSLog(@"it works");
        return true;
    }
    return false;

}

@end

@interface RNScrollView () <RCTRNScrollViewViewProtocol, UIScrollViewDelegate>

@property MyScrollView *scrollView;
@property  CGFloat lastContainerY;
@end

@implementation RNScrollView  {
//    MyScrollView *containerScrollView;
    NSMutableArray *containerScrollView;
    CGFloat lastRootY;
    CGFloat stickyHeight;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<RNScrollViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
     static const auto defaultProps = std::make_shared<const RNScrollViewProps>();
     _props = defaultProps;
      self.scrollView = [[MyScrollView alloc] initWithFrame:self.bounds];
      self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      self.contentView = self.scrollView;
      self.scrollView.delegate = self;
      self.scrollView.bounces = false;
      containerScrollView = [[NSMutableArray alloc]init];
  }

  return self;
}



- (void)mountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index
{
    if([childComponentView isKindOfClass:[RNScrollView class]]){
        RNScrollView *scrollView = (RNScrollView *)childComponentView;
        [containerScrollView addObject:scrollView];
        [scrollView scrollView].delegate = self;

    }
  [_scrollView insertSubview:childComponentView atIndex:index];
}



- (void)unmountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index
{
  [childComponentView removeFromSuperview];
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &oldViewProps = *std::static_pointer_cast<RNScrollViewProps const>(_props);
  const auto &newViewProps = *std::static_pointer_cast<RNScrollViewProps const>(props);

  if (oldViewProps.contentHeight != newViewProps.contentHeight) {
      self.scrollView.contentSize = CGSizeMake(self.frame.size.width, newViewProps.contentHeight);
  }

    if (oldViewProps.stickyHeight != newViewProps.stickyHeight) {
        stickyHeight = newViewProps.stickyHeight;
    }


  [super updateProps:props oldProps:oldProps];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(stickyHeight){
        if (scrollView == self.scrollView) {

            if(self.scrollView.contentOffset.y <= stickyHeight && self.scrollView.contentOffset.y >= 0){
                return;
            }
            if(scrollView.contentOffset.y > stickyHeight){
                self.scrollView.contentOffset = CGPointMake(0, stickyHeight);
            }else{
                self.scrollView.contentOffset = CGPointMake(0, 0);
            }

        } else{
            for(RNScrollView *myScrollView in containerScrollView){
                if(scrollView == myScrollView.scrollView){
                    if(self.scrollView.contentOffset.y < stickyHeight && self.scrollView.contentOffset.y > 0){
                        [myScrollView scrollView].contentOffset = CGPointMake(0, myScrollView.lastContainerY);
                    }
                    myScrollView.lastContainerY = scrollView.contentOffset.y;
                }
            }

        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        lastRootY = self.scrollView.contentOffset.y;
    }else {
        for(RNScrollView *myScrollView in containerScrollView){
            if(scrollView == myScrollView.scrollView){
                myScrollView.lastContainerY = scrollView.contentOffset.y;
            }
        }
    }
}

@end

Class<RCTComponentViewProtocol> RNScrollViewCls(void)
{
  return RNScrollView.class;
}
