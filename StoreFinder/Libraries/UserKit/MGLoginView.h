//
//  MGLoginView.h
//  StoreFinder
//
//
//  Copyright (c) 2014 Mangasaur Games. All rights reserved.
//

#import "MGRawView.h"

@interface MGLoginView : MGRawView

@property (nonatomic, retain) IBOutlet UIButton* buttonFb;
@property (nonatomic, retain) IBOutlet UIButton* buttonTwitter;

@property (nonatomic, retain) IBOutlet UIButton* buttonCancel;
@property (nonatomic, retain) IBOutlet UIButton* buttonBack;
@property (nonatomic, retain) IBOutlet UIButton* buttonLogin;
@property (nonatomic, retain) IBOutlet UIButton* buttonRegister;
@property (nonatomic, retain) IBOutlet UITextField* textFieldUsername;
@property (nonatomic, retain) IBOutlet UITextField* textFieldPassword;
@property (nonatomic, retain) IBOutlet UITextField* textFieldEmail;
@property (nonatomic, retain) IBOutlet UITextField* textFieldFullName;

@end
