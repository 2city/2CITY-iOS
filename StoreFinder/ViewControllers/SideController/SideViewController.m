//
//  SideViewController.m
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "SideViewController.h"
#import "AppDelegate.h"
#import "NewsDetailViewController.h"

@interface SideViewController ()

@property (nonatomic, retain) NSArray* titles;
@property (nonatomic, retain) NSArray* extras;
@property (nonatomic, retain) NSArray* headers;
@property (nonatomic, retain) NSArray* users;

@end

@implementation SideViewController

@synthesize tableViewSide;
@synthesize buttonMenuClose;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    tableViewSide.delegate = self;
    tableViewSide.dataSource = self;

        [self updateUI];
}

- (void)viewDidLoad
{
    if(IS_IPHONE_4_AND_OLDER)
        imgSlide.frame = CGRectMake(0, 0, 235, self.tableViewSide.frame.origin.y);
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = SIDE_VIEW_BG_COLOR;
//    tableViewSide.frame = CGRectMake(self, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    tableViewSide.delegate = self;
    tableViewSide.dataSource = self;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    int x = self.view.frame.size.width - ANCHOR_LEFT_PEEK - 1;
    gradientLayer.frame = CGRectMake(x, 0, 2, self.view.frame.size.height);
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)THEME_BLACK_TINT_COLOR.CGColor,
                            (id)[UIColor clearColor].CGColor,
                            nil];
    gradientLayer.startPoint = CGPointMake(-2, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    [self.view.layer addSublayer:gradientLayer];
    
    self.titles =
    @[

      @{@"title": LOCALIZED(@"HOME"), @"icon": ICON_HOME},
      @{@"title": LOCALIZED(@"BUY TICKETS"), @"icon": ICON_BUYTICKET},
      @{@"title": LOCALIZED(@"MUSIC"), @"icon": ICON_NEWS},

      @{@"title": LOCALIZED(@"CATEGORIES"), @"icon": ICON_CATEGORIES},
      @{@"title": LOCALIZED(@"PROFILE"), @"icon": ICON_PROFILE},
      @{@"title": LOCALIZED(@"ABOUT_US"), @"icon": ICON_ABOUT_US},
      @{@"title": LOCALIZED(@"TERMS_CONDITIONS"), @"icon": ICON_TERMS_CONDITIONS},

      ];

//    self.extras =
//    @[
//      @{@"title": LOCALIZED(@"ABOUT_US"), @"icon": ICON_ABOUT_US},
//      @{@"title": LOCALIZED(@"TERMS_CONDITIONS"), @"icon": ICON_TERMS_CONDITIONS},
//      ];
//    
//    self.users =
//    @[
//      @{@"title": LOCALIZED(@"REGISTER"), @"icon": ICON_REGISTER},
//      @{@"title": LOCALIZED(@"LOGIN"), @"icon": ICON_LOGIN}
//      ];
//    
//    self.headers =
//    @[
//      @{@"title": LOCALIZED(@"HEADER_CATEGORIES")},
//      @{@"title": LOCALIZED(@"HEADER_EXTRAS")},
//      @{@"title": LOCALIZED(@"HEADER_USER")}
//      ];
    
    buttonMenuClose.tag = kMenuAnimationClosed;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)didClickButtonMenu:(id)sender {
    
    CGFloat angle = 0;
    
    if(buttonMenuClose.tag == kMenuAnimationClosed) {
        angle = M_PI;
        buttonMenuClose.tag = kMenuAnimationOpen;
    }
    else {
        angle = 0;
        buttonMenuClose.tag = kMenuAnimationClosed;
    }
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        buttonMenuClose.imageView.transform = CGAffineTransformMakeRotation(angle);
    
    } completion:^(BOOL finished) {
        
        [self.slidingViewController resetTopViewAnimated:YES];
        
    }];
}

- (void) showViewController:(UIViewController*)viewController {
    
    UINavigationController* navController = (UINavigationController*)[self.slidingViewController topViewController];
    [navController popToRootViewControllerAnimated:NO];
    
    UIViewController* currentViewController = [[navController viewControllers] objectAtIndex:0];
    
    if([currentViewController isKindOfClass:[viewController class]])
        return;
    
    [navController setViewControllers:[NSArray arrayWithObject:viewController] animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 1;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0)
        return [self.titles count];
    
//    if (section == 1)
//        return [self.extras count];
//    
//    if (section == 2)
//        return [self.users count];
    
//    return 0;
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    MGListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntryCell"];
    
    /*
     *   If the cell is nil it means no cell was available for reuse and that we should
     *   create a new one.
     */
    if (cell == nil) {
        
        /*
         *   Actually create a new cell (with an identifier so that it can be dequeued).
         */
        
        cell = [[MGListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EntryCell"];
        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
//    MGListCell* cell =  [tableView dequeueReusableCellWithIdentifier:@"EntryCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectedColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0];
    cell.unSelectedColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0];
    
    cell.selectedImage = [UIImage imageNamed:SIDE_BAR_CELL_SELECTED];
    cell.unselectedImage = [UIImage imageNamed:SIDE_BAR_CELL_NORMAL];
//    cell.imgViewSelectionBackground.frame = cell.frame;
    cell.imgViewSelectionBackground.contentMode = UIViewContentModeScaleAspectFill;
    cell.imgViewSelectionBackground.layer.masksToBounds = TRUE;
    NSString* title = @"";
    
//    if(indexPath.section == 0) {
        NSDictionary* dict = self.titles[indexPath.row];
        title = dict[@"title"];
        
        UIImage* img = [UIImage imageNamed:dict[@"icon"]];
        cell.selectedImageIcon = img;
        cell.unselectedImageIcon = img;
//    }
    
//    if(indexPath.section == 1) {
//        NSDictionary* dict = self.extras[indexPath.row];
//        title = dict[@"title"];
//        
//        UIImage* img = [UIImage imageNamed:dict[@"icon"]];
//        cell.selectedImageIcon = img;
//        cell.unselectedImageIcon = img;
//    }
//    
//    if(indexPath.section == 2) {
//        NSDictionary* dict = self.users[indexPath.row];
//        title = dict[@"title"];
//        
//        UIImage* img = [UIImage imageNamed:dict[@"icon"]];
//        cell.selectedImageIcon = img;
//        cell.unselectedImageIcon = img;
//    }
    cell.imgViewIcon.frame = CGRectMake(15, 10, 18, 18);
    cell.imgViewIcon.contentMode = UIViewContentModeScaleAspectFit;
    [cell.labelTitle setText:[title uppercaseString]];
    [cell.labelTitle setFont:[UIFont fontWithName:@"GillSans" size:14]];

    return cell;
}

//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    MGListCell* headerCell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
//    
//    NSDictionary* dict = self.headers[section];
//    [headerCell.labelTitle setText:dict[@"title"]];
//    
//    return nil;
////    return headerCell;
//    
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // This undoes the Zoom Transition's scale because it affects the other transitions.
    // You normally wouldn't need to do anything like this, but we're changing transitions
    // dynamically so everything needs to start in a consistent state.
    self.slidingViewController.topViewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
    

    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        UIViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardContent"];
        [self showViewController:viewController];


    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        NewsDetailViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardNewsDetail"];
        AppDelegate* delegate = [AppDelegate instance];
        
        vc.strUrl = delegate.buyURLGlobal;
        vc.strShow = @"1";
//        vc.navigationController.navigationBarHidden = FALSE;
//        UINavigationController *newNav = [[UINavigationController alloc] initWithRootViewController:self];
//        newNav.navigationBarHidden = TRUE;
//        newNav.navigationController.navigationBarHidden = FALSE;
        
//            [self.navigationController pushViewController:vc animated:YES];
        //        AppDelegate* delegate = [AppDelegate instance];
//        [[delegate.window rootViewController] presentViewController:newNav animated:YES completion:nil];
//        [newNav pushViewController:vc animated:TRUE];
                [self showViewController:vc];

        
    }

    
    if (indexPath.section == 0 && indexPath.row == 2) {
        //        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardCategories"];
        
        UIViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardNews"];
        [self showViewController:viewController];
    }
    
    if (indexPath.section == 0 && indexPath.row == 3) {
        UIViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardCategories"];
        [self showViewController:viewController];


    }
    
    if(indexPath.section == 0 && indexPath.row == 4) {
//        UIViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardFeatured"];
//        [self showViewController:viewController];

        
        UserSession* user = [UserAccessSession getUserSession];
        NSString* identifier = @"storyboardLogin";
        
        if(user != nil)
            identifier = @"storyboardProfile";
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"User_iPhone" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:identifier];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        AppDelegate* delegate = [AppDelegate instance];
        [[delegate.window rootViewController] presentViewController:vc animated:YES completion:nil];

        
    }
    
    if(indexPath.section == 0 && indexPath.row == 5) {
//        UIViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardMap"];
//        [self showViewController:viewController];
        UIViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardAboutUs"];
        [self showViewController:viewController];

    }
    
    if(indexPath.section == 0 && indexPath.row == 6) {
//        UIViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardSearch"];
//        [self showViewController:viewController];
        UIViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardTermsConditions"];
        [self showViewController:viewController];

    }
    
    if(indexPath.section == 0 && indexPath.row == 7) {
        UIViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardNews"];
        [self showViewController:viewController];
    }
    
    if(indexPath.section == 0 && indexPath.row == 8) {
        UIViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardWeather"];
        [self showViewController:viewController];
    }
    
    if(indexPath.section == 1 && indexPath.row == 0) {
        UIViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardAboutUs"];
        [self showViewController:viewController];
    }
    
    if(indexPath.section == 1 && indexPath.row == 1) {
        UIViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardTermsConditions"];
        [self showViewController:viewController];
    }
    
    if(indexPath.section == 1 && indexPath.row == 2) {
        UIViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardAnimation"];
        [self showViewController:viewController];
    }
    
    if(indexPath.section == 2 && indexPath.row == 0) {
        
        UserSession* user = [UserAccessSession getUserSession];
        NSString* identifier = @"storyboardRegister";
        
        if(user != nil)
            identifier = @"storyboardProfile";
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"User_iPhone" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:identifier];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        AppDelegate* delegate = [AppDelegate instance];
        [[delegate.window rootViewController] presentViewController:vc animated:YES completion:nil];

    }
    
    if(indexPath.section == 2 && indexPath.row == 1) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"User_iPhone" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"storyboardLogin"];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        AppDelegate* delegate = [AppDelegate instance];
        [[delegate.window rootViewController] presentViewController:vc animated:YES completion:nil];
    }
    
    [self.slidingViewController resetTopViewAnimated:YES];
}


-(void)updateUI {
    
    UserSession* user = [UserAccessSession getUserSession];
    
    if( user != nil ) {
        
//        self.users =
//        @[
//          @{@"title": LOCALIZED(@"PROFILE"), @"icon": ICON_PROFILE}
//          
//          
//          
//          
//          ];

        self.titles =
        @[
          @{@"title": LOCALIZED(@"HOME"), @"icon": ICON_HOME},
          @{@"title": LOCALIZED(@"BUY TICKETS"), @"icon": ICON_BUYTICKET},
          @{@"title": LOCALIZED(@"MUSIC"), @"icon": ICON_NEWS},
          
          @{@"title": LOCALIZED(@"CATEGORIES"), @"icon": ICON_CATEGORIES},
          @{@"title": LOCALIZED(@"PROFILE"), @"icon": ICON_PROFILE},
          @{@"title": LOCALIZED(@"ABOUT_US"), @"icon": ICON_ABOUT_US},
          @{@"title": LOCALIZED(@"TERMS_CONDITIONS"), @"icon": ICON_TERMS_CONDITIONS},
          
          ];

        
    }
    else {
        
        self.titles =
        @[
          @{@"title": LOCALIZED(@"HOME"), @"icon": ICON_HOME},
          @{@"title": LOCALIZED(@"BUY TICKETS"), @"icon": ICON_BUYTICKET},
          @{@"title": LOCALIZED(@"MUSIC"), @"icon": ICON_NEWS},
          
          @{@"title": LOCALIZED(@"CATEGORIES"), @"icon": ICON_CATEGORIES},
          @{@"title": LOCALIZED(@"LOGIN"), @"icon": ICON_PROFILE},
          @{@"title": LOCALIZED(@"ABOUT_US"), @"icon": ICON_ABOUT_US},
          @{@"title": LOCALIZED(@"TERMS_CONDITIONS"), @"icon": ICON_TERMS_CONDITIONS},
          
          ];

        
//        self.users =
//        @[
////          @{@"title": LOCALIZED(@"REGISTER"), @"icon": ICON_REGISTER},
//          @{@"title": LOCALIZED(@"LOGIN"), @"icon": ICON_LOGIN}
//          ];
    }
    
    [tableViewSide reloadData];
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
