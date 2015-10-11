//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//


#import "MGSlider.h"

@implementation MGSlider

@synthesize numberOfItems = _numberOfItems;
@synthesize scrollView;
@synthesize nibName;
@synthesize delegate = _delegate;
@synthesize pageControl = _pageControl;
@synthesize selectedImageName;
@synthesize unselectedImageName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect rectScrollView = self.frame;
        rectScrollView.origin.y = 0;
        scrollView = [[UIScrollView alloc] initWithFrame:rectScrollView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    _numberOfItems = 0;
    _pageControl = nil;
    selectedImageName = nil;
    unselectedImageName = nil;
    _willShowPageControl = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //    [self setNeedsReLayout];
}

-(void) createPageControl {
    CGRect rect = self.frame;
    rect.size.height = 5;
    rect.origin.y = 10;
    rect.size.width = self.frame.size.width;
    
    if(_pageControl == nil){
        _pageControl = [[UIView alloc] init];
    }
    
    for(UIView* child in _pageControl.subviews)
        [child removeFromSuperview];
    
    UIImage* imageUp = [UIImage imageNamed:selectedImageName];
    UIImage* imageDown = [UIImage imageNamed:unselectedImageName];
    
    int posX = 0;
    for(int x = 0; x < _numberOfItems; x++) {
        
        CGRect rect = CGRectMake(posX, 0, imageUp.size.width, imageUp.size.height);
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = rect;
        button.tag = x;
        
        [button addTarget:self action:@selector(pageControlClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if(x == 0)
            [button setBackgroundImage:imageUp forState:UIControlStateNormal];
        
        else
            [button setBackgroundImage:imageDown forState:UIControlStateNormal];
        
        posX += (5 + imageUp.size.width);
        [_pageControl addSubview:button];
    }
    
    rect.size.height = imageUp.size.height;
    rect.size.width = posX - 5;
    rect.origin.x = (self.frame.size.width - rect.size.width) / 2;
    
    rect.origin.y = (self.frame.size.height - imageUp.size.height) - SLIDER_OFFSET_Y;
    _pageControl.frame =rect;
}

-(void)pageControlClicked:(id)sender {
    UIButton* button = (UIButton*)sender;
    [self.delegate MGSlider:self didPageControlClicked:button atIndex:(int)button.tag];
}

-(void) showPageControl:(BOOL)showing {
    [_pageControl removeFromSuperview];
    
    _willShowPageControl = showing;
    
    if(showing) {
        [self addSubview:_pageControl];
    }
}

-(void) setNeedsReLayoutWithViewSize:(CGSize)viewSize {
//    for(UIView* view in self.subviews)
//        [view removeFromSuperview];
    
    if(_scrollingTimer != nil)
       [_scrollingTimer invalidate];
    
    CGRect rectScrollView = self.frame;
    rectScrollView.origin.y = 0;
    
    if(scrollView == nil) {
        _scrollViewIsNil = YES;
        scrollView = [[UIScrollView alloc] initWithFrame:rectScrollView];
    }
    
    
    scrollView.delegate = self;
    
    int posX = 0;
    for(int x = 0; x < _numberOfItems; x++) {
        MGRawView* sliderView = [[MGRawView alloc] initWithNibName:nibName];
        [scrollView addSubview:sliderView];
        
        CGRect frameSlider = sliderView.frame;
        frameSlider.origin.x = posX;
        frameSlider.origin.y = 0;
        frameSlider.size.height = viewSize.height;
        [sliderView setFrame:frameSlider];
        
        posX += sliderView.frame.size.width;
        [self.delegate MGSlider:self didCreateSliderView:sliderView atIndex:x];
    }
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(posX, scrollView.frame.size.height);
    
    if(_scrollViewIsNil)
        [self addSubview:scrollView];
    
    _currentIndex = 0;
    
    if(_numberOfItems <= SLIDER_DOT_COUNT && _willShowPageControl)
        [self createPageControl];
}

-(void)buttonSelected:(id)sender {
    UIButton* selectedButton = (UIButton*)sender;
    
    for(MGRawView *view in scrollView.subviews) {
        if(view.tag == -1)
            continue;
        
        if (view.buttonCustom.tag == selectedButton.tag) {
            [self.delegate MGSlider:self didSelectSliderView:view atIndex:(int)view.tag];
            break;
        }
    }
}

-(void) startAnimationWithDuration:(float)duration {
    _scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                       target:self
                                                     selector:@selector(scrollingTimer)
                                                     userInfo:nil
                                                      repeats:YES];
    
    _willAnimate = YES;
}

- (void)scrollingTimer {
    
    if(!_willAnimate)
        return;
    
    CGFloat contentOffset = scrollView.contentOffset.x;
    int nextPage = (int)(contentOffset/scrollView.frame.size.width) + 1;
    CGRect rect = CGRectZero;

    if( nextPage < _numberOfItems ) {
        rect = CGRectMake(nextPage*self.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        [scrollView scrollRectToVisible:rect animated:YES];
        
        if(_willShowPageControl)
            [self setPage:nextPage];
    }
    else {
        rect = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        [scrollView scrollRectToVisible:rect animated:YES];
        
        if(_willShowPageControl)
            [self setPage:0];
    }
}

-(void) setPage:(int)index {
    
    UIImage* imageUp = [UIImage imageNamed:unselectedImageName];
    UIImage* imageDown = [UIImage imageNamed:selectedImageName];
    
    for(int x = 0; x < _pageControl.subviews.count; x++) {
        UIButton* button = [_pageControl.subviews objectAtIndex:x];
        [button setBackgroundImage:imageDown forState:UIControlStateNormal];
        
        if(x == index) {
            UIButton* button = [_pageControl.subviews objectAtIndex:x];
            [button setBackgroundImage:imageUp forState:UIControlStateNormal];
        }
    }
}

-(void)stopAnimation {
    _willAnimate = NO;
}

-(void)resumeAnimation {
    _willAnimate = YES;
}

@end
