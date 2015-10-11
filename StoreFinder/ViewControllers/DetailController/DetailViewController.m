//
//  DetailViewController.m
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "ImageViewerController.h"
#import "RatingViewController.h"
#import "ZoomAnimationController.h"
#import "NewsDetailViewController.h"
#import "MyCalendar.h"
#import <EventKit/EventKit.h>
@interface DetailViewController () <MGListViewDelegate, UIViewControllerTransitioningDelegate, RatingDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, MGMapViewDelegate> {
    
    MGHeaderView* _headerView;
    MGFooterView* _footerView;
    
    NSArray* _arrayPhotos;
    float _headerHeight;
    BOOL _canRate;
    NSArray* _arrayIcons;
    BOOL _isLoadedView;
}

@property (nonatomic, strong) id<MGAnimationController> animationController;

@end

@implementation DetailViewController

@synthesize tableViewMain;
@synthesize store;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];

    self.screenName = @"Detail Screen";
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
    self.view.backgroundColor = [UIColor blackColor];
    
    [MGUIAppearance enhanceNavBarController:self.navigationController
                               barTintColor:WHITE_TEXT_COLOR
                                  tintColor:WHITE_TEXT_COLOR
                             titleTextColor:WHITE_TEXT_COLOR];
    
    
    _footerView = [[MGFooterView alloc] initWithNibName:@"FooterView"];
//    [_footerView.buttonTwitter setTitle:LOCALIZED(@"SHARE") forState:UIControlStateNormal];
//    [_footerView.buttonTwitter setTitle:LOCALIZED(@"SHARE") forState:UIControlStateSelected];
    [_footerView.buttonTwitter setTitleColor:WHITE_TEXT_COLOR forState:UIControlStateNormal];
    [_footerView.buttonTwitter setTitleColor:WHITE_TEXT_COLOR forState:UIControlStateSelected];
    
    
//    [_footerView.buttonFacebook setTitle:LOCALIZED(@"SHARE") forState:UIControlStateNormal];
//    [_footerView.buttonFacebook setTitle:LOCALIZED(@"SHARE") forState:UIControlStateSelected];
    [_footerView.buttonFacebook setTitleColor:WHITE_TEXT_COLOR forState:UIControlStateNormal];
    [_footerView.buttonFacebook setTitleColor:WHITE_TEXT_COLOR forState:UIControlStateSelected];
    [_footerView.buttonCustom addTarget:self
                      action:@selector(saveEventtoCal:)
            forControlEvents:UIControlEventTouchUpInside];

    [_footerView.buttonFacebook addTarget:self
                                   action:@selector(didClickButtonFacebook:)
                         forControlEvents:UIControlEventTouchUpInside];
    
    [_footerView.buttonTwitter addTarget:self
                                  action:@selector(didClickButtonTwitter:)
                        forControlEvents:UIControlEventTouchUpInside];
    
    [_footerView.buttonCall addTarget:self
                                  action:@selector(didClickButtonCall:)
                        forControlEvents:UIControlEventTouchUpInside];
    
    [_footerView.buttonSMS addTarget:self
                                  action:@selector(didClickButtonSMS:)
                        forControlEvents:UIControlEventTouchUpInside];
    
    [_footerView.buttonEmail addTarget:self
                                  action:@selector(didClickButtonEmail:)
                        forControlEvents:UIControlEventTouchUpInside];
    
    [_footerView.buttonWebsite addTarget:self
                                  action:@selector(didClickButtonWebsite:)
                        forControlEvents:UIControlEventTouchUpInside];
    
    [_footerView.buttonRoute addTarget:self
                                  action:@selector(didClickButtonRoute:)
                        forControlEvents:UIControlEventTouchUpInside];
    
    
    _headerView = [[MGHeaderView alloc] initWithNibName:@"HeaderView"];
    
    
    _headerView.imgViewPhoto.contentMode = UIViewContentModeScaleAspectFill;
    _headerView.imgViewPhoto.clipsToBounds = YES;
    _headerView.label1.backgroundColor = [BLACK_TEXT_COLOR colorWithAlphaComponent:0.66];
    
    _headerView.labelTitle.textColor = THEME_ORANGE_COLOR;
    _headerView.labelSubtitle.textColor = WHITE_TEXT_COLOR;
    
    _headerView.labelTitle.text = store.store_name;
    _headerView.labelSubtitle.text = store.store_address;
    _footerView.label1.text = store.sms_no;
    _footerView.label3.text = store.website;
    _footerView.label2.text = store.email;
    _headerView.ratingView.notSelectedImage = [UIImage imageNamed:STAR_EMPTY];
    _headerView.ratingView.halfSelectedImage = [UIImage imageNamed:STAR_HALF];
    _headerView.ratingView.fullSelectedImage = [UIImage imageNamed:STAR_FILL];
    _headerView.ratingView.editable = YES;
    _headerView.ratingView.maxRating = 5;
    _headerView.ratingView.midMargin = 0;
    _headerView.ratingView.userInteractionEnabled = NO;
    
    
    if([store.featured intValue] < 1)
        _headerView.imgViewFeatured.hidden = YES;
    
    
    double rating = [store.rating_total doubleValue]/[store.rating_count doubleValue];
    _headerView.ratingView.rating = rating;
    
    NSString* info = [NSString stringWithFormat:@"%.2f %@ %@ %@",
                      rating,
                      LOCALIZED(@"RATING_AVERAGE"),
                      store.rating_count,
                      LOCALIZED(@"RATING")];
    
    if([store.rating_total doubleValue] == 0 || [store.rating_count doubleValue] == 0 )
        info = LOCALIZED(@"NO_RATING");
    
    _headerView.labelExtraInfo.text = info;
    
    _arrayPhotos = [CoreDataController getStorePhotosByStoreId:store.store_id];
    

    
    [_headerView.buttonPhotos addTarget:self
                                 action:@selector(didClickButtonPhotos:)
                       forControlEvents:UIControlEventTouchUpInside];
    
    [_headerView.buttonRate addTarget:self
                                 action:@selector(didClickButtonRate:)
                       forControlEvents:UIControlEventTouchUpInside];
    
    [_headerView.buttonFave addTarget:self
                               action:@selector(didClickButtonFave:)
                     forControlEvents:UIControlEventTouchUpInside];
    
    
    [_headerView.buttonRate setTitle:LOCALIZED(@"Rate It!") forState:UIControlStateNormal];
    [_headerView.buttonRate setTitle:LOCALIZED(@"Rate It!") forState:UIControlStateSelected];
    
    [_headerView.labelPhotos setText:[NSString stringWithFormat:@"%d", (int)_arrayPhotos.count]];
    
    _headerHeight = _headerView.frame.size.height;
    
    Photo* p = _arrayPhotos == nil || _arrayPhotos.count == 0 ? nil : _arrayPhotos[0];
    
    if(p != nil)
        [self setImage:p.photo_url imageView:_headerView.imgViewPhoto];
    
    
    _arrayIcons = @[ICON_DETAIL_EMAIL, ICON_DETAIL_SMS, ICON_DETAIL_CALL, ICON_DETAIL_WEBSITE];
    
    
    tableViewMain.delegate = self;
    [tableViewMain registerNibName:@"DetailCell" cellIndentifier:@"DetailCell"];
    [tableViewMain baseInit];
    
    tableViewMain.tableView.tableHeaderView = _headerView;
    tableViewMain.tableView.tableFooterView = _footerView;
    tableViewMain.noOfItems = 1;
    tableViewMain.cellHeight = 0;
    [tableViewMain reloadData];
    [tableViewMain tableView].delaysContentTouches = NO;
    
    UIBarButtonItem* itemMenu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:BUTTON_POST_REVIEW]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(didClickBarButtonMenu:)];
    self.navigationItem.rightBarButtonItem = itemMenu;
    
    [self checkFave];
    
    _isLoadedView = NO;
    
}

-(IBAction)saveEventtoCal:(id)sender
{
//    [MyCalendar requestAccess:^(BOOL granted, NSError *error) {
//        if (granted) {
//            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//            [dateFormat setDateFormat:@"MM/dd/yyyy"];
//            NSDate *dtForOrder = [dateFormat dateFromString:store.date_for_ordering];
//            BOOL result = [MyCalendar addEventAt:dtForOrder withTitle:store.store_name inLocation:store.store_address];
//            if (result) {
//                // added to calendar
//                [[[UIAlertView alloc] initWithTitle:@"Reminder Added." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
//
//            } else {
//                // unable to create event/calendar
//            }
//        } else {
//            [[[UIAlertView alloc] initWithTitle:@"You don't have permissions to access calendars" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
//            // you don't have permissions to access calendars
//        }
//    }];
    
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    [[[UIAlertView alloc] initWithTitle:[error localizedDescription] message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];

                    // display error message here
                }
                else if (!granted)
                {
                    [[[UIAlertView alloc] initWithTitle:@"You don't have permissions to access calendars" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];

                    // display access denied error message here
                }
                else
                {
                    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                    [dateFormat setDateFormat:@"dd/MM/yyyy"];
                    NSDate *dtForOrder = [dateFormat dateFromString:store.date_for_ordering];
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    event.title     = [NSString stringWithFormat:@"2City-%@",store.store_name];
                    event.location = store.store_address;
                    event.notes = store.store_desc;
                    
                    event.startDate = dtForOrder;
                    event.endDate = [dtForOrder dateByAddingTimeInterval:3600 * 2];
                    
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    if(!err)
                    {
                        [[[UIAlertView alloc] initWithTitle:@"Event Added." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];

                    }
                    else
                    {
                        [[[UIAlertView alloc] initWithTitle:[err localizedDescription] message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];

                    }
                    // access granted
                    // ***** do the important stuff here *****
                }
            });
        }];
    }
    else
    {
        // this code runs in iOS 4 or iOS 5
        // ***** do the important stuff here *****
    }
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
//    if(!_isLoadedView) {
//        _isLoadedView = YES;
//        [self startSync];
//    }
//    else {
//        [self updateRating];
//    }
}

-(void)didClickBarButtonMenu:(id)sender {
    
    ReviewViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardReview"];
    vc.store = store;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)setImage:(NSString*)imageUrl imageView:(UIImageView*)imgView {
    
    [imgView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:SLIDER_PLACEHOLDER]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)didClickButtonFave:(id)sender {
    AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext* context = delegate.managedObjectContext;
    
    Favorite* fave = [CoreDataController getFavoriteByStoreId:store.store_id];
    
    if(fave == nil) {
        [CoreDataController insertFavorite:store.store_id];
    }
    else {
        
        [context deleteObject:fave];
        
        NSError *error;
        if ([context hasChanges] && ![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    [self checkFave];
}

-(void)checkFave {
    
    Favorite* fave = [CoreDataController getFavoriteByStoreId:store.store_id];
    if(fave != nil)
        [_headerView.buttonFave setBackgroundImage:[UIImage imageNamed:STARRED_IMG] forState:UIControlStateNormal];
    else
        [_headerView.buttonFave setBackgroundImage:[UIImage imageNamed:UNSTAR_IMG] forState:UIControlStateNormal];
}

-(void)didClickButtonPhotos:(id)sender {
    
    if(_arrayPhotos == nil || _arrayPhotos.count == 0)
        return;
    
    ImageViewerController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"segueImageViewer"];
    vc.imageArray = _arrayPhotos;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(void) MGListView:(MGListView *)_listView didSelectCell:(MGListCell *)cell indexPath:(NSIndexPath *)indexPath {
    
}

-(UITableViewCell*)MGListView:(MGListView *)listView1 didCreateCell:(MGListCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    if(cell != nil) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectedColor = WHITE_TEXT_COLOR;
        cell.unSelectedColor = WHITE_TEXT_COLOR;
        cell.labelDescription.textColor = THEME_BLACK_TINT_COLOR;
        cell.backgroundColor = [UIColor clearColor];
        
        if(indexPath.row < _arrayIcons.count)
            [cell.imgViewPic setImage:[UIImage imageNamed:_arrayIcons[indexPath.row]]];
        
        cell.labelDescription.textColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0];
        [cell.labelDescription setText:store.store_desc];
        
        CGSize size = [cell.labelDescription sizeOfMultiLineLabel];
        CGRect frame = cell.labelDescription.frame;
        cell.labelDescription.frame = frame;
        
        float totalHeightLabel = size.height + frame.origin.y + (18);
        
        if(totalHeightLabel > cell.frame.size.height) {
            frame.size = size;
            cell.labelDescription.frame = frame;
            
            CGRect cellFrame = cell.frame;
            cellFrame.size.height = totalHeightLabel + cell.frame.size.height;
            cell.frame = cellFrame;
        }
        else {
            
            frame.size = size;
            cell.labelDescription.frame = frame;
        }
        
        
        cell.mapViewCell.delegate = self;
        [cell.mapViewCell baseInit];
        cell.mapViewCell.mapView.zoomEnabled = NO;
        cell.mapViewCell.mapView.scrollEnabled = NO;
        cell.labelTitle.text = store.store_name;
        cell.labelTitle.textColor = THEME_ORANGE_COLOR;
        cell.unSelectedColor = THEME_ORANGE_COLOR;
        cell.selectedColor = THEME_ORANGE_COLOR;
        
        
                    cell.labelDistance.frame = CGRectMake(66, frame.origin.y+frame.size.height+5, 230, 20);
        cell.labelDistance.textColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0];
        cell.labelDistance.text = store.store_address;
        
        cell.imgViewIcon.frame = CGRectMake(32, frame.origin.y+frame.size.height+7, 10, 14);
        cell.unselectedImageIcon = [UIImage imageNamed:@"location_iconsmall.png"];
        cell.selectedImageIcon = [UIImage imageNamed:@"location_iconsmall.png"];

        cell.imgViewIcon.contentMode = UIViewContentModeScaleAspectFit;

        CLLocationCoordinate2D coords = CLLocationCoordinate2DMake([store.lat doubleValue], [store.lon doubleValue]);
        
        if(CLLocationCoordinate2DIsValid(coords)) {
            MGMapAnnotation* ann = [[MGMapAnnotation alloc] initWithCoordinate:coords
                                                                          name:store.store_name
                                                                   description:store.store_address];
            ann.object = store;
            
            [cell.mapViewCell setMapData:[NSMutableArray arrayWithObjects:ann, nil] ];
            [cell.mapViewCell setSelectedAnnotation:coords];
            [cell.mapViewCell moveCenterByOffset:CGPointMake(0, -40) from:coords];
            
            cell.mapViewCell.frame = CGRectMake(17, frame.origin.y+frame.size.height+30, 287, 287);
        }
        
    }
    
    return cell;
}

-(void)MGListView:(MGListView *)_listView scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    CGFloat yPos = -scrollView.contentOffset.y;
//    
//    if (yPos > 0) {
//        CGRect imgRect = _headerView.imgViewPhoto.frame;
//        imgRect.origin.y = scrollView.contentOffset.y;
//        imgRect.size.height = _headerHeight + yPos;
//        _headerView.imgViewPhoto.frame = imgRect;
//    }
    
}

-(CGFloat)MGListView:(MGListView *)listView cell:(MGListCell*)cell heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 4) {
        [cell.labelDescription setText:store.store_desc];
        CGSize size = [cell.labelDescription sizeOfMultiLineLabel];
        
        return size.height + (CELL_CONTENT_MARGIN * 2);
    }
    
    [cell.labelDescription setText:store.store_desc];
    CGSize size = [cell.labelDescription sizeOfMultiLineLabel];
    CGRect frame = cell.labelDescription.frame;
    CGRect cellFrame = cell.frame;
    
    float totalHeightLabel = size.height + frame.origin.y + (18);
    
    if(totalHeightLabel > cell.frame.size.height) {
        frame.size = size;
        cell.labelDescription.frame = frame;
        
        float heightDiff = totalHeightLabel - cell.frame.size.height;
        
        cellFrame.size.height += heightDiff;
        cell.frame = cellFrame;
    }
    
    
    return totalHeightLabel+300;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    self.animationController.isPresenting = YES;
    
    return self.animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animationController.isPresenting = NO;
    
    return self.animationController;
}

-(void)didClickButtonRate:(id)sender {
    
    UserSession* userSession = [UserAccessSession getUserSession];
    if(userSession == nil) {
        
        [MGUtilities showAlertTitle:LOCALIZED(@"LOGIN_ERROR")
                            message:LOCALIZED(@"LOGIN_ERROR_USER_NOT_SIGNED_RATING_DETAILS")];
        
        return;
    }
    
    if(!_canRate) {
     
        [MGUtilities showAlertTitle:LOCALIZED(@"RATING_ERROR")
                            message:LOCALIZED(@"RATING_FINISHED_ERROR")];
        return;
    }
    
    if(_canRate && ![MGUtilities hasInternetConnection]) {
        
        [MGUtilities showAlertTitle:LOCALIZED(@"NETWORK_ERROR")
                            message:LOCALIZED(@"NETWORK_ERROR_DETAILS")];
        return;
    }
 
    RatingViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardNewRating"];
    controller.store = store;
    controller.ratingDelegate = self;
    
    self.animationController = [[ZoomAnimationController alloc] init];
    controller.transitioningDelegate  = self;
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)didReceiveNewRating:(NSDictionary *)dict store:(Store *)_store {
    store = _store;
    
    double rating = [store.rating_total doubleValue]/[store.rating_count doubleValue];
    _headerView.ratingView.rating = rating;
    
    NSString* info = [NSString stringWithFormat:@"%.2f %@ %@ %@",
                      rating, LOCALIZED(@"RATING_AVERAGE"),
                      store.rating_count,
                      LOCALIZED(@"RATING")];
    
    if([store.rating_total doubleValue] == 0 || [store.rating_count doubleValue] == 0 )
        info = LOCALIZED(@"NO_RATING");
    
    _headerView.labelExtraInfo.text = info;
    
    _canRate = NO;
    [self updateRating];
}


-(void) startSync {
    
    UserSession* userSession = [UserAccessSession getUserSession];
    
    if(![MGUtilities hasInternetConnection] || userSession == nil) {
        
        [self updateRating];
        return;
    }
   
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = LOCALIZED(@"SYNCING_RATING");
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    
    
    NSURL *url = [NSURL URLWithString:GET_RATING_USER_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            store.store_id, @"store_id",
                            userSession.userId, @"user_id",
                            userSession.loginHash, @"login_hash",
                            nil];
    
    [httpClient postPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"GET_RATING_SYNC = %@", responseStr);
        
        NSDictionary* dictStoreRating = [json objectForKey:@"store_rating"];
        NSDictionary* dictStatus = [json objectForKey:@"status"];
        
        if([[dictStatus valueForKey:@"status_code"] isEqualToString:STATUS_SUCCESS]) {
            
            if([[dictStatus valueForKey:@"status_code"] isEqualToString:STATUS_SUCCESS]) {
                
                if(dictStoreRating != nil) {
                    NSString* rate_code = [dictStoreRating valueForKey:@"can_rate"];
                    if([rate_code isEqualToString:STATUS_CAN_RATE])
                        _canRate = YES;
                    else
                        _canRate = NO;
                }
                else {
                    NSLog(@"ERROR STORE RATING");
                }
            }
            else {
                NSLog(@"ERROR FETCHING RATING");
            }
            
        }
        else {
            NSLog(@"RESPONSE ERROR = %@", [dictStatus valueForKey:@"status_text"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
    }];

}


-(void)updateRating {
    
    _headerView.buttonRate.enabled = YES;
    
//    if(!_canRate) {
//        _headerView.buttonRate.enabled = NO;
//    }
//    
//    UserSession* userSession = [UserAccessSession getUserSession];
//    if(userSession != nil) {
//        _headerView.buttonRate.enabled = YES;
//    }
//    else {
//        _headerView.buttonRate.enabled = NO;
//    }
    
}


-(void)didClickButtonWebsite:(id)sender {
    
    NewsDetailViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardNewsDetail"];
    vc.strUrl = store.buy_ticket;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)didClickButtonRoute:(id)sender {
    
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([store.lat doubleValue], [store.lon doubleValue]);
//    
//    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
//    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
//    mapItem.name = store.store_name;
//    
//    if ([mapItem respondsToSelector:@selector(openInMapsWithLaunchOptions:)]) {
//        [mapItem openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
//    }
//    else {
//        NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?daddr=%f,%f&saddr=Current+Location", coordinate.latitude, coordinate.longitude];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"uber://"]]) {
        // Do something awesome - the app is installed! Launch App.
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"uber://?action=setPickup&pickup=my_location"]];
        
    }
    else {
        // No Uber app! Open Mobile Website.
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.uber.com/"]];
    }

}


-(void)didClickButtonCall:(id)sender {
    
    if(store.phone_no == nil || [store.phone_no length] == 0 ) {
        
        [MGUtilities showAlertTitle:LOCALIZED(@"CONTACT_NO_SERVICE_ERROR")
                            message:LOCALIZED(@"CONTACT_NO_SERVICE_ERROR_MSG")];
        return;
    }
    
    NSString* trim = [MGUtilities removeDelimetersInPhoneNo:store.phone_no];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", trim] ]];
}

-(void)didClickButtonFacebook:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *shareSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [shareSheet setInitialText:LOCALIZED(@"FACEBOOK_STATUS_SHARE")];
        [shareSheet addImage:_headerView.imgViewPhoto.image];
        
        [shareSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    break;
                    
                default:
                    break;
            }
        }];
        
        if(!(shareSheet == nil))
            [self presentViewController:shareSheet animated:YES completion:nil];
    }
    else {
        [MGUtilities showAlertTitle:LOCALIZED(@"FACEBOOK_AUTHENTICATION_FAILED")
                            message:LOCALIZED(@"FACEBOOK_AUTHENTICATION_FAILED_MSG")];
    }
}

-(void)didClickButtonTwitter:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [tweetSheet setInitialText:LOCALIZED(@"TWITTER_STATUS_SHARE")];
        [tweetSheet addImage:_headerView.imgViewPhoto.image];
        
        //        [shareSheet addURL:[NSURL URLWithString:_website]];
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else {
        [MGUtilities showAlertTitle:LOCALIZED(@"TWITTER_AUTHENTICATION_FAILED")
                            message:LOCALIZED(@"TWITTER_AUTHENTICATION_FAILED_MSG")];
    }
    
}

-(void)didClickButtonEmail:(id)sender {
    
    if(store.email == nil || [store.email length] == 0 ) {
        [MGUtilities showAlertTitle:LOCALIZED(@"EMAIL_ERROR")
                            message:LOCALIZED(@"EMAIL_ERROR_MSG")];
        return;
    }
    
    if ([MFMailComposeViewController canSendMail]) {
        
        // set the sendTo address
        NSMutableArray *recipients = [[NSMutableArray alloc] initWithCapacity:1];
        [recipients addObject:store.email];
        
        MFMailComposeViewController* mailController = [[MFMailComposeViewController alloc] init];
        mailController.mailComposeDelegate = self;
        
        [mailController setSubject:LOCALIZED(@"EMAIL_SUBJECT")];
        
        NSString* formattedBody = [NSString stringWithFormat:@"%@", LOCALIZED(@"EMAIL_BODY")];
        
        [mailController setMessageBody:formattedBody isHTML:NO];
        [mailController setToRecipients:recipients];
        
        if(DOES_SUPPORT_IOS7) {
            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        WHITE_TEXT_COLOR, NSForegroundColorAttributeName, nil];
            
            [[mailController navigationBar] setTitleTextAttributes:attributes];
            [[mailController navigationBar ] setTintColor:[UIColor whiteColor]];
            
        }
        
        [self.view.window.rootViewController presentViewController:mailController animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }];
    }
    else {
        [MGUtilities showAlertTitle:LOCALIZED(@"EMAIL_SERVICE_ERROR")
                            message:LOCALIZED(@"EMAIL_SERVICE_ERROR_MSG")];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error {
    
	[self becomeFirstResponder];
	[controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)didClickButtonSMS:(id)sender {
    
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    
    if([MFMessageComposeViewController canSendText]) {
        
        NSString* formattedBody = [NSString stringWithFormat:@"%@", LOCALIZED(@"SMS_BODY")];
        
        controller.body = formattedBody;
        
        NSString* trim = [MGUtilities removeDelimetersInPhoneNo:store.sms_no];
        
        if(store.sms_no != nil || [store.sms_no length] == 0)
            trim = [MGUtilities removeDelimetersInPhoneNo:store.sms_no];
        
        controller.recipients = @[ trim, ];
        controller.messageComposeDelegate = self;
        controller.view.backgroundColor = BG_VIEW_COLOR;
        
        if(DOES_SUPPORT_IOS7) {
            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        WHITE_TEXT_COLOR, NSForegroundColorAttributeName, nil];
            
            [[controller navigationBar] setTitleTextAttributes:attributes];
            [[controller navigationBar ] setTintColor:[UIColor whiteColor]];
            
        }
        
        
        [self.view.window.rootViewController presentViewController:controller animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }];
        
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller
                didFinishWithResult:(MessageComposeResult)result {
    
    [self becomeFirstResponder];
	[controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MAP Delegate

-(void) MGMapView:(MGMapView*)mapView didSelectMapAnnotation:(MGMapAnnotation*)mapAnnotation {
    
}

-(void) MGMapView:(MGMapView*)mapView didAccessoryTapped:(MGMapAnnotation*)mapAnnotation {
    
}

-(void) MGMapView:(MGMapView*)mapView didCreateMKPinAnnotationView:(MKPinAnnotationView*)mKPinAnnotationView viewForAnnotation:(id<MKAnnotation>)annotation {
    
//    UIImageView *imageView = [[UIImageView alloc] init];
//    UIImage* imageAnnotation = [UIImage imageNamed:MAP_ARROW_RIGHT];
//    [imageView setImage:imageAnnotation];
    
    mKPinAnnotationView.image = [UIImage imageNamed:MAP_PIN];
    
//    imageView.frame = CGRectMake (0, 0, imageAnnotation.size.width, imageAnnotation.size.height);
//    mKPinAnnotationView.rightCalloutAccessoryView = imageView;
    
    
}


@end
