//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "MGUIAppearance.h"

@implementation MGUIAppearance


+(void)enhanceToolbarAppearance:(NSString*)toolBarFileName {
    // uitoolbar appearance
    [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:toolBarFileName]
                            forToolbarPosition:UIToolbarPositionAny
                                    barMetrics:UIBarMetricsDefault];
}

+(void)enhanceBarButtonAppearance:(UIColor*)color {
    
    [[UIBarButtonItem appearance] setTintColor:color];
}

+(void)enhanceNavBarAppearance:(NSString*)navBarFileName {
    // Navigation bar appearance
    UIImage *navBarImage = [UIImage imageNamed:navBarFileName];
    [[UINavigationBar appearance] setBackgroundImage:navBarImage
                                       forBarMetrics:UIBarMetricsDefault];
}

+(void)enhanceNavBarController:(UINavigationController*)navBarController
                  barTintColor:(UIColor*)barTintColor
                     tintColor:(UIColor*)tintColor
                titleTextColor:(UIColor*)titleTextColor {
    
    navBarController.navigationBar.barTintColor = barTintColor;
    navBarController.navigationBar.tintColor = tintColor;
    [navBarController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : titleTextColor}];
}


+(void)enhanceTabBarBackgroundAppearance:(NSString*)bgFileName
                      selectionIndicator:(NSString*)selFilename
                  selectedImageTintColor:(UIColor*)selectedColor
                         normalTintColor:(UIColor*)tintColor {
    
    // Tab bar appearance
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:bgFileName]];
    
    UIImage* selectionIndicatorImg = [[UIImage alloc] init];
    if(selFilename != nil) {
        selectionIndicatorImg = [UIImage imageNamed:selFilename];
    }
    
    // tab bar background
    [[UITabBar appearance] setSelectionIndicatorImage:selectionIndicatorImg];
    
    // tab bar selected tint color
    [[UITabBar appearance] setSelectedImageTintColor:selectedColor];
    
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       selectedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    [[UITabBar appearance] setTintColor:tintColor];
}

+(UIView*)createLogo:(NSString*)logoFileName {
    
    UIImage* image = [UIImage imageNamed:logoFileName];
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = view.frame;
    
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateSelected];
    
    [view setBackgroundColor:[UIColor  clearColor]];
    [view addSubview:btn];
    view.layer.zPosition = 9999;
    
    return view;
}

@end
