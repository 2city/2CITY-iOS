//
//  SearchViewController.m
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchRawView.h"
#import "SearchResultViewController.h"
#import "AppDelegate.h"

@interface SearchViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, CLLocationManagerDelegate>{
    
    SearchRawView* _searchView;
    NSMutableArray* _arrayCategories;
    CLLocationManager* _myLocationManager;
    CLLocation* _myLocation;
}

@end

@implementation SearchViewController

@synthesize scrollViewMain;

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
    
    _searchView = [[SearchRawView alloc] initWithNibName:@"SearchView"];
    _searchView.textFieldKeyword.delegate = self;
    
    
    _searchView.labelNearby.textColor = THEME_BLACK_TINT_COLOR;
    _searchView.labelCategory.textColor = THEME_BLACK_TINT_COLOR;
    _searchView.labelRadius.textColor = THEME_BLACK_TINT_COLOR;
    
    _searchView.labelNearby.text = LOCALIZED(@"SEARCH_NEARBY");
    _searchView.labelCategory.text = LOCALIZED(@"SEARCH_CATEGORIES");
    _searchView.labelRadius.text = LOCALIZED(@"SEARCH_RADIUS");
    _searchView.textFieldKeyword.placeholder = LOCALIZED(@"SEARCH_ANY_KEYWORDS");
    
    _searchView.switchNearby.on = NO;
    [self updateNearby];
    [_searchView.switchNearby addTarget:self
                                 action:@selector(didClickSwitchNearby:)
                       forControlEvents:UIControlEventValueChanged];
    
    [_searchView.sliderRadius addTarget:self
                                 action:@selector(didClickSliderRadius:)
                       forControlEvents:UIControlEventValueChanged];
    
    _searchView.sliderRadius.value = SEARCH_RADIUS_KILOMETERS_DEFAULT;
    _searchView.sliderRadius.maximumValue = SEARCH_RADIUS_KILOMETERS;
    _searchView.sliderRadius.minimumValue = SEARCH_RADIUS_KILOMETERS_MINIMUM;
    
    [self updateRadius];
    
    _arrayCategories = [NSMutableArray arrayWithArray:[CoreDataController getCategoryNames]];
    [_arrayCategories insertObject:LOCALIZED(@"CATEGORY_ALL") atIndex:0];
    
    _searchView.pickerCategories.delegate = self;
    _searchView.pickerCategories.dataSource = self;
    
    scrollViewMain.contentSize = _searchView.frame.size;
    [scrollViewMain addSubview:_searchView];
    
    
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
    
    [_searchView.buttonSearch addTarget:self
                                  action:@selector(didClickButtonSearch:)
                        forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* itemMenu;
    itemMenu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:BUTTON_MENU]
                                                style:UIBarButtonItemStylePlain
                                               target:self
                                               action:@selector(didClickBarButtonMenu:)];
    
    self.navigationItem.leftBarButtonItem = itemMenu;
    
    [_searchView.buttonSearch setTitle:LOCALIZED(@"SEARCH") forState:UIControlStateNormal];
    [_searchView.buttonSearch setTitle:LOCALIZED(@"SEARCH") forState:UIControlStateSelected];
    
    _searchView.switchNearby.tintColor = THEME_BLACK_TINT_COLOR;
    _searchView.switchNearby.onTintColor = THEME_ORANGE_COLOR;
    
    _searchView.textFieldKeyword.textColor = THEME_ORANGE_COLOR;
    _searchView.textFieldKeyword.autocorrectionType = UITextAutocorrectionTypeNo;
    [_searchView.imgViewPhoto setImage:[UIImage imageNamed:TEXT_BOX_SEARCH_NORMAL]];
    
    [MGUtilities createBordersInView:_searchView.pickerCategories
                         borderColor:THEME_ORANGE_COLOR
                         shadowColor:[UIColor clearColor]
                         borderWidth:2.0f
                        borderRadius:5.0f];
    
    
    [_searchView.sliderRadius setMinimumTrackImage:[UIImage imageNamed:SLIDER_FILL_IMAGE]
                                          forState:UIControlStateNormal];
    
    [_searchView.sliderRadius setMinimumTrackImage:[UIImage imageNamed:SLIDER_FILL_IMAGE]
                                          forState:UIControlStateSelected];
    
    [_searchView.sliderRadius setMaximumTrackImage:[UIImage imageNamed:SLIDER_TRACK_IMAGE]
                                          forState:UIControlStateNormal];
    
    [_searchView.sliderRadius setMaximumTrackImage:[UIImage imageNamed:SLIDER_TRACK_IMAGE]
                                          forState:UIControlStateSelected];
    
    
//    [_searchView.sliderRadius setThumbImage:[UIImage imageNamed:SLIDER_HANDLE_IMAGE]
//                                   forState:UIControlStateNormal];
//    
//    [_searchView.sliderRadius setThumbImage:[UIImage imageNamed:SLIDER_HANDLE_SELECTED_IMAGE]
//                                   forState:UIControlStateSelected];
    
}

-(void)didClickBarButtonMenu:(id)sender {
    
    AppDelegate* delegate = [AppDelegate instance];
    [delegate.sideViewController updateUI];
    
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

-(void)didClickSwitchNearby:(id)sender {
    
    [self updateNearby];
}

-(void)updateNearby {
    BOOL isOn = _searchView.switchNearby.on;
    
    if(isOn) {
        _searchView.sliderRadius.enabled = YES;
        [self findMyCurrentLocation];
    }
    else {
        _searchView.sliderRadius.enabled = NO;
        _myLocation = nil;
    }
}

-(void)didClickSliderRadius:(id)sender {
    
    [self updateRadius];
}

-(void)updateRadius {
    
    int val = _searchView.sliderRadius.value;
    
    NSString* str = [NSString stringWithFormat:@"%@ %d %@", LOCALIZED(@"RADIUS"), val, LOCALIZED(@"RADIUS_KILOMETERS")];
    [_searchView.labelRadius setText:str];
}


-(void)keyboardDidShow:(id)sender {
    
    UIEdgeInsets inset = scrollViewMain.contentInset;
    inset.bottom = 216;
    scrollViewMain.contentInset = inset;
    
    inset = scrollViewMain.scrollIndicatorInsets;
    inset.bottom = 216;
    scrollViewMain.scrollIndicatorInsets = inset;
}

-(void)keyboardDidHide:(id)sender {
    
    UIEdgeInsets inset = scrollViewMain.contentInset;
    inset.bottom = NAV_BAR_NO_OFFSET;
    scrollViewMain.contentInset = inset;
    
    inset = scrollViewMain.scrollIndicatorInsets;
    inset.bottom = NAV_BAR_NO_OFFSET;
    scrollViewMain.scrollIndicatorInsets = inset;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _searchView.textFieldKeyword) {
		[_searchView.textFieldKeyword resignFirstResponder];
        [_searchView.imgViewPhoto setImage:[UIImage imageNamed:TEXT_BOX_SEARCH_NORMAL]];
        _searchView.textFieldKeyword.textColor = THEME_ORANGE_COLOR;
	}
	
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [_searchView.imgViewPhoto setImage:[UIImage imageNamed:TEXT_BOX_SEARCH_SELECTED]];
    _searchView.textFieldKeyword.textColor = WHITE_TEXT_COLOR;
    
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    [_searchView.imgViewPhoto setImage:[UIImage imageNamed:TEXT_BOX_SEARCH_NORMAL]];
    _searchView.textFieldKeyword.textColor = THEME_ORANGE_COLOR;
    [textField resignFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
}


-(void)didClickButtonSearch:(id)sender {
    [self beginSearching];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)beginSearching {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = LOCALIZED(@"SEARCHING");
    
    [self.view addSubview:hud];
	[self.view setUserInteractionEnabled:NO];
    
	NSMutableArray* arrayFilter = [NSMutableArray new];
	[hud showAnimated:YES whileExecutingBlock:^{
        
		[self doSearch:arrayFilter];
        
	} completionBlock:^{
        
		[hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        if(arrayFilter.count == 0) {
            if(arrayFilter == nil || arrayFilter.count == 0) {
                
                UIColor* color = [THEME_ORANGE_COLOR colorWithAlphaComponent:0.70];
                [MGUtilities showStatusNotifier:LOCALIZED(@"NO_RESULTS")
                                      textColor:[UIColor whiteColor]
                                 viewController:self
                                       duration:0.5f
                                        bgColor:color
                                            atY:64];
            }
        }
        else {
            SearchResultViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardSearchResult"];
            vc.arrayResults = arrayFilter;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
	}];
    
}

-(void)doSearch:(NSMutableArray*) arrayFilter {
    
    NSString* strKeywords = [[_searchView.textFieldKeyword text] lowercaseString];
    
    int radius = _searchView.sliderRadius.value;
    NSInteger index = [_searchView.pickerCategories selectedRowInComponent:0];
    NSString* category = _arrayCategories[index];
    
    int countParams = strKeywords.length > 0 ? 1 : 0;
    countParams += radius > 0 && _searchView.switchNearby.on ? 1 : 0;
    countParams += category.length > 0 ? 1 : 0;
    
    NSArray* arrayStores = [CoreDataController getAllStores];
    for(Store* store in arrayStores) {
        
        int qualifyCount = 0;
        
        
        BOOL isFoundKeyword = ([store.store_name containsString:strKeywords] ||
                               [store.store_address containsString:strKeywords] );
        
        if( strKeywords.length > 0  && isFoundKeyword)
            qualifyCount += 1;
        
        if( category.length > 0) {
            
            StoreCategory* storeCat = [CoreDataController getCategoryByCategory:category];
            
            BOOL isFoundCat = NO;
            
            if(storeCat != nil && [storeCat.category_id isEqualToString:store.category_id])
                isFoundCat = YES;
            
            NSString* categoryAll = LOCALIZED(@"CATEGORY_ALL");
            
            if([category containsString:[categoryAll lowercaseString]])
                isFoundCat = YES;
            
            if(isFoundCat)
                qualifyCount += 1;
        }
        
        store.distance = LOCALIZED(@"NOT_AVAILABLE");
        if(_myLocation != nil && radius > 0) {
            CLLocationCoordinate2D coord;
            coord = CLLocationCoordinate2DMake([store.lat doubleValue], [store.lon doubleValue]);
            CLLocation *location = [[CLLocation alloc] initWithLatitude:coord.latitude
                                                              longitude:coord.longitude];
            
            double distance = [_myLocation distanceFromLocation:location] / 1000;
            store.distance = [NSString stringWithFormat:@"%f", distance];
            
            if(distance <= radius)
                qualifyCount += 1;
        }
        
        if(qualifyCount == countParams)
            [arrayFilter addObject:store];
    }
    
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


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return _arrayCategories.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return _arrayCategories[row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    //Here, like the table view you can get the each section of each row if you've multiple sections
    //    NSLog(@"Selected Color: %@. Index of selected color: %i", [arrayColors objectAtIndex:row], row);
    
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        [tView setTextColor:THEME_MAIN_COLOR];
        [tView setFont:[UIFont fontWithName:@"GillSans" size:17]];
        [tView setTextAlignment:NSTextAlignmentCenter];
    }
    // Fill the label text here
    tView.text = _arrayCategories[row];
    
    return tView;
}

#pragma mark - FIND USER LOCATION

-(void)findMyCurrentLocation {
    
    _myLocationManager = [[CLLocationManager alloc] init];
    _myLocationManager.delegate = self;
    
    if(IS_OS_8_OR_LATER) {
        [_myLocationManager requestWhenInUseAuthorization];
        [_myLocationManager requestAlwaysAuthorization];
    }
    
    [_myLocationManager startUpdatingLocation];
    
    if( [CLLocationManager locationServicesEnabled] ) {
        NSLog(@"Location Services Enabled....");
    }
    else {
        [MGUtilities showAlertTitle:LOCALIZED(@"LOCATION_SERVICE_ERROR")
                            message:LOCALIZED(@"LOCATION_SERVICE_NOT_ENABLED")];
        
        _searchView.switchNearby.on = NO;
    }
    
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    _myLocation = newLocation;
    [manager stopUpdatingLocation];
}


- (void)locationManager: (CLLocationManager *)manager didFailWithError: (NSError *)error {
    
    [MGUtilities showAlertTitle:LOCALIZED(@"LOCATION_SERVICE_ERROR")
                        message:error.localizedDescription];
    
}

@end
