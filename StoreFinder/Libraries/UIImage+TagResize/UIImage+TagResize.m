//
//  UIImage+TagResize.m
//  ItemFinder
//
//
//  Copyright (c) 2014 Mangasaur Games. All rights reserved.
//

#import "UIImage+TagResize.h"

#import <objc/runtime.h>

static char const * const ObjectTagKey = "ObjectTag";
@implementation UIImage (TagResize)

-(void)setTag:(int)tag {
    objc_setAssociatedObject(self, ObjectTagKey, [NSNumber numberWithInt:tag], OBJC_ASSOCIATION_RETAIN);
}

-(int)tag {
    return [objc_getAssociatedObject(self, ObjectTagKey) intValue];
}

/*********************************************************************
 **         It return an image of a fixed width
 **
 *********************************************************************/
-(UIImage*)imageScaledToWidth:(float)width {
    //------------------------------------------
    // Task :
    // 1. calculate scaleFactor
    // 2. multiple with width and height
    // 3. resize the image with new width and height
    //------------------------------------------
    
    float oldWidth = self.size.width;
    float scaleFactor = width / oldWidth;
    
    float newHeight = self.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [self drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
@end
