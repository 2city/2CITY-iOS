//
//  UIImage+TagResize.h
//  ItemFinder
//
//
//  Copyright (c) 2014 Mangasaur Games. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface UIImage (TagResize)

-(void)setTag:(int)tag;
-(int) tag;
- (UIImage*)imageScaledToWidth: (float) i_width;

@end
