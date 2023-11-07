

#import "RNScrollView.h"
#import "RNPageScrollView.h"
#import <react/renderer/components/RNScrollViewSpecs/ComponentDescriptors.h>
#import <react/renderer/components/RNScrollViewSpecs/EventEmitters.h>
#import <react/renderer/components/RNScrollViewSpecs/Props.h>
#import <react/renderer/components/RNScrollViewSpecs/RCTComponentViewHelpers.h>
#import <react/renderer/components/RNScrollViewSpecs/RCTComponentViewHelpers.h>
#import "RCTFabricComponentsPlugins.h"
#import "RCTScrollViewComponentView.h"

using namespace facebook::react;


@implementation MyScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return true;

}

@end

@interface RNScrollView () <RCTRNScrollViewViewProtocol, UIScrollViewDelegate>

@end

@implementation RNScrollView  {
//    MyScrollView *containerScrollView;
    NSMutableArray *containerScrollView;
    CGFloat lastRootY;
    CGFloat stickyHeight;
    RNPageScrollView *pageScrollView;
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
      self.scrollView.directionalLockEnabled = true;
      containerScrollView = [[NSMutableArray alloc]init];
      self.scrollView.showsVerticalScrollIndicator = false;
      self.scrollView.showsHorizontalScrollIndicator = false;
  }

  return self;
}

- (void)updateLayoutMetrics:(facebook::react::LayoutMetrics const &)layoutMetrics
           oldLayoutMetrics:(facebook::react::LayoutMetrics const &)oldLayoutMetrics
{
    [super updateLayoutMetrics:layoutMetrics oldLayoutMetrics:oldLayoutMetrics];
}

- (void)mountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index
{

    if([childComponentView isKindOfClass:[RNPageScrollView class]]){
        pageScrollView = (RNPageScrollView *)childComponentView;
        pageScrollView.parentView = self;
        for(RNScrollView *myScrollView in pageScrollView.containerScrollView){

            myScrollView.scrollView.delegate = self;
            [containerScrollView addObject:myScrollView];
        }
    }

//    if(index == 0){
//        self.firstView = childComponentView;
//        self.scrollView.contentSize = CGSizeMake(childComponentView.frame.size.width, childComponentView.frame.size.height);
//    }else{
//        self.scrollView.contentSize = CGSizeMake(self.firstView.frame.size.width, self.firstView.frame.size.height);
//        NSLog(@"%f",self.firstView.frame.size.height);
//    }

  [_scrollView insertSubview:childComponentView atIndex:index];
}


- (void)unmountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index
{
  [childComponentView removeFromSuperview];
//    self.scrollView.contentSize = CGSizeMake(self.firstView.frame.size.width, self.firstView.frame.size.height);
//    NSLog(@"%f",self.firstView.frame.size.height);
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

    if (oldViewProps.bounces != newViewProps.bounces) {
        self.scrollView.bounces = newViewProps.bounces;
    }

    if (oldViewProps.showIndicator != newViewProps.showIndicator) {
        self.scrollView.showsVerticalScrollIndicator = newViewProps.showIndicator;
        self.scrollView.showsHorizontalScrollIndicator = newViewProps.showIndicator;
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
    pageScrollView.scrollView.scrollEnabled = false;
    if (scrollView == self.scrollView) {
        lastRootY = self.scrollView.contentOffset.y;
    }
    else {
        for(RNScrollView *myScrollView in containerScrollView){
            if(scrollView == myScrollView.scrollView){
                myScrollView.lastContainerY = scrollView.contentOffset.y;
            }
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    pageScrollView.scrollView.scrollEnabled = true;
}

- (void)prepareForRecycle{
    self.scrollView.contentOffset = CGPointMake(0, 0);

    for(RNScrollView *myScrollView in containerScrollView){
        myScrollView.scrollView.contentOffset = CGPointMake(0, 0);
    }
    [super prepareForRecycle];
}

@end

Class<RCTComponentViewProtocol> RNScrollViewCls(void)
{
  return RNScrollView.class;
}
