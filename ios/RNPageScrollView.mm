

#import "RNPageScrollView.h"
#import "RNScrollView.h"
#import <react/renderer/components/RNScrollViewSpecs/ComponentDescriptors.h>
#import <react/renderer/components/RNScrollViewSpecs/EventEmitters.h>
#import <react/renderer/components/RNScrollViewSpecs/Props.h>
#import <react/renderer/components/RNScrollViewSpecs/RCTComponentViewHelpers.h>
#import "RCTFabricComponentsPlugins.h"
#import "RCTScrollViewComponentView.h"

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
      self.scrollView = [[MyScrollView alloc] initWithFrame:self.bounds];
      self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      self.contentView = self.scrollView;
      self.scrollView.pagingEnabled = false;
      self.scrollView.bounces = false;
      self.scrollView.delegate = self;
      self.scrollView.directionalLockEnabled = true;
      self.containerScrollView = [[NSMutableArray alloc]init];
      self.scrollView.showsVerticalScrollIndicator = false;
      self.scrollView.showsHorizontalScrollIndicator = false;
      self.scrollView.scrollEnabled = false;
      self.scrollEnalbe = false;
  }

  return self;
}


- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &oldViewProps = *std::static_pointer_cast<RNPageScrollViewProps const>(_props);
  const auto &newViewProps = *std::static_pointer_cast<RNPageScrollViewProps const>(props);

  if (oldViewProps.contentWidth != newViewProps.contentWidth) {
      self.scrollView.contentSize = CGSizeMake(newViewProps.contentWidth, self.frame.size.height);
  }

    if (oldViewProps.bounces != newViewProps.bounces) {
        self.scrollView.bounces = newViewProps.bounces;
    }

    if (oldViewProps.scrollEnable != newViewProps.scrollEnable) {
        self.scrollView.scrollEnabled = newViewProps.scrollEnable;
        self.scrollEnable = newViewProps.scrollEnable;
    }

    if (oldViewProps.showIndicator != newViewProps.showIndicator) {
        self.scrollView.showsVerticalScrollIndicator = newViewProps.showIndicator;
        self.scrollView.showsHorizontalScrollIndicator = newViewProps.showIndicator;
    }

    if (oldViewProps.width != newViewProps.width || oldViewProps.height != newViewProps.height) {
        self.scrollView.frame = CGRectMake(0, 0, newViewProps.width, newViewProps.height);
    }

  [super updateProps:props oldProps:oldProps];
}

- (void)mountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index
{

    if([childComponentView isKindOfClass:[RNScrollView class]]){
        RNScrollView *scrollView = (RNScrollView *)childComponentView;
        [self.containerScrollView addObject:scrollView];
    }
  [_scrollView insertSubview:childComponentView atIndex:index];
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
    self.parentView.scrollView.scrollEnabled = false;
    for(RNScrollView *myScrollView in self.containerScrollView){

        myScrollView.scrollView.scrollEnabled = false;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.parentView.scrollView.scrollEnabled = true;
    for(RNScrollView *myScrollView in self.containerScrollView){
        myScrollView.scrollView.scrollEnabled = true;
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

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    if(_eventEmitter){
//        std::dynamic_pointer_cast<const RNPageScrollViewEventEmitter>(_eventEmitter)->onScroll(RNPageScrollViewEventEmitter::OnScroll{
//        x: scrollView.contentOffset.x,
//        y: scrollView.contentOffset.y,
//        });
//    }
}

-(void)setContentOffset:(float) x y:(float) y
{
    CGPoint offset = CGPointMake(x, y);
    [self.scrollView setContentOffset:offset animated:true];
}

- (void)prepareForRecycle{
    self.scrollView.contentOffset = CGPointMake(0, 0);
    [super prepareForRecycle];
}



@end

Class<RCTComponentViewProtocol> RNPageScrollViewCls(void)
{
  return RNPageScrollView.class;
}
