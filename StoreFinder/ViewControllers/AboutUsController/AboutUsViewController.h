//
//  AboutUsViewController.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsViewController : GAITrackedViewController <MFMailComposeViewControllerDelegate> {
    
    MGRawView* _aboutView;
}

@property (nonatomic, retain) IBOutlet MGRawScrollView* scrollViewMain;
@end
