

#import "RNScrollView.h"
#import "RNPageScrollView.h"
#import <react/renderer/components/RNScrollViewSpecs/ComponentDescriptors.h>
#import <react/renderer/components/RNScrollViewSpecs/EventEmitters.h>
#import <react/renderer/components/RNScrollViewSpecs/Props.h>
#import <react/renderer/components/RNScrollViewSpecs/RCTComponentViewHelpers.h>
#import "RCTFabricComponentsPlugins.h"

using namespace facebook::react;

@implementation NestScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return true;
}

@end

@interface RNScrollView () <RCTRNScrollViewViewProtocol, UIScrollViewDelegate>

@end

@implementation RNScrollView  {

    CGFloat stickyHeight;
    Boolean scrollUp;
    Boolean scrollDown;
    NSMutableArray *childView;
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
      self.rootView = [[NestScrollView alloc] initWithFrame:self.frame];
      self.rootView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      self.contentView = self.rootView;
      self.rootView.delegate = self;
      self.rootView.scrollEnabled = defaultProps->scrollEnable;
      self.rootView.showsVerticalScrollIndicator = defaultProps->showIndicator;
      self.rootView.showsHorizontalScrollIndicator = defaultProps->showIndicator;
      self.rootView.bounces = defaultProps->bounces;
      self.rootView.directionalLockEnabled = true;
      childView = [[NSMutableArray alloc]init];
      //初始化吸顶距离
      stickyHeight = 0;
      scrollUp = defaultProps->scrollUp;
      scrollDown = defaultProps->scrollDown;
  }

  return self;
}

- (void) initView
{

}

- (void)updateLayoutMetrics:(facebook::react::LayoutMetrics const &)layoutMetrics
           oldLayoutMetrics:(facebook::react::LayoutMetrics const &)oldLayoutMetrics
{
    self.rootView.frame = CGRectMake(0, 0, layoutMetrics.frame.size.width, layoutMetrics.frame.size.height);
    [super updateLayoutMetrics:layoutMetrics oldLayoutMetrics:oldLayoutMetrics];
}

- (void)mountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index
{
    if([childComponentView isKindOfClass:[RNPageScrollView class]]){
        pageScrollView = (RNPageScrollView *)childComponentView;
        pageScrollView.parentView = self.rootView;
        for(RNScrollView *view in pageScrollView.childView){
            view.rootView.delegate = self;
            [childView addObject:view];
        }
    }

  [self.rootView insertSubview:childComponentView atIndex:index];
}


- (void)unmountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index
{
  [childComponentView removeFromSuperview];
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &oldViewProps = *std::static_pointer_cast<RNScrollViewProps const>(_props);
  const auto &newViewProps = *std::static_pointer_cast<RNScrollViewProps const>(props);
    if(oldViewProps.bounces != newViewProps.bounces){
        self.rootView.bounces = newViewProps.bounces;
    }

    if(oldViewProps.scrollEnable != newViewProps.scrollEnable){
        self.rootView.scrollEnabled = newViewProps.scrollEnable;
    }

    if(oldViewProps.showIndicator != newViewProps.showIndicator){
        self.rootView.showsVerticalScrollIndicator = newViewProps.showIndicator;
        self.rootView.showsHorizontalScrollIndicator = newViewProps.showIndicator;
    }

    //动态更改 scrollView 可滚动距离
    if(oldViewProps.contentHeight != newViewProps.contentHeight){
        self.rootView.contentSize = CGSizeMake(self.frame.size.width, newViewProps.contentHeight);
    }

    if(oldViewProps.scrollUp != newViewProps.scrollUp){
        scrollUp = newViewProps.scrollUp;
    }

    if(oldViewProps.scrollDown != newViewProps.scrollDown){
        scrollDown = newViewProps.scrollDown;
    }

    if(oldViewProps.stickyHeight != newViewProps.stickyHeight){
        stickyHeight = newViewProps.stickyHeight;
    }

  [super updateProps:props oldProps:oldProps];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(stickyHeight){
        if (scrollView == self.rootView) {

            if(_eventEmitter){
                std::dynamic_pointer_cast<const RNScrollViewEventEmitter>(_eventEmitter)->onScroll(RNScrollViewEventEmitter::OnScroll{
                x: scrollView.contentOffset.x,
                y: scrollView.contentOffset.y,
                });
            }

            if(self.rootView.contentOffset.y <= stickyHeight && self.rootView.contentOffset.y >= 0){
                return;
            }
            if(scrollView.contentOffset.y > stickyHeight){
                self.rootView.contentOffset = CGPointMake(0, stickyHeight);
            }else{
                self.rootView.contentOffset = CGPointMake(0, 0);
            }

        } else{
            for(RNScrollView *view in childView){
                if(scrollView == view.rootView){
                    if(self.rootView.contentOffset.y < stickyHeight && self.rootView.contentOffset.y > 0){
                        view.rootView.contentOffset = CGPointMake(0, view.lastY);
                    }
                    view.lastY = scrollView.contentOffset.y;
                }
            }
        }
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [pageScrollView setScroll:false];
    if (scrollView == self.rootView) {
        self.lastY = self.rootView.contentOffset.y;
    }
    else {
        for(RNScrollView *view in childView){
            if(scrollView == view.rootView){
                view.lastY = scrollView.contentOffset.y;
            }
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

}

- (void)prepareForRecycle{

    self.rootView.contentOffset = CGPointMake(0, 0);

    for(RNScrollView *child in childView){
        child.rootView.contentOffset = CGPointMake(0, 0);
    }

    [super prepareForRecycle];
}

@end

Class<RCTComponentViewProtocol> RNScrollViewCls(void)
{
  return RNScrollView.class;
}
