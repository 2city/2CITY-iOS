//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGUIAppearance : NSObject

+(void)enhanceNavBarAppearance:(NSString*)navBarFileName;

+(void)enhanceTabBarBackgroundAppearance:(NSString*)bgFileName
                      selectionIndicator:(NSString*)selFilename
                  selectedImageTintColor:(UIColor*)selectedColor
                         normalTintColor:(UIColor*)tintColor;

+(void)enhanceNavBarController:(UINavigationController*)navBarController
                  barTintColor:(UIColor*)barTintColor
                     tintColor:(UIColor*)tintColor
                titleTextColor:(UIColor*)titleTextColor;

+(UIView*)createLogo:(NSString*)logoFileName;

+(void)enhanceToolbarAppearance:(NSString*)toolBarFileName;

+(void)enhanceBarButtonAppearance:(UIColor*)color;

@end
