//
//  ProfileViewController.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGProfileView.h"

@interface ProfileViewController : GAITrackedViewController <UITextFieldDelegate> {
    
    MGProfileView* _profileView;
    IBOutlet UILabel *lblName;
}

@property (nonatomic, retain) IBOutlet MGRawScrollView* scrollViewMain;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* barButtonCancel;

-(IBAction)didClickButtonCancel:(id)sender;

@end
