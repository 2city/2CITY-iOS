//
//  RegisterViewController.m
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"


@interface RegisterViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIImage* _imgThumb;
    UIImage* _imgCover;
    BOOL _isThumbSelected;
    NSString* _thumbPath;
    NSString* _photoPath;
}

@end

@implementation RegisterViewController

@synthesize scrollViewRegister;
@synthesize barButtonCancel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
    self.screenName = @"Signup Screen";
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = LOCALIZED(@"REGISTER");
    [MGUIAppearance enhanceNavBarController:self.navigationController
                               barTintColor:WHITE_TEXT_COLOR
                                  tintColor:WHITE_TEXT_COLOR
                             titleTextColor:WHITE_TEXT_COLOR];
    
    _registerView = [[MGRegisterView alloc] initWithNibName:@"RegisterView"];
    scrollViewRegister.frame = self.view.frame;
    
    _registerView.textFieldUsername.delegate = self;
    _registerView.textFieldPassword.delegate = self;
    _registerView.textFieldFullName.delegate = self;
    _registerView.textFieldEmail.delegate = self;
    
    _registerView.textFieldEmail.placeholder = LOCALIZED(@"EMAIL");
    _registerView.textFieldPassword.placeholder = LOCALIZED(@"PASSWORD");
    _registerView.textFieldFullName.placeholder = LOCALIZED(@"FULL_NAME");
    _registerView.textFieldUsername.placeholder = LOCALIZED(@"USER_NAME");
    
    _registerView.textFieldEmail.autocorrectionType = UITextAutocorrectionTypeNo;
    _registerView.textFieldPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    _registerView.textFieldFullName.autocorrectionType = UITextAutocorrectionTypeNo;
    _registerView.textFieldUsername.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [scrollViewRegister addSubview:_registerView];
    scrollViewRegister.contentSize = _registerView.frame.size;

    [_registerView.buttonRegister addTarget:self
                                     action:@selector(didClickRegister:)
                           forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    UIEdgeInsets inset = scrollViewRegister.contentInset;
    inset.bottom = NAV_BAR_OFFSET;
    scrollViewRegister.contentInset = inset;
    
    
    [_registerView.buttonThumb addTarget:self
                                     action:@selector(didClickThumbButton:)
                           forControlEvents:UIControlEventTouchUpInside];
    
    [_registerView.buttonCover addTarget:self
                                          action:@selector(didClickCoverButton:)
                                forControlEvents:UIControlEventTouchUpInside];
    
    
    [_registerView.buttonThumb setTitleColor:WHITE_TEXT_COLOR
                                   forState:UIControlStateNormal];
    
    [_registerView.buttonThumb setTitleColor:WHITE_TEXT_COLOR
                                   forState:UIControlStateSelected];
    
    [_registerView.buttonThumb setTitle:LOCALIZED(@"CLICK_TO_ADD")
                              forState:UIControlStateNormal];
    
    [_registerView.buttonThumb setTitle:LOCALIZED(@"CLICK_TO_ADD")
                              forState:UIControlStateSelected];
    
    
    
    [_registerView.buttonCover setTitleColor:WHITE_TEXT_COLOR
                                   forState:UIControlStateNormal];
    
    [_registerView.buttonCover setTitleColor:WHITE_TEXT_COLOR
                                   forState:UIControlStateSelected];
    
    [_registerView.buttonCover setTitle:LOCALIZED(@"CLICK_TO_ADD")
                              forState:UIControlStateNormal];
    
    [_registerView.buttonCover setTitle:LOCALIZED(@"CLICK_TO_ADD")
                              forState:UIControlStateSelected];
    
    
    
    [_registerView.buttonRegister setTitleColor:WHITE_TEXT_COLOR
                                    forState:UIControlStateNormal];
    
    [_registerView.buttonRegister setTitleColor:WHITE_TEXT_COLOR
                                    forState:UIControlStateSelected];
    
    [_registerView.buttonRegister setTitle:LOCALIZED(@"REGISTER")
                               forState:UIControlStateNormal];
    
    [_registerView.buttonRegister setTitle:LOCALIZED(@"REGISTER")
                               forState:UIControlStateSelected];
    
    [MGUtilities createBorders:_registerView.imgViewThumb
                   borderColor:THEME_MAIN_COLOR
                   shadowColor:[UIColor clearColor]
                   borderWidth:CELL_BORDER_WIDTH];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardDidShow:(id)sender {
    
    UIEdgeInsets inset = scrollViewRegister.contentInset;
    inset.bottom = 216;
    scrollViewRegister.contentInset = inset;
    
    inset = scrollViewRegister.scrollIndicatorInsets;
    inset.bottom = 216;
    scrollViewRegister.scrollIndicatorInsets = inset;
}

-(void)keyboardDidHide:(id)sender {
    
    UIEdgeInsets inset = scrollViewRegister.contentInset;
    inset.bottom = NAV_BAR_NO_OFFSET;
    scrollViewRegister.contentInset = inset;
    
    inset = scrollViewRegister.scrollIndicatorInsets;
    inset.bottom = NAV_BAR_NO_OFFSET;
    scrollViewRegister.scrollIndicatorInsets = inset;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _registerView.textFieldFullName) {
		[_registerView.textFieldFullName resignFirstResponder];
		[_registerView.textFieldEmail becomeFirstResponder];
	}
	else if (textField == _registerView.textFieldEmail) {
		[_registerView.textFieldEmail resignFirstResponder];
		[_registerView.textFieldUsername becomeFirstResponder];
	}
	else if (textField == _registerView.textFieldUsername) {
		[_registerView.textFieldUsername resignFirstResponder];
        [_registerView.textFieldPassword becomeFirstResponder];
	}
    else if (textField == _registerView.textFieldPassword) {
		[_registerView.textFieldPassword resignFirstResponder];
	}
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    [textField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    CGPoint point = _registerView.buttonCover.frame.origin;
    
    if (textField == _registerView.textFieldFullName) {
        
        point.x = 0;
		[scrollViewRegister setContentOffset:point animated:YES];
	}
    
    if (textField == _registerView.textFieldEmail) {
        
        point.x = 0;
        point.y = _registerView.textFieldFullName.frame.size.height;
		[scrollViewRegister setContentOffset:point animated:YES];
	}
    
    if (textField == _registerView.textFieldUsername) {
        
        point.x = 0;
        point.y = _registerView.textFieldEmail.frame.size.height * 2;
		[scrollViewRegister setContentOffset:point animated:YES];
	}
    
    if (textField == _registerView.textFieldPassword) {
        
        point.x = 0;
        point.y = _registerView.textFieldEmail.frame.size.height * 3;
		[scrollViewRegister setContentOffset:point animated:YES];
	}
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    BOOL isFound = YES;
    
    
    if(textField == _registerView.textFieldPassword) {
        
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_"];
        
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c]) {
                isFound = NO;
            }
        }
        
    }
    
    if(textField == _registerView.textFieldUsername) {
        
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefghijklmnopqrstuvwxyz_"];
        
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c]) {
                isFound = NO;
            }
        }
    }
    
    return ((newLength < MAX_CHARS_INPUT) && isFound) ? YES : NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)didClickThumbButton:(id)sender {
    
    _isThumbSelected = YES;
    [self showPicker];
}

-(void)didClickCoverButton:(id)sender {
    
    _isThumbSelected = NO;
    [self showPicker];
}

-(void)showPicker {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    imagePicker.sourceType =
    UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    imagePicker.allowsEditing = YES;
    
    if(DOES_SUPPORT_IOS7) {
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    WHITE_TEXT_COLOR, NSForegroundColorAttributeName, nil];
        
        [[imagePicker navigationBar] setTitleTextAttributes:attributes];
        [[imagePicker navigationBar ] setTintColor:[UIColor whiteColor]];
        
    }
    
    [self presentViewController:imagePicker animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToUse;
    
    // Handle a still image picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        
        editedImage = (UIImage *)[info objectForKey: UIImagePickerControllerEditedImage];
        originalImage = (UIImage *)[info objectForKey: UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToUse = editedImage;
            
        } else {
            imageToUse = originalImage;
        }
        
        // Do something with imageToUse
        if(_isThumbSelected) {
            _imgThumb = imageToUse;
            [self displayImage:_registerView.imgViewThumb image:imageToUse];
        }
        else {
            _imgCover = imageToUse;
            [self displayImage:_registerView.imgViewCover image:imageToUse];
        }
        
    }
    
    _thumbPath = [MGUtilities writeImage:_imgThumb isThumb:YES];
    _photoPath = [MGUtilities writeImage:_imgCover isThumb:NO];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)displayImage:(UIImageView*) imgView image:(UIImage*)img{
    CGSize size = imgView.frame.size;
    
    if([MGUtilities isRetinaDisplay]) {
        size.height *= 2;
        size.width *= 2;
    }
    
    UIImage* croppedImage = [img imageByScalingAndCroppingForSize:size];
    imgView.image = croppedImage;
}




-(IBAction)didClickCancelLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}






-(void)didClickRegister:(id)sender {
    
    if(![MGUtilities hasInternetConnection]) {
        
        [MGUtilities showAlertTitle:LOCALIZED(@"NETWORK_ERROR")
                            message:LOCALIZED(@"NETWORK_ERROR_DETAILS")];
        return;
    }
    
    NSString* username = [[_registerView.textFieldUsername text] mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef) username);
    
    NSString* password = [[_registerView.textFieldPassword text] mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef) password);
    
    NSString* fullname = [[_registerView.textFieldFullName text] mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef) fullname);
    
    NSString* email = [[_registerView.textFieldEmail text] mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef) email);
    
    if(username.length == 0 || password.length == 0 || fullname.length == 0 || email.length == 0) {
        
        [MGUtilities showAlertTitle:LOCALIZED(@"REGISTER_ERROR")
                            message:LOCALIZED(@"ALL_FIELDS_REQUIRED_ERROR_DETAILS")];
        return;
    }
    
    if(password.length < 7) {
        
        [MGUtilities showAlertTitle:LOCALIZED(@"REGISTER_ERROR")
                            message:LOCALIZED(@"PASSWORD_LENGTH_ERROR_DETAILS")];
        return;
    }
    
    if(![MGUtilities validateEmail:email]) {
        
        [MGUtilities showAlertTitle:LOCALIZED(@"REGISTER_ERROR")
                            message:LOCALIZED(@"EMAIL_ADDRESS_ERROR_DETAILS")];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = LOCALIZED(@"REGISTERING_USER");
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    barButtonCancel.enabled = NO;
    
    NSURL *url = [NSURL URLWithString:REGISTER_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            username, @"username",
                            password, @"password",
                            fullname, @"full_name",
                            email, @"email",
                            nil];
    
    [httpClient postPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
        
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"REGISTER_SYNC = %@", responseStr);
        
        NSDictionary* dictUser = [json objectForKey:@"user_info"];
        NSDictionary* dictStatus = [json objectForKey:@"status"];
        
        if([[dictStatus valueForKey:@"status_code"] isEqualToString:STATUS_SUCCESS]) {
            
            if(dictUser != nil) {
                
                UserSession* session = [UserSession new];
                session.facebookId = [dictUser valueForKey:@"facebook_id"];
                session.fullName = [dictUser valueForKey:@"full_name"];
                session.loginHash = [dictUser valueForKey:@"login_hash"];
                session.twitterId = [dictUser valueForKey:@"twitter_id"];
                session.userId = [dictUser valueForKey:@"user_id"];
                session.userName = [dictUser valueForKey:@"username"];
                session.email = [dictUser valueForKey:@"email"];
                session.coverPhotoUrl = [dictUser valueForKey:@"photo_url"];
                session.thumbPhotoUrl = [dictUser valueForKey:@"thumb_url"];
                
                [UserAccessSession storeUserSession:session];
                
                if(_photoPath != nil || _thumbPath != nil) {
                    [self startSyncPhoto:hud];
                }
                else {
                    
                    [hud removeFromSuperview];
                    [self.view setUserInteractionEnabled:YES];
                    barButtonCancel.enabled = YES;
                    
                    [self performSelector:@selector(delaySocial:)
                               withObject:nil
                               afterDelay:0.5];
                }
            }
            else {
                [MGUtilities showAlertTitle:LOCALIZED(@"REGISTER_ERROR")
                                    message:LOCALIZED(@"SIGNUP_ERROR_DETAILS")];
                
                [hud removeFromSuperview];
                [self.view setUserInteractionEnabled:YES];
                barButtonCancel.enabled = YES;
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        }
        else {
            [MGUtilities showAlertTitle:LOCALIZED(@"REGISTER_ERROR") message:[dictStatus valueForKey:@"status_text"]];
            
            [hud removeFromSuperview];
            [self.view setUserInteractionEnabled:YES];
            barButtonCancel.enabled = YES;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        barButtonCancel.enabled = YES;
        
        [MGUtilities showAlertTitle:LOCALIZED(@"NETWORK_ERROR")
                            message:LOCALIZED(@"SIGNUP_CONNECTING_ERROR")];
    }];
}


-(void)didClickLoginToTwitter:(id)sender {
    
    if(![MGUtilities hasInternetConnection]) {
        
        [MGUtilities showAlertTitle:LOCALIZED(@"NETWORK_ERROR")
                            message:LOCALIZED(@"NETWORK_ERROR_DETAILS")];
        return;
    }
    
    UIViewController *loginController = [[FHSTwitterEngine sharedEngine]loginControllerWithCompletionHandler:^(BOOL success) {
        
        NSString* twitterId = [[FHSTwitterEngine sharedEngine] authenticatedID];
        NSDictionary *data = [[FHSTwitterEngine sharedEngine] getUserSettings];
        NSString* name = [data valueForKey:@"screen_name"];
        NSString* full_name = [NSString stringWithFormat:@"@%@", name];
        [self registerViaSocial:twitterId isFacebook:NO name:full_name email:@""];
    }];
    
    [self presentViewController:loginController animated:YES completion:nil];
}

-(void)didClickLoginToFacebook:(id)sender {
    
    if(![MGUtilities hasInternetConnection]) {
        
        [MGUtilities showAlertTitle:LOCALIZED(@"NETWORK_ERROR")
                            message:LOCALIZED(@"NETWORK_ERROR_DETAILS")];
        return;
    }
    
    AppDelegate* appDelegate = [AppDelegate instance];
    //    [appDelegate.session closeAndClearTokenInformation];
    
    if (!appDelegate.session.isOpen) {
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
        
        NSArray *permissions = [NSArray arrayWithObjects:@"email", nil];
        [FBSession openActiveSessionWithReadPermissions:permissions
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session,
           FBSessionState state, NSError *error) {
             
             [self sessionStateChanged:session state:state error:error];
         }];
    }
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error {
    
    switch (state) {
        case FBSessionStateOpen: {
            
            [[FBRequest requestForMe] startWithCompletionHandler:
             ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                 
                 if (!error) {
                     //error
                     NSString* facebookId = [user valueForKey:@"id"];
                     NSString* name = [user valueForKey:@"name"];
                     NSString* email = [user valueForKey:@"email"];
                     [self registerViaSocial:facebookId isFacebook:YES name:name email:email];
                 }
                 
             }];
        }
            
        case FBSessionStateClosed: { }
            
        case FBSessionStateClosedLoginFailed: { }
            
        case FBSessionStateCreatedOpening: { }
            
        case FBSessionStateCreatedTokenLoaded: { }
            
        case FBSessionStateOpenTokenExtended: { }
            
        case FBSessionStateCreated: { }
    }
}


-(void)registerViaSocial:(NSString*)anyId isFacebook:(BOOL)isFacebook name:(NSString*)name email:(NSString*)email{
    
    if(![MGUtilities hasInternetConnection]) {
        [MGUtilities showAlertTitle:LOCALIZED(@"NETWORK_ERROR")
                            message:LOCALIZED(@"NETWORK_ERROR_DETAILS")];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = LOCALIZED(@"REGISTERING_USER");
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    barButtonCancel.enabled = NO;
    
    NSURL *url = [NSURL URLWithString:REGISTER_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *params = nil;
    
    if(isFacebook) {
        params = [NSDictionary dictionaryWithObjectsAndKeys:
                  anyId, @"facebook_id",
                  name, @"full_name",
                  email, @"email",
                  nil];
    }
    else {
        params = [NSDictionary dictionaryWithObjectsAndKeys:
                  anyId, @"twitter_id",
                  name, @"full_name",
                  email, @"email",
                  nil];
    }
    
    [httpClient postPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
        
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"responseStr = %@", responseStr);
        
        NSDictionary* dictUser = [json objectForKey:@"user_info"];
        NSDictionary* dictStatus = [json objectForKey:@"status"];
        
        if([[dictStatus valueForKey:@"status_code"] isEqualToString:STATUS_SUCCESS]) {
            
            if(dictUser != nil) {
                
                UserSession* session = [UserSession new];
                session.facebookId = [dictUser valueForKey:@"facebook_id"];
                session.fullName = [dictUser valueForKey:@"full_name"];
                session.loginHash = [dictUser valueForKey:@"login_hash"];
                session.twitterId = [dictUser valueForKey:@"twitter_id"];
                session.userId = [dictUser valueForKey:@"user_id"];
                session.userName = [dictUser valueForKey:@"username"];
                session.email = [dictUser valueForKey:@"email"];
                session.coverPhotoUrl = [dictUser valueForKey:@"photo_url"];
                session.thumbPhotoUrl = [dictUser valueForKey:@"thumb_url"];
                
                [UserAccessSession storeUserSession:session];
                
                if(_photoPath != nil || _thumbPath != nil) {
                    [self startSyncPhoto:hud];
                }
                else {
                    
                    [hud removeFromSuperview];
                    [self.view setUserInteractionEnabled:YES];
                    barButtonCancel.enabled = YES;
                    
                    [self performSelector:@selector(delaySocial:)
                               withObject:nil
                               afterDelay:0.5];
                }
            }
        }
        else {
            
            [hud removeFromSuperview];
            [self.view setUserInteractionEnabled:YES];
            barButtonCancel.enabled = YES;
            
            [MGUtilities showAlertTitle:LOCALIZED(@"LOGIN_ERROR")
                                message:[dictStatus valueForKey:@"status_text"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        barButtonCancel.enabled = YES;
        
        [MGUtilities showAlertTitle:LOCALIZED(@"NETWORK_ERROR")
                            message:LOCALIZED(@"SIGNUP_CONNECTING_ERROR")];
    }];
}

-(void)delaySocial:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) startSyncPhoto:(MBProgressHUD*)hud {
    
    hud.labelText = LOCALIZED(@"SYNCING_PHOTOS");
    
    NSURL *url = [NSURL URLWithString:USER_PHOTO_UPLOAD_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    UserSession* session = [UserAccessSession getUserSession];
    NSDictionary *params = nil;
    
    _photoPath = _photoPath == nil ? @"" : _photoPath;
    _thumbPath = _thumbPath == nil ? @"" : _thumbPath;
    
    params = [NSDictionary dictionaryWithObjectsAndKeys:
              session.userId, @"user_id",
              session.loginHash, @"login_hash",
              _thumbPath, @"thumb_url",
              _photoPath, @"photo_url",
              nil];
    
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:@"" parameters:params constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        
        NSData* dataThumb = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:_thumbPath]];
        NSData* dataPhoto = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:_photoPath]];
        
        NSString* fullNameThumb = [_thumbPath lastPathComponent];
        NSString* fullNamePhoto = [_photoPath lastPathComponent];
        
        if(dataThumb != nil) {
            [formData appendPartWithFileData:dataThumb
                                        name:@"thumb_file"
                                    fileName:fullNameThumb
                                    mimeType:@"image/jpeg"];
        }
        
        if(dataPhoto != nil) {
            [formData appendPartWithFileData:dataPhoto
                                        name:@"photo_file"
                                    fileName:fullNamePhoto
                                    mimeType:@"image/jpeg"];
        }
        
    }];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
        
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"PHOTO_USER_SYNC = %@", responseStr);
        
        NSDictionary* dictStatus = [json objectForKey:@"status"];
        NSDictionary* dictPhoto = [json objectForKey:@"photo_user_info"];
        
        if([[dictStatus valueForKey:@"status_code"] isEqualToString:STATUS_SUCCESS]) {
            
            [MGFileManager deleteImageAtFilePath:_thumbPath];
            [MGFileManager deleteImageAtFilePath:_photoPath];
            
            UserSession* userSession = [UserAccessSession getUserSession];
            userSession.thumbPhotoUrl = [dictPhoto valueForKey:@"thumb_url"];
            userSession.coverPhotoUrl = [dictPhoto valueForKey:@"photo_url"];
            [UserAccessSession storeUserSession:userSession];
            
            [hud removeFromSuperview];
            [self.view setUserInteractionEnabled:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            [MGUtilities showAlertTitle:LOCALIZED(@"UNSYNC_CONNECTION_ERROR")
                                message:[dictStatus valueForKey:@"status_text"]];
            
            [self.navigationItem setHidesBackButton:NO];
            
            [hud removeFromSuperview];
            [self.view setUserInteractionEnabled:YES];
            barButtonCancel.enabled = YES;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        
        [MGUtilities showAlertTitle:LOCALIZED(@"UNSYNC_CONNECTION_ERROR")
                            message:LOCALIZED(@"UNSYNC_CONNECTION_ERROR_DETAILS")];
        
        [self.navigationItem setHidesBackButton:NO];
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        barButtonCancel.enabled = YES;
        
    }];
    [operation start];
}





@end
