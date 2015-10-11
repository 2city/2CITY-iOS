//
//  RegisterViewController.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGRegisterView.h"

@interface RegisterViewController : GAITrackedViewController <UITextFieldDelegate> {
    
    MGRegisterView* _registerView;
}

@property (nonatomic, retain) IBOutlet MGRawScrollView* scrollViewRegister;

@property (nonatomic, retain) IBOutlet UIBarButtonItem* barButtonCancel;

-(IBAction)didClickCancelLogin:(id)sender;

@end
