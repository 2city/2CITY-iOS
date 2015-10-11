//
//  ContentViewController.m
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "ContentViewController.h"
#import "AppDelegate.h"
#import "NewsDetailViewController.h"
#import "DetailViewController.h"
#import "INTULocationManager.h"

@interface ContentViewController () < MGListViewDelegate>


@end

@implementation ContentViewController

@synthesize listViewNews;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];
    self.screenName = @"Content View Screen";
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
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
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    listViewNews.delegate = self;
    listViewNews.cellHeight = 250;
    
    [listViewNews registerNibName:@"SliderCell" cellIndentifier:@"SliderCell"];
    [listViewNews baseInit];
    
    [self beginParsing];
    
    UIBarButtonItem* itemMenu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:BUTTON_MENU]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(didClickBarButtonMenu:)];
    self.navigationItem.leftBarButtonItem = itemMenu;
    
}

-(void)didClickBarButtonMenu:(id)sender {
    
    AppDelegate* delegate = [AppDelegate instance];
    [delegate.sideViewController updateUI];
    
    
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
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

-(void)beginParsing {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = LOCALIZED(@"LOADING");
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
	[hud showAnimated:YES whileExecutingBlock:^{
        
		[self performParsing];
        
	} completionBlock:^{
        
		[hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        [self setData];
        INTULocationManager *locMgr = [INTULocationManager sharedInstance];
        [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyNeighborhood
                                           timeout:10.0f
                              delayUntilAuthorized:YES
                                             block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                                     [listViewNews reloadData];
                                                     CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
                                                     [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
                                                         if (placemarks != nil) {
                                                             NSLog(@"Got a zip code: %@", [placemarks[0] locality]);
                                                             NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                for (int i=0; i<listViewNews.arrayData.count; i++) {
                    Store* store = [listViewNews.arrayData objectAtIndex:i];
                    if([[store.phone_no uppercaseString] isEqualToString:[[placemarks[0] locality] uppercaseString]])
                {                      [tempArray addObject:store];
                                                                 }
                                                                 
                }
                if(tempArray.count!=0)
                {             listViewNews.arrayData = [[NSMutableArray alloc] initWithArray:tempArray];
                                                             }
                                                             NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sortDate" ascending:TRUE];
                                                             
                                                             NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
                                                             
                                                             listViewNews.arrayData = [[NSMutableArray alloc] initWithArray:[listViewNews.arrayData sortedArrayUsingDescriptors:sortDescriptors]];

  [listViewNews reloadData];

                                                             
                                                             
                                                         } else if(error.code == kCLErrorGeocodeFoundNoResult) {
                                                             NSLog(@"%s, %@", __func__, @"No result yet.");
                                                             [listViewNews reloadData];

                                                         } else {
                                                             [listViewNews reloadData];
  NSLog(@"%s, geocoding failed, erro: %@", __func__, error);
                                                         }
                                                     }];
	}];
    }];
    
}

-(void) performParsing {
    
    [DataParser fetchServerData];
}


-(void) setData {
    
    listViewNews.arrayData = [NSMutableArray arrayWithArray:[CoreDataController getFeaturedStores]];
    
    for (int i=0; i<listViewNews.arrayData.count; i++) {
        Store* store = [listViewNews.arrayData objectAtIndex:i];

        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSDate *dtForOrder = [dateFormat dateFromString:store.date_for_ordering];
        store.sortDate = dtForOrder;
    }
    
    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sortDate" ascending:NO];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
    
    listViewNews.arrayData = [[NSMutableArray alloc] initWithArray:[listViewNews.arrayData sortedArrayUsingDescriptors:sortDescriptors]];
    [listViewNews reloadData];
    
    
}
-(void)setImage:(NSString*)imageUrl imageView:(UIImageView*)imgView {
    
    [imgView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:SLIDER_PLACEHOLDER]];
    
}

-(void) MGListView:(MGListView *)_listView didSelectCell:(MGListCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    DetailViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardDetail"];
    vc.store = listViewNews.arrayData[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableViewCell*)MGListView:(MGListView *)listView1 didCreateCell:(MGListCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    if(cell != nil) {
        Store* store = [listViewNews.arrayData objectAtIndex:indexPath.row];
        Photo* p = [CoreDataController getStorePhotoByStoreId:store.store_id];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        [cell.labelDescription setText:store.phone_no];
        
        if(p != nil)
            [self setImage:p.thumb_url imageView:cell.imgViewThumb];
        else
            [self setImage:nil imageView:cell.imgViewThumb];
        
        
        cell.labelHeader1.backgroundColor = [BLACK_TEXT_COLOR colorWithAlphaComponent:0.50];
        
        cell.lblNonSelectorTitle.textColor = THEME_ORANGE_COLOR;
        cell.labelSubtitle.textColor = WHITE_TEXT_COLOR;
        
        cell.lblNonSelectorTitle.text = store.store_name;
        cell.labelSubtitle.text = store.store_address;
        cell.labelDateAdded.text = store.sms_no;
        
        
        
        
    }
    
    return cell;
}

-(void)MGListView:(MGListView *)listView scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

@end
