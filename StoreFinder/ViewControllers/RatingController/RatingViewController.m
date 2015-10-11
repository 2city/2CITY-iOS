//
//  RatingViewController.m
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "RatingViewController.h"

@interface RatingViewController ()

@end

@implementation RatingViewController

@synthesize buttonCancel;
@synthesize buttonPost;
@synthesize ratingView;
@synthesize store;
@synthesize ratingDelegate = _ratingDelegate;
@synthesize labelRatingText;
-(void)viewWillAppear:(BOOL)animated
{
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
    self.screenName = @"Rating Screen";
    
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
    
    ratingView.notSelectedImage = [UIImage imageNamed:NEW_RATING_STAR_EMPTY];
    ratingView.halfSelectedImage = [UIImage imageNamed:NEW_RATING_STAR_HALF];
    ratingView.fullSelectedImage = [UIImage imageNamed:NEW_RATING_STAR_FILL];
    ratingView.editable = YES;
    ratingView.maxRating = 5;
    ratingView.midMargin = 0;
    ratingView.userInteractionEnabled = YES;
    
    labelRatingText.textColor = THEME_ORANGE_COLOR;
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
    
    float rating = ratingView.rating;
    NSString* strRating = [NSString stringWithFormat:@"%f", rating];
    
    if(rating == 0) {
        
        [MGUtilities showAlertTitle:LOCALIZED(@"RATING_ERROR")
                            message:LOCALIZED(@"RATING_ERROR_DETAILS")];
        return;
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = LOCALIZED(@"SYNCING_RATING");
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    buttonPost.enabled = NO;
    buttonCancel.enabled = NO;
    
    UserSession* userSession = [UserAccessSession getUserSession];
    
    NSURL *url = [NSURL URLWithString:POST_RATING_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            strRating, @"rating",
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
        NSLog(@"POST_RATING_SYNC = %@", responseStr);
        
        NSDictionary* dictStore = [json objectForKey:@"store"];
        NSDictionary* dictStatus = [json objectForKey:@"status"];
        
        if([[dictStatus valueForKey:@"status_code"] isEqualToString:STATUS_SUCCESS]) {
            
            if(dictStore != nil) {
                
                NSString* storeId = [dictStore valueForKey:@"store_id"];
                Store* updateStore = [CoreDataController getStoreByStoreId:storeId];
                updateStore.rating_count = dictStore[@"rating_count"];
                updateStore.rating_total = dictStore[@"rating_total"];
                
                NSError *error;
                if ([updateStore.managedObjectContext hasChanges] && ![updateStore.managedObjectContext save:&error]) {
                    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                }
                
                [self.ratingDelegate didReceiveNewRating:dictStore store:store];
                
                [hud removeFromSuperview];
                [self.view setUserInteractionEnabled:YES];
                buttonPost.enabled = YES;
                buttonCancel.enabled = YES;
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                [MGUtilities showAlertTitle:LOCALIZED(@"RATING_ERROR")
                                    message:LOCALIZED(@"RATING_ERROR_DETAILS")];
                
                [hud removeFromSuperview];
                [self.view setUserInteractionEnabled:YES];
                buttonPost.enabled = YES;
                buttonCancel.enabled = YES;
            }
            
        }
        else {
            [MGUtilities showAlertTitle:LOCALIZED(@"RATING_ERROR") message:[dictStatus valueForKey:@"status_text"]];
            
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
        
        [MGUtilities showAlertTitle:LOCALIZED(@"RATING_ERROR")
                            message:LOCALIZED(@"CONNECTION_ERROR")];
    }];
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
