//
//  ProfileViewController.m
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIImage* _imgThumb;
    UIImage* _imgCover;
    BOOL _isThumbSelected;
    NSString* _thumbPath;
    NSString* _photoPath;
}

@end

@implementation ProfileViewController

@synthesize scrollViewMain;
@synthesize barButtonCancel;
-(void)viewWillAppear:(BOOL)animated
{
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
    self.screenName = @"Profile Screen";
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [MGUIAppearance createLogo:HEADER_LOGO];
    self.view.backgroundColor = BG_VIEW_COLOR;
    
    [MGUIAppearance enhanceNavBarController:self.navigationController
                               barTintColor:WHITE_TEXT_COLOR
                                  tintColor:WHITE_TEXT_COLOR
                             titleTextColor:WHITE_TEXT_COLOR];
    
    UserSession* userSession = [UserAccessSession getUserSession];
    
    [MGUIAppearance enhanceNavBarController:self.navigationController
                               barTintColor:WHITE_TEXT_COLOR
                                  tintColor:WHITE_TEXT_COLOR
                             titleTextColor:WHITE_TEXT_COLOR];
    
//    _profileView = [[MGProfileView alloc] initWithFrame:scrollViewMain.frame nibName:@"ProfileView"];

    if(IS_IPHONE_4_AND_OLDER)
        _profileView = [[MGProfileView alloc] initWithFrame:CGRectMake(0, 0, 320, 430) nibName:@"ProfileView"];
    else
        _profileView = [[MGProfileView alloc] initWithFrame:scrollViewMain.frame nibName:@"ProfileView"];

    if(IS_IPHONE_4_AND_OLDER)
        _profileView.frame = CGRectMake(0, 0, 320, 430);
    
    [scrollViewMain addSubview:_profileView];
    scrollViewMain.contentSize = _profileView.frame.size;
    scrollViewMain.scrollEnabled = FALSE;
    
    _profileView.textFieldFullName.delegate = self;
    _profileView.textFieldFullName.text = userSession.fullName;
    _profileView.textFieldFullName.placeholder = LOCALIZED(@"FULL_NAME");
    _profileView.textFieldFullName.delegate = self;
    
    _profileView.labelTitle.text = userSession.fullName;
    
    _profileView.textFieldPassword.placeholder = LOCALIZED(@"PASSWORD");
    _profileView.textFieldPassword.delegate = self;
    
    _profileView.textFieldFullName.autocorrectionType = UITextAutocorrectionTypeNo;
    _profileView.textFieldPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if([UserAccessSession isLoggedFromSocial]) {
        _profileView.imgViewPhoto.hidden = YES;
        _profileView.textFieldPassword.hidden = YES;
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    UIEdgeInsets inset = scrollViewMain.contentInset;
    inset.bottom = NAV_BAR_OFFSET;
    scrollViewMain.contentInset = inset;
    
    [_profileView.buttonThumb addTarget:self
                                  action:@selector(didClickThumbButton:)
                        forControlEvents:UIControlEventTouchUpInside];
    
    [_profileView.buttonCover addTarget:self
                                  action:@selector(didClickCoverButton:)
                        forControlEvents:UIControlEventTouchUpInside];
    
    
    [_profileView.buttonThumb setTitleColor:WHITE_TEXT_COLOR
                                    forState:UIControlStateNormal];
    
    [_profileView.buttonThumb setTitleColor:WHITE_TEXT_COLOR
                                    forState:UIControlStateSelected];
    
    [_profileView.buttonThumb setTitle:LOCALIZED(@"CLICK_TO_EDIT")
                               forState:UIControlStateNormal];
    
    [_profileView.buttonThumb setTitle:LOCALIZED(@"CLICK_TO_EDIT")
                               forState:UIControlStateSelected];
    
    
    [_profileView.buttonCover setTitleColor:WHITE_TEXT_COLOR
                                   forState:UIControlStateNormal];
    
    [_profileView.buttonCover setTitleColor:WHITE_TEXT_COLOR
                                   forState:UIControlStateSelected];
    
    [_profileView.buttonCover setTitle:LOCALIZED(@"CLICK_TO_EDIT")
                              forState:UIControlStateNormal];
    
    [_profileView.buttonCover setTitle:LOCALIZED(@"CLICK_TO_EDIT")
                              forState:UIControlStateSelected];
    
    
    _profileView.label1.textColor = THEME_BLACK_TINT_COLOR;
    _profileView.label1.text = LOCALIZED(@"EDITING_NOTICE");
    
    [_profileView.buttonUpdate setTitleColor:WHITE_TEXT_COLOR
                                    forState:UIControlStateNormal];
    
    [_profileView.buttonUpdate setTitleColor:WHITE_TEXT_COLOR
                                    forState:UIControlStateSelected];
    
    [_profileView.buttonUpdate setTitle:LOCALIZED(@"UPDATE")
                               forState:UIControlStateNormal];
    
    [_profileView.buttonUpdate setTitle:LOCALIZED(@"UPDATE")
                               forState:UIControlStateSelected];
    
    [_profileView.buttonUpdate addTarget:self
                                  action:@selector(didClickButtonUpdate:)
                        forControlEvents:UIControlEventTouchUpInside];
    
    
    [_profileView.buttonLogout setTitleColor:WHITE_TEXT_COLOR
                                    forState:UIControlStateNormal];
    
    [_profileView.buttonLogout setTitleColor:WHITE_TEXT_COLOR
                                    forState:UIControlStateSelected];
    
//    [_profileView.buttonLogout setTitle:LOCALIZED(@"LOGOUT")
//                                    forState:UIControlStateNormal];
//    
//    [_profileView.buttonLogout setTitle:LOCALIZED(@"LOGOUT")
//                                    forState:UIControlStateSelected];
    
    [_profileView.buttonLogout addTarget:self
                                  action:@selector(didClickButtonLogout:)
                        forControlEvents:UIControlEventTouchUpInside];
    
    if(userSession.thumbPhotoUrl.length!=0)
    {
    [self setImage:userSession.thumbPhotoUrl imageView:_profileView.imgViewThumb withBorder:NO isThumb:YES];
    }
    else
    {
       UIImage *imgNew =  [[FHSTwitterEngine sharedEngine] getProfileImageForUsername:userSession.fullName andSize:FHSTwitterEngineImageSizeOriginal];
        
        [MGUtilities createBorders:_profileView.imgViewThumb
                       borderColor:THEME_MAIN_COLOR
                       shadowColor:[UIColor clearColor]
                       borderWidth:CELL_BORDER_WIDTH];
        _profileView.imgViewThumb.image = imgNew;

        
        NSLog(@"TWiiter Image Load");
    }
    [self setImage:userSession.coverPhotoUrl imageView:_profileView.imgViewCover withBorder:NO isThumb:NO];
    
    _profileView.imgViewThumb.layer.cornerRadius = _profileView.imgViewThumb.frame.size.width/2;
    _profileView.imgViewThumb.layer.borderWidth = 1.0f;
    _profileView.imgViewThumb.layer.borderColor = [UIColor whiteColor].CGColor;
    _profileView.imgViewThumb.layer.masksToBounds = TRUE;

    
//    [MGUtilities createBorders:_profileView.imgViewThumb
//                   borderColor:THEME_MAIN_COLOR
//                   shadowColor:[UIColor clearColor]
//                   borderWidth:CELL_BORDER_WIDTH];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardDidShow:(id)sender {
    
    CGRect frame = scrollViewMain.frame;
    frame.size.height -= 216;
    scrollViewMain.frame = frame;
    
    UIEdgeInsets inset = scrollViewMain.contentInset;
    inset.bottom = 0;
    scrollViewMain.contentInset = inset;
}

-(void)keyboardDidHide:(id)sender {
    
    CGRect frame = scrollViewMain.frame;
    frame.size.height += 216;
    scrollViewMain.frame = frame;
    
    UIEdgeInsets inset = scrollViewMain.contentInset;
    inset.bottom = NAV_BAR_OFFSET;
    scrollViewMain.contentInset = inset;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _profileView.textFieldFullName) {
		[_profileView.textFieldFullName resignFirstResponder];
        
        if(![UserAccessSession isLoggedFromSocial])
            [_profileView.textFieldPassword becomeFirstResponder];
	}
	else if (textField == _profileView.textFieldPassword && ![UserAccessSession isLoggedFromSocial]) {
		[_profileView.textFieldPassword resignFirstResponder];
	}
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    [textField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == _profileView.textFieldFullName) {
        
        CGPoint point = _profileView.buttonCover.frame.origin;
        point.x = 0;
		[scrollViewMain setContentOffset:point animated:YES];
	}
    
    if (textField == _profileView.textFieldPassword) {
        
        CGPoint point = _profileView.buttonCover.frame.origin;
        point.x = 0;
        point.y = _profileView.textFieldFullName.frame.size.height;
		[scrollViewMain setContentOffset:point animated:YES];
	}
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    BOOL isFound = YES;
    
    if(textField == _profileView.textFieldPassword) {
        
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_"];
        
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c]) {
                isFound = NO;
            }
        }
        
    }
    
    return ((newLength < MAX_CHARS_INPUT) && isFound) ? YES : NO;
}

-(void)didClickButtonUpdate:(id)sender {
    [self updateProfile];
}

-(void)didClickButtonLogout:(id)sender {

    [UserAccessSession clearAllSession];
    [[FHSTwitterEngine sharedEngine] clearAccessToken];
    [FBSession.activeSession closeAndClearTokenInformation];
    [FBSession.activeSession close];
    [FBSession setActiveSession:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)didClickButtonCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
            [self displayImage:_profileView.imgViewThumb image:imageToUse];
        }
        else {
            _imgCover = imageToUse;
            [self displayImage:_profileView.imgViewCover image:imageToUse];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)updateProfile {
    
    if(![MGUtilities hasInternetConnection]) {
        
        [MGUtilities showAlertTitle:LOCALIZED(@"NETWORK_ERROR")
                            message:LOCALIZED(@"NETWORK_ERROR_DETAILS")];
        return;
    }
    
    
    NSString* fullname = [[_profileView.textFieldFullName text] mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef) fullname);
    
    NSString* password = @"";
    
    if(fullname.length == 0) {
        
        [MGUtilities showAlertTitle:LOCALIZED(@"UPDATE_PROFILE_ERROR")
                            message:LOCALIZED(@"ALL_FIELDS_REQUIRED_ERROR_DETAILS")];
        return;
    }
    
    if(![UserAccessSession isLoggedFromSocial]) {
        password = [[_profileView.textFieldPassword text] mutableCopy];
        CFStringTrimWhitespace((__bridge CFMutableStringRef) password);
        
        if(password.length < 8) {
            
            [MGUtilities showAlertTitle:LOCALIZED(@"UPDATE_PROFILE_ERROR")
                                message:LOCALIZED(@"PASSWORD_LENGTH_ERROR_DETAILS")];
            return;
        }
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = LOCALIZED(@"UPDATING_PROFILE");
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    barButtonCancel.enabled = NO;
    
    NSURL *url = [NSURL URLWithString:UPDATE_USER_PROFILE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    UserSession* userSession = [UserAccessSession getUserSession];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            password, @"password",
                            fullname, @"full_name",
                            userSession.userId, @"user_id",
                            userSession.loginHash, @"login_hash",
                            nil];
    
    [httpClient postPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
        
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"UPDATE_PROFILE_SYNC = %@", responseStr);
        
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
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }
            else {
                [MGUtilities showAlertTitle:LOCALIZED(@"UPDATE_PROFILE_ERROR")
                                    message:LOCALIZED(@"UPDATE_PROFILE_ERROR_DETAILS")];
                
                [hud removeFromSuperview];
                [self.view setUserInteractionEnabled:YES];
                barButtonCancel.enabled = YES;   
            }
            
        }
        else {
            [MGUtilities showAlertTitle:LOCALIZED(@"UPDATE_PROFILE_ERROR") message:[dictStatus valueForKey:@"status_text"]];
            
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
                            message:LOCALIZED(@"CONNECTION_ERROR")];
    }];
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
            barButtonCancel.enabled = YES;
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
        barButtonCancel.enabled = YES;
        
        [self.view setUserInteractionEnabled:YES];
        
    }];
    [operation start];
}

-(void)setImage:(NSString*)imageUrl imageView:(UIImageView*)imgView withBorder:(BOOL)border isThumb:(BOOL)isThumb{
    
    [imgView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:SLIDER_PLACEHOLDER]];
}

@end
