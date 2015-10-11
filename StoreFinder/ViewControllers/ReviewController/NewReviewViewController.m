//
//  NewReviewViewController.m
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "NewReviewViewController.h"

@interface NewReviewViewController () <UITextViewDelegate>

@end

@implementation NewReviewViewController

@synthesize buttonCancel;
@synthesize buttonPost;
@synthesize textViewReview;
@synthesize store;
@synthesize reviewDelegate = _reviewDelegate;
@synthesize labelCharsLeft;

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
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.view.backgroundColor = [UIColor blackColor];
    [MGUIAppearance enhanceNavBarController:self.navigationController
                               barTintColor:WHITE_TEXT_COLOR
                                  tintColor:WHITE_TEXT_COLOR
                             titleTextColor:WHITE_TEXT_COLOR];
    
    textViewReview.autocorrectionType = UITextAutocorrectionTypeNo;
    textViewReview.text = LOCALIZED(@"COMMENTS");
    textViewReview.delegate = self;
    textViewReview.textColor = [UIColor lightGrayColor];
//    [MGUtilities createBordersInView:textViewReview
//                         borderColor:THEME_ORANGE_COLOR
//                         shadowColor:[UIColor clearColor]
//                         borderWidth:2.0f
//                        borderRadius:10.0f];
    textViewReview.layer.cornerRadius = 3.0f;
    textViewReview.layer.masksToBounds = TRUE;
    
    [self updateLabelCharCount:textViewReview.text.length];
//    [textViewReview becomeFirstResponder];
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    BOOL isFound = YES;
    
    
    
    if([text isEqualToString:@"\n"]){
        isFound = NO;
    }else{
        isFound = YES;
    }
    
    if(newLength <= MAX_CHARS_REVIEWS && isFound)
        [self updateLabelCharCount:newLength];
    
    return ((newLength <= MAX_CHARS_REVIEWS) && isFound) ? YES : NO;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if([textView.text isEqualToString:LOCALIZED(@"COMMENTS")]){
        textView.text = @"";
        [self updateLabelCharCount:textViewReview.text.length];
    }
    
    return YES;
}


-(void)updateLabelCharCount:(NSUInteger)count {
    NSString* charsLeft = [NSString stringWithFormat:@"%d %@", MAX_CHARS_REVIEWS - (int)count, LOCALIZED(@"CHARS_LEFT")];
    labelCharsLeft.text = charsLeft;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)didClickButtonCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)didClickButtonPost:(id)sender {
    [self startSync];
}



-(void)startSync {
    
    if(![MGUtilities hasInternetConnection]) {
        
        [MGUtilities showAlertTitle:LOCALIZED(@"NETWORK_ERROR")
                            message:LOCALIZED(@"NETWORK_ERROR_DETAILS")];
        return;
    }
    
    NSString* reviews = [[textViewReview text] mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef) reviews);
    
    if(reviews.length == 0) {
        
        [MGUtilities showAlertTitle:LOCALIZED(@"POSTING_ERROR")
                            message:LOCALIZED(@"POSTING_ERROR_DETAILS")];
        return;
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = LOCALIZED(@"POSTING_REVIEW");
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    buttonPost.enabled = NO;
    buttonCancel.enabled = NO;
    
    
    UserSession* userSession = [UserAccessSession getUserSession];
    
    NSURL *url = [NSURL URLWithString:POST_REVIEW_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [reviews stringByEncodingHTMLEntities], @"review",
                            store.store_id, @"store_id",
                            userSession.userId, @"user_id",
                            userSession.loginHash, @"login_hash",
                            nil];
    
    [httpClient postPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
        
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"POST_REVIEW_SYNC = %@", responseStr);
        
        NSDictionary* dictReviews = [json objectForKey:@"reviews"];
        NSDictionary* dictStatus = [json objectForKey:@"status"];
        
        if([[dictStatus valueForKey:@"status_code"] isEqualToString:STATUS_SUCCESS]) {
            
            if(dictReviews != nil) {
                
                [hud removeFromSuperview];
                [self.view setUserInteractionEnabled:YES];
                buttonPost.enabled = YES;
                buttonCancel.enabled = YES;
                
                [self.reviewDelegate didReceiveNewReview:dictReviews];
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                [MGUtilities showAlertTitle:LOCALIZED(@"NEW_REVIEW_ERROR")
                                    message:LOCALIZED(@"NEW_REVIEW_ERROR_DETAILS")];
                
                [hud removeFromSuperview];
                [self.view setUserInteractionEnabled:YES];
                buttonPost.enabled = YES;
                buttonCancel.enabled = YES;
            }
            
        }
        else {
            [MGUtilities showAlertTitle:LOCALIZED(@"NEW_REVIEW_ERROR") message:[dictStatus valueForKey:@"status_text"]];
            
            [hud removeFromSuperview];
            [self.view setUserInteractionEnabled:YES];
            buttonPost.enabled = YES;
            buttonCancel.enabled = YES;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        buttonPost.enabled = YES;
        buttonCancel.enabled = YES;
        
        [MGUtilities showAlertTitle:LOCALIZED(@"NETWORK_ERROR")
                            message:LOCALIZED(@"SIGNUP_CONNECTING_ERROR")];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
    self.screenName = @"News Review Screen";
    
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

@end
