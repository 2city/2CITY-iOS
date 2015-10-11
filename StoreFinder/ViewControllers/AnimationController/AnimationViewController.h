//
//  AnimationViewController.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationViewController : GAITrackedViewController {
    
    MGRawView* _animationView;
}

@property (nonatomic, retain) IBOutlet MGRawScrollView* scrollViewMain;

@end
