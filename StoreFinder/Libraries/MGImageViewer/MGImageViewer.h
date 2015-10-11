//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGRawView.h"
#import "MGRawScrollView.h"

@class MGImageViewer;

@protocol MGImageViewerDelegate <NSObject>

-(void)MGImageViewer:(MGImageViewer*)imageViewer didCreateRawScrollView:(MGRawScrollView*)rawScrollView atIndex:(int)index;

@end

@interface MGImageViewer : UIScrollView <UIScrollViewDelegate, UIGestureRecognizerDelegate> {
    
    id <MGImageViewerDelegate> _imageViewerDelegate;
}

@property (nonatomic, assign) NSInteger imageCount;
@property (nonatomic, retain) id <MGImageViewerDelegate> imageViewerDelegate;

-(id)initWithFrame:(CGRect)frame;
-(void)setNeedsReLayout;
-(void)setPage:(int)index;

-(void)centerScrollViewContents:(MGRawScrollView*)scrollView;


@end
