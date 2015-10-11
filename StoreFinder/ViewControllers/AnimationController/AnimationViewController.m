//
//  AnimationViewController.m
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "AnimationViewController.h"
#import "AppDelegate.h"

@interface AnimationViewController ()

@end

@implementation AnimationViewController

@synthesize scrollViewMain;

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
    self.screenName = @"Animation Screen";
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
    
    _animationView = [[MGRawView alloc] initWithFrame:scrollViewMain.frame nibName:@"AnimationView"];
    
    [_animationView.label1 setText:LOCALIZED(@"MENU_ANIMATION")];
    
    [_animationView.segmentAnimation setTitle:LOCALIZED(@"DEFAULT") forSegmentAtIndex:0];
//    [_animationView.segmentAnimation setTitle:LOCALIZED(@"FOLD") forSegmentAtIndex:1];
    [_animationView.segmentAnimation setTitle:LOCALIZED(@"ZOOM") forSegmentAtIndex:1];
    
    AppDelegate* delegate = [AppDelegate instance];
    [_animationView.segmentAnimation setTintColor:THEME_BLACK_TINT_COLOR];
    [_animationView.segmentAnimation setSelectedSegmentIndex:[delegate getTransitionIndex]];
    
    [_animationView.segmentAnimation addTarget:self
                                        action:@selector(didSelectSegmentAnimation:)
                              forControlEvents:UIControlEventValueChanged];
    
    [scrollViewMain addSubview:_animationView];
    scrollViewMain.contentSize = _animationView.frame.size;

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


-(void)didSelectSegmentAnimation:(id)sender {
    
    int index = (int) [_animationView.segmentAnimation selectedSegmentIndex];
    
    AppDelegate* delegate = [AppDelegate instance];
    [delegate setTransitionIndex:index];
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

@end
