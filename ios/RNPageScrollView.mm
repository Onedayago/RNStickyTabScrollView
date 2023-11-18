

#import "RNPageScrollView.h"
#import "RNScrollView.h"
#import <react/renderer/components/RNScrollViewSpecs/ComponentDescriptors.h>
#import <react/renderer/components/RNScrollViewSpecs/EventEmitters.h>
#import <react/renderer/components/RNScrollViewSpecs/Props.h>
#import <react/renderer/components/RNScrollViewSpecs/RCTComponentViewHelpers.h>
#import "RCTFabricComponentsPlugins.h"


using namespace facebook::react;


@interface RNPageScrollView () <RCTRNPageScrollViewViewProtocol, UIScrollViewDelegate>

@end

@implementation RNPageScrollView  {

}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<RNPageScrollViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
     static const auto defaultProps = std::make_shared<const RNPageScrollViewProps>();
     _props = defaultProps;
      self.rootView = [[NestScrollView alloc] initWithFrame:self.frame];
      self.rootView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      self.contentView = self.rootView;
      self.rootView.pagingEnabled = true;
      self.rootView.directionalLockEnabled = true;
      self.rootView.delegate = self;
      self.childView = [[NSMutableArray alloc]init];
      self.rootView.bounces = defaultProps->bounces;
      self.rootView.showsVerticalScrollIndicator = defaultProps->showIndicator;
      self.rootView.showsHorizontalScrollIndicator = defaultProps->showIndicator;
      self.rootView.scrollEnabled = defaultProps->scrollEnable;
      self.scrollEnable = defaultProps->scrollEnable;
  }

  return self;
}


- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &oldViewProps = *std::static_pointer_cast<RNPageScrollViewProps const>(_props);
  const auto &newViewProps = *std::static_pointer_cast<RNPageScrollViewProps const>(props);

  if (oldViewProps.contentWidth != newViewProps.contentWidth) {
      self.rootView.contentSize = CGSizeMake(newViewProps.contentWidth, self.frame.size.height);
  }

    if (oldViewProps.bounces != newViewProps.bounces) {
        self.rootView.bounces = newViewProps.bounces;
    }

    if (oldViewProps.scrollEnable != newViewProps.scrollEnable) {
        self.rootView.scrollEnabled = newViewProps.scrollEnable;
        self.scrollEnable = newViewProps.scrollEnable;
    }

    if (oldViewProps.showIndicator != newViewProps.showIndicator) {
        self.rootView.showsVerticalScrollIndicator = newViewProps.showIndicator;
        self.rootView.showsHorizontalScrollIndicator = newViewProps.showIndicator;
    }

  [super updateProps:props oldProps:oldProps];
}

- (void)updateLayoutMetrics:(facebook::react::LayoutMetrics const &)layoutMetrics
           oldLayoutMetrics:(facebook::react::LayoutMetrics const &)oldLayoutMetrics
{
    self.rootView.frame = CGRectMake(0, 0, layoutMetrics.frame.size.width, layoutMetrics.frame.size.height);
    [super updateLayoutMetrics:layoutMetrics oldLayoutMetrics:oldLayoutMetrics];
}

- (void)mountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index
{

    if([childComponentView isKindOfClass:[RNScrollView class]]){
        RNScrollView *view = (RNScrollView *)childComponentView;
        [self.childView addObject:view];
    }
  [self.rootView insertSubview:childComponentView atIndex:index];
}


- (void)unmountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index
{
  [childComponentView removeFromSuperview];
}

- (void)handleCommand:(NSString const *)commandName args:(NSArray const *)args
{
    RCTRNPageScrollViewHandleCommand(self, commandName, args);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.parentView.scrollEnabled = false;
    for(RNScrollView *view in self.childView){
        view.rootView.scrollEnabled = false;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.parentView.scrollEnabled = true;
    for(RNScrollView *view in self.childView){
        view.rootView.scrollEnabled = true;
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(_eventEmitter){
        std::dynamic_pointer_cast<const RNPageScrollViewEventEmitter>(_eventEmitter)->onScroll(RNPageScrollViewEventEmitter::OnScroll{
        x: scrollView.contentOffset.x,
        y: scrollView.contentOffset.y,
        });
    }
}

- (void)setScroll: (bool) enable
{
    if(self.scrollEnable){
        self.rootView.scrollEnabled = enable;
    }
}

-(void)setContentOffset:(float) x y:(float) y
{
    CGPoint offset = CGPointMake(x, y);
    [self.rootView setContentOffset:offset animated:true];
}

- (void)prepareForRecycle{
    self.rootView.contentOffset = CGPointMake(0, 0);
    [self.childView removeAllObjects];
    [super prepareForRecycle];
}



@end

Class<RCTComponentViewProtocol> RNPageScrollViewCls(void)
{
  return RNPageScrollView.class;
}
