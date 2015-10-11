//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "MGImageViewer.h"
#import "MGRawView.h"
#import "MGRawScrollView.h"

@implementation MGImageViewer

@synthesize imageCount;
@synthesize imageViewerDelegate = _imageViewerDelegate;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self baseInit];
    }
    return self;
}

-(void)baseInit {
    imageCount = 0;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
}

-(void) setNeedsReLayout {
    
    for(UIView *view in self.subviews)
        [view removeFromSuperview];
    
    int posX = 0, posY = 0;
    
    for(int x = 0; x < imageCount; x++) {
        
        CGRect galleryFrame = CGRectMake(posX, posY, self.frame.size.width, self.frame.size.height);
        CGRect imageViewFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        
        MGRawScrollView* scrollView = [[MGRawScrollView alloc] initWithFrame:galleryFrame];
        
        UIImageView* imgViewBg = [[UIImageView alloc] initWithFrame:imageViewFrame];
        imgViewBg.contentMode = UIViewContentModeScaleAspectFit;
        
        scrollView.tag = x;
        posX += self.frame.size.width;
        scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        
        scrollView.delegate = self;
        scrollView.imageView = imgViewBg;
        
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.bounces = NO;

        scrollView.minimumZoomScale = 1.0;
        scrollView.maximumZoomScale = 10.0f;
        scrollView.zoomScale = 1.0;
        scrollView.backgroundColor =[UIColor clearColor];
   
        UITapGestureRecognizer* doubleTapRecognizer;
        
        doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                      action:@selector(scrollViewDoubleTapped:)];
        
        doubleTapRecognizer.numberOfTapsRequired = 2;
        doubleTapRecognizer.numberOfTouchesRequired = 1;
        [scrollView addGestureRecognizer:doubleTapRecognizer];
        
        UITapGestureRecognizer* twoFingerTapRecognizer;
        twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(scrollViewTwoFingerTapped:)];
        
        twoFingerTapRecognizer.numberOfTapsRequired = 1;
        twoFingerTapRecognizer.numberOfTouchesRequired = 2;
        [scrollView addGestureRecognizer:twoFingerTapRecognizer];
        
        [scrollView addSubview:imgViewBg];
        [self addSubview:scrollView];
        
        [self.imageViewerDelegate MGImageViewer:self didCreateRawScrollView:scrollView atIndex:x];
    }
    
    self.contentSize = CGSizeMake(posX, self.frame.size.height);
    
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    
    MGRawScrollView* scrollView = (MGRawScrollView*)recognizer.view;
    
    CGPoint pointInView = [recognizer locationInView:scrollView.imageView];
    
    CGFloat newZoomScale = scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, scrollView.maximumZoomScale);
    
    CGSize scrollViewSize = scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    [scrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    
    MGRawScrollView* scrollView = (MGRawScrollView*)recognizer.view;
    
    CGFloat newZoomScale = scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, scrollView.minimumZoomScale);
    [scrollView setZoomScale:newZoomScale animated:YES];
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    MGRawScrollView* view = (MGRawScrollView*)scrollView;
    
    return view.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    MGRawScrollView* view = (MGRawScrollView*)scrollView;
    [self centerScrollViewContents:view];
}

- (void)centerScrollViewContents:(MGRawScrollView*)scrollView {
    CGSize boundsSize = scrollView.bounds.size;
    CGRect contentsFrame = scrollView.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    }
    else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    }
    else {
        contentsFrame.origin.y = 0.0f;
    }
    
    scrollView.imageView.frame = contentsFrame;
}



-(void)setPage:(int)index {
    
    for(MGRawScrollView *view in self.subviews) {
        if([view isKindOfClass:[MGRawScrollView class]]) {
            if(view.tag == index) {
                [self scrollRectToVisible:view.frame animated:YES];
                break;
            }
        }
    }
    
}

@end
