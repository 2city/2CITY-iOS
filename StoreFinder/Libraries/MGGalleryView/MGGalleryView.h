//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGGalleryView;

@protocol MGGalleryViewDelegate <NSObject>

@optional
-(void) MGGalleryView:(MGGalleryView*)galleryView didCreateView:(MGRawView*)rawView atIndex:(int)index;
@end

@interface MGGalleryView : UIScrollView {
    
    int _spacing;
    int _numberOfColumns;
    NSInteger _numberOfItems;
    int _height;
    id <MGGalleryViewDelegate> _galleryDelegate;
    NSString* _nibName;
    int _selectedIndex;
}


@property (nonatomic, assign) int spacing;
@property (nonatomic, assign) int numberOfColumns;
@property (nonatomic, assign) NSInteger numberOfItems;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, copy) NSString* nibName;
@property (nonatomic, retain)id <MGGalleryViewDelegate> galleryDelegate;

-(void)setNeedsReLayout;
-(id)initWithFrame:(CGRect)frame nibName:(NSString*)nibNameOrNil;
-(void)setNeedsHorizontalReLayout;
-(void)baseInit;
-(MGRawView*)getMGGalleryItemAtIndex:(int)index;

@end
