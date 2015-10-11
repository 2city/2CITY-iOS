//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MGRawView.h"

#define SLIDER_OFFSET_Y 0
#define SLIDER_DOT_COUNT 5

@class MGSlider;
@class MGRawView;

@protocol MGSliderDelegate <NSObject>

-(void) MGSlider:(MGSlider*)slider didSelectSliderView:(MGRawView*)rawView atIndex:(int)index;
-(void) MGSlider:(MGSlider*)slider didCreateSliderView:(MGRawView*)rawView atIndex:(int)index;
-(void) MGSlider:(MGSlider*)slider didPageControlClicked:(UIButton*)button atIndex:(int)index;

@end

@interface MGSlider : UIView <UIScrollViewDelegate>
{
    NSInteger _numberOfItems;
    int _currentIndex;
    UIView* _pageControl;
    NSTimer *_scrollingTimer;
    id <MGSliderDelegate> _delegate;
    BOOL _willShowPageControl;
    BOOL _scrollViewIsNil;
    BOOL _willAnimate;
}

@property (nonatomic, retain) id <MGSliderDelegate> delegate;
@property (nonatomic, assign) NSInteger numberOfItems;
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) UIView* pageControl;
@property (nonatomic, copy) NSString* nibName;
@property (nonatomic, copy) NSString* selectedImageName;
@property (nonatomic, copy) NSString* unselectedImageName;

-(void) setNeedsReLayoutWithViewSize:(CGSize)viewSize;
-(void) startAnimationWithDuration:(float)duration;
-(void) showPageControl:(BOOL)showing;
- (void)baseInit;

-(void)resumeAnimation;
-(void)stopAnimation;

@end
