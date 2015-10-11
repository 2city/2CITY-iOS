//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "MGGalleryView.h"

@implementation MGGalleryView

@synthesize spacing = _spacing;
@synthesize numberOfColumns = _numberOfColumns;
@synthesize height = _height;
@synthesize nibName = _nibName;
@synthesize numberOfItems = _numberOfItems;
@synthesize galleryDelegate = _galleryDelegate;
@synthesize selectedIndex = _selectedIndex;


-(id)initWithFrame:(CGRect)frame nibName:(NSString *)nibNameOrNil {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self baseInit];
        _nibName = [nibNameOrNil copy];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];
    }
    return self;
}

-(void)baseInit {
    
    _spacing = 5;
    _numberOfColumns = 0;
    _numberOfItems = 0;
    _height = 0;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
}

-(void) setNeedsReLayout {
    
    for(UIView *view in self.subviews)
        [view removeFromSuperview];
    
    int totalSpacing = (_numberOfColumns + 1) * _spacing;
    float cellWidth = (self.frame.size.width - totalSpacing) / _numberOfColumns;
    
    int posX = _spacing, posY = _spacing, divider = _numberOfColumns;
    
    for(int x = 0; x < _numberOfItems; x++) {
        
        if (x == divider) {
            posY += _height + _spacing;
            posX = _spacing;
            divider = (x + _numberOfColumns);
        }
        
        CGRect galleryFrame = CGRectMake(posX, posY, cellWidth, _height);
        MGRawView* view = [[MGRawView alloc] initWithNibName:_nibName];
        
        _height = view.frame.size.height;
        galleryFrame.size.height = _height;
        
        view.frame = galleryFrame;
        
        [view setTag:x];
        [self addSubview:view];
        
        [self.galleryDelegate MGGalleryView:self didCreateView:view atIndex:x];
        
        posX += cellWidth + _spacing;
    }
    
    self.contentSize = CGSizeMake(self.frame.size.width, posY + _height + _spacing);
    
    [self setScrollEnabled:YES];
    [self setShowsVerticalScrollIndicator:YES];
}

-(MGRawView*)getMGGalleryItemAtIndex:(int)index {
    
    for (MGRawView* view in self.subviews) {
        if([view isKindOfClass:[MGRawView class]] && ((int)view.tag) == index) {
            return view;
        }
    }
    
    return nil;
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView * view in [self subviews])
    {
        if (view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event])
        {
            return YES;
        }
    }
    return NO;
}


-(void) setNeedsHorizontalReLayout {
    for(UIView *view in self.subviews)
        [view removeFromSuperview];
    
    int totalSpacing = (_numberOfColumns + 1) * _spacing;
    float cellWidth = (self.frame.size.width - totalSpacing) / _numberOfColumns;
    
    int posX = _spacing, posY = _spacing, divider = _numberOfColumns;
    
    for(int x = 0; x < _numberOfItems; x++) {
        if (x == divider) {
            
            posY += _height + _spacing;
            posX = _spacing;
            divider = (x + _numberOfColumns);
        }
        
        CGRect galleryFrame = CGRectMake(posX, posY, cellWidth, _height);
        
        MGRawView* view = [[MGRawView alloc] initWithNibName:_nibName];
        
        _height = view.frame.size.height;
        galleryFrame.size.height = _height;
        
        view.frame = galleryFrame;
        [view setTag:x];
        [self addSubview:view];
        
        [self.galleryDelegate MGGalleryView:self didCreateView:view atIndex:x];
        
        posX += cellWidth + _spacing;
    }
    
//    self.contentSize = CGSizeMake(posX, self.frame.size.height);
    
    self.contentSize = CGSizeMake(self.frame.size.width, posY + _height + _spacing);
    
    [self setScrollEnabled:YES];
    [self setShowsVerticalScrollIndicator:YES];
}


@end
