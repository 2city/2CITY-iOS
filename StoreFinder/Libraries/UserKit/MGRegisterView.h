//
//  LoginView.h
//  StoreFinder
//
//
//  Copyright (c) 2014 Mangasaur Games. All rights reserved.
//

#import "MGRawView.h"

@interface MGRegisterView : MGRawView


@property (nonatomic, retain) IBOutlet UITextField* textFieldFirstName;
@property (nonatomic, retain) IBOutlet UITextField* textFieldLastName;
@property (nonatomic, retain) IBOutlet UITextField* textFieldEmail;
@property (nonatomic, retain) IBOutlet UITextField* textFieldPassword;
@property (nonatomic, retain) IBOutlet UITextField* textFieldUsername;
@property (nonatomic, retain) IBOutlet UITextField* textFieldFullName;

@property (nonatomic, retain) IBOutlet UILabel* labelEmail;
@property (nonatomic, retain) IBOutlet UILabel* labelFirstName;
@property (nonatomic, retain) IBOutlet UILabel* labelLastName;
@property (nonatomic, retain) IBOutlet UIImageView* imgViewThumb;
@property (nonatomic, retain) IBOutlet UIImageView* imgViewCover;

@property (nonatomic, retain) IBOutlet UIButton* buttonThumb;
@property (nonatomic, retain) IBOutlet UIButton* buttonCover;
@property (nonatomic, retain) IBOutlet UIButton* buttonRegister;


@end
