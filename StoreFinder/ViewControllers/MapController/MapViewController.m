//
//  MapViewController.m
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "MapViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"

@interface MapViewController ()


@end

@implementation MapViewController

@synthesize mapViewMain;
@synthesize buttonDraw;
@synthesize labelDistance;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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
    
    UIBarButtonItem* itemMenu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:BUTTON_MENU]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(didClickBarButtonMenu:)];
    self.navigationItem.leftBarButtonItem = itemMenu;
    
    mapViewMain.delegate = self;
    [mapViewMain baseInit];
    
    _insideBoundsArray = [[NSMutableArray alloc] init];
    
    labelDistance.textColor = THEME_MAIN_COLOR;
    labelDistance.text = @"";
    
    
    [self beginParsing];
}

-(void)didClickBarButtonMenu:(id)sender {
    
    AppDelegate* delegate = [AppDelegate instance];
    [delegate.sideViewController updateUI];
    
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

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
        [self findMyCurrentLocation];
        [mapViewMain zoomAndFitAnnotations];
	}];
    
}
-(void) performParsing {
    
    [DataParser fetchServerData];
    
    if(_arrayData == nil)
        _arrayData = [NSMutableArray new];
    
    [_arrayData removeAllObjects];
    
    _arrayData = [NSMutableArray arrayWithArray:[CoreDataController getAllStores]];
    
    [self addMapAnnotations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addMapAnnotations {
    
    NSMutableArray* annotations = [NSMutableArray new];
    for(Store* store in _arrayData) {
        
        CLLocationCoordinate2D coords;
        coords = CLLocationCoordinate2DMake([store.lat doubleValue], [store.lon doubleValue]);
        
        if(CLLocationCoordinate2DIsValid(coords)) {
            MGMapAnnotation* ann = [[MGMapAnnotation alloc] initWithCoordinate:coords
                                                                          name:store.store_name
                                                                   description:store.store_address];
            
            ann.object = store;
            [annotations addObject:ann];
        }
        
    }
    
    [mapViewMain setMapData:annotations];
    
    if(annotations == nil || annotations.count == 0) {
        
        UIColor* color = [THEME_ORANGE_COLOR colorWithAlphaComponent:0.70];
        [MGUtilities showStatusNotifier:LOCALIZED(@"NO_RESULTS")
                              textColor:[UIColor whiteColor]
                         viewController:self
                               duration:0.5f
                                bgColor:color
                                    atY:self.view.frame.size.height - 40];
    }
}

-(void) MGMapView:(MGMapView*)mapView didSelectMapAnnotation:(MGMapAnnotation*)mapAnnotation {
    
    if([mapAnnotation isKindOfClass:[MGMapAnnotation class]]) {
        [self showInfoView:mapAnnotation.object];
    }
    
    _selectedAnnotation = mapAnnotation;
    
    if(_myLocation != nil)
        [self getDistance];
}



-(void) MGMapView:(MGMapView*)mapView didAccessoryTapped:(MGMapAnnotation*)mapAnnotation {
    
}

-(void) MGMapView:(MGMapView*)mapView didCreateMKPinAnnotationView:(MKPinAnnotationView*)mKPinAnnotationView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    mKPinAnnotationView.canShowCallout = NO;
    mKPinAnnotationView.animatesDrop = NO;
    
    mKPinAnnotationView.pinColor = MKPinAnnotationColorGreen;
    
    MGMapAnnotation* ann = (MGMapAnnotation*)annotation;
    Store* store = ann.object;
    StoreCategory* cat = [CoreDataController getCategoryByCategoryId:store.category_id];
    
    [self loadMapPinImage:cat.category_icon annotationView:mKPinAnnotationView];
}

-(MKOverlayView*)MGMapView:(MGMapView *)mapView viewForOverlay:(id)overlay {
    
    if ([overlay isKindOfClass:MKPolyline.class]) {
        
        MKPolylineRenderer * lineView = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        lineView.lineWidth = 3.5f;
        lineView.strokeColor = THEME_MAIN_COLOR;
        
        return (MKOverlayView*)lineView;
    }
    
    if ([overlay isKindOfClass:[MKPolygon class]]) {
        
        MKPolygonRenderer * aView = [[MKPolygonRenderer alloc] initWithPolygon:(MKPolygon*)overlay];
        aView.strokeColor = [THEME_MAIN_COLOR colorWithAlphaComponent:0.7];
        aView.lineWidth = 8;
        
        return (MKOverlayView*)aView;
    }
    
    return nil;
}

-(MKOverlayRenderer*)MGMapView:(MGMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    
    if ([overlay isKindOfClass:MKPolyline.class]) {
        
        MKPolylineRenderer* polylineRender = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        polylineRender.lineWidth = 3.0f;
        polylineRender.strokeColor = THEME_MAIN_COLOR;
        
        return polylineRender;
    }
    
    if ([overlay isKindOfClass:[MKPolygon class]]) {
        
        MKPolygonRenderer * polygonRender = [[MKPolygonRenderer alloc] initWithPolygon:(MKPolygon*)overlay];
        polygonRender.fillColor   = [THEME_MAIN_COLOR colorWithAlphaComponent:0.3];
        polygonRender.strokeColor = [THEME_MAIN_COLOR colorWithAlphaComponent:01.0];
        polygonRender.lineWidth = 3;
        
        return polygonRender;
    }
    
    return nil;
}

-(void) MGMapView:(MGMapView*)mapView geoCodePlaceMark:(CLPlacemark *)placemarks addressDictionary:(NSDictionary*)dic {
    
}

-(void)MGMapView:(MGMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
}

- (void)handleGesture:(UIPanGestureRecognizer*)gesture
{
    CGPoint location = [gesture locationInView:_drawView];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        if (_shapeLayer == nil) {
            _shapeLayer = [[CAShapeLayer alloc] init];
            _shapeLayer.fillColor = [[UIColor clearColor] CGColor];
            _shapeLayer.strokeColor = [THEME_MAIN_COLOR CGColor];
            _shapeLayer.lineWidth = 5.0;
            [_drawView.layer addSublayer:_shapeLayer];
        }
        else {
            _shapeLayer.fillColor = [[UIColor clearColor] CGColor];
            _shapeLayer.strokeColor = [THEME_MAIN_COLOR CGColor];
            _shapeLayer.lineWidth = 5.0;
            [_drawView.layer addSublayer:_shapeLayer];
        }
        
        _path = [[UIBezierPath alloc] init];
        [_path moveToPoint:location];
        
        CLLocationCoordinate2D coords;
        coords = [[self.mapViewMain mapView] convertPoint:location toCoordinateFromView:_drawView];
        NSString * LatLong = [NSString stringWithFormat:@"{%f,%f}", coords.latitude, coords.longitude];
        [_points addObject:LatLong];
        
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        
        [_path addLineToPoint:location];
        _shapeLayer.path = [_path CGPath];
        
        CLLocationCoordinate2D coords;
        coords = [[self.mapViewMain mapView] convertPoint:location toCoordinateFromView:_drawView];
        NSString * LatLong = [NSString stringWithFormat:@"{%f,%f}", coords.latitude, coords.longitude];
        [_points addObject:LatLong];
        
    }
    else if(gesture.state == UIGestureRecognizerStateEnded) {
        
        [_path addLineToPoint:location];
        [_path closePath];
        
        
        [_insideBoundsArray removeAllObjects];
        for(int i = 0; i < [_arrayData count]; i++) {
            
            Store* store = [_arrayData objectAtIndex:i];
            _coordinateRegion.center.latitude  = [store.lat floatValue];
            _coordinateRegion.center.longitude = [store.lon floatValue];
            
            CGPoint loc = [[self.mapViewMain mapView] convertCoordinate:_coordinateRegion.center toPointToView:_drawView];
            
            if ([_path containsPoint:loc])
                [_insideBoundsArray addObject:store];
        }
        
        
        CLLocationCoordinate2D pointsToUse[_points.count];
        
        for(int i = 0; i < _points.count; i++) {
            CGPoint p = CGPointFromString(_points[i]);
            pointsToUse[i] = CLLocationCoordinate2DMake(p.x,p.y);
        }
        
        _shapeLayer.path = nil;
        [_drawView removeFromSuperview];
        
        MKPolygon * poly = [MKPolygon polygonWithCoordinates:pointsToUse count:_points.count];
        [[mapViewMain mapView] addOverlay:poly];
        
        
        [self removeMapAnnotations];
        [self removeMapPolylines];
        
        if(_insideBoundsArray.count == 0) {
            
            //            [self removeMapPolygons];
            [_drawView removeFromSuperview];
        }
        else {
            for(int i = 0; i <[_insideBoundsArray count]; i++) {
                
                Store* store = [_insideBoundsArray objectAtIndex:i];
                CLLocationCoordinate2D coord;
                coord = CLLocationCoordinate2DMake([store.lat floatValue], [store.lon floatValue]);
                
                MGMapAnnotation* ann = [[MGMapAnnotation alloc] initWithCoordinate:coord
                                                                              name:store.store_name
                                                                       description:store.store_address];
                
                ann.object = store;
                [[mapViewMain mapView] addAnnotation:ann];
            }
            
            [_drawView removeFromSuperview];
        }
        
    }
}

-(void) removeMapPolygons {
    
    for (id<MKOverlay> overlayToRemove in [mapViewMain mapView].overlays) {
        
        if ([overlayToRemove isKindOfClass:[MKPolygon class]])
            [[mapViewMain mapView] removeOverlay:overlayToRemove];
    }
}

-(void) removeMapPolylines {
    
    for (id<MKOverlay> overlayToRemove in [mapViewMain mapView].overlays) {
        
        if ([overlayToRemove isKindOfClass:[MKPolyline class]])
            [[mapViewMain mapView] removeOverlay:overlayToRemove];
        
    }
}

-(void)removeMapAnnotations {
    
    for (id<MKAnnotation> ann in [mapViewMain mapView].annotations) {
        
        if (![ann isKindOfClass:[MKUserLocation class]])
            [[mapViewMain mapView] removeAnnotation:ann];
    }
}

- (IBAction)didClickButtonDraw:(id)sender {
    
    [self removeMapPolygons];
    [self removeMapPolylines];
    _arrayData = [NSMutableArray arrayWithArray:[CoreDataController getAllStores]];
    [self addMapAnnotations];
    
    if(_points == nil)
        _points = [[NSMutableArray alloc] init];
    
    [_points removeAllObjects];
    
    if(_panRecognizer == nil) {
        _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [_panRecognizer setMinimumNumberOfTouches:1];
        [_panRecognizer setMaximumNumberOfTouches:1];
    }
    
    if(_drawView == nil) {
        CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
        _drawView = [[UIView alloc] initWithFrame:applicationFrame];
        _drawView.backgroundColor = [UIColor clearColor];
        [_drawView addGestureRecognizer:_panRecognizer];
        _drawView.hidden = NO;
    }
    
    [self.view addSubview:_drawView];
    
}

-(IBAction)didClickButtonRefresh:(id)sender {
    
    [self removeMapPolygons];
    [self removeMapPolylines];
    [self removeMapAnnotations];
    
    _arrayData = [NSMutableArray arrayWithArray:[CoreDataController getAllStores]];
    
    [self addMapAnnotations];
    [mapViewMain zoomAndFitAnnotations];
}


#pragma mark - FIND USER LOCATION

-(void)findMyCurrentLocation {
    
    _myLocationManager = [[CLLocationManager alloc] init];
    _myLocationManager.delegate = self;
    
    if(IS_OS_8_OR_LATER) {
        [_myLocationManager requestWhenInUseAuthorization];
        [_myLocationManager requestAlwaysAuthorization];
    }
    
    [[mapViewMain mapView] setShowsUserLocation:YES];
    [_myLocationManager startUpdatingLocation];
    
    _isAllowDetectLocation = YES;
    
    if( [CLLocationManager locationServicesEnabled] ) {
        NSLog(@"Location Services Enabled....");
    }
    else {
        [MGUtilities showAlertTitle:LOCALIZED(@"LOCATION_SERVICE_ERROR")
                            message:LOCALIZED(@"LOCATION_SERVICE_NOT_ENABLED")];
    }
    
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    _myLocation = newLocation;
    
    if(_isAllowDetectLocation) {
        
        _isAllowDetectLocation = NO;
        [[mapViewMain mapView] setCenterCoordinate:newLocation.coordinate animated:YES];
        
        MKCoordinateRegion viewRegion =
        MKCoordinateRegionMakeWithDistance(newLocation.coordinate,
                                           0.3 * METES_PER_MILE,
                                           0.3 * METES_PER_MILE);
        
        MKCoordinateRegion adjustedRegion = [[mapViewMain mapView] regionThatFits:viewRegion];
        
        [[mapViewMain mapView] setRegion:adjustedRegion animated:YES];
    }
    
}


- (void)locationManager: (CLLocationManager *)manager didFailWithError: (NSError *)error {
    
}

-(void) showInfoView:(Store*)store {
    
    if(_infoSlidingView == nil) {
        
        _infoSlidingView = [[MGRawView alloc] initWithNibName:@"MapPopupView"];
        CGRect frame = _infoSlidingView.frame;
        frame.origin.y = [MGUtilities getViewHeight];
        _infoSlidingView.frame = frame;
        
        [self.view addSubview:_infoSlidingView];
        
        [_infoSlidingView.buttonNext addTarget:self
                                        action:@selector(didClickButtonNext:)
                              forControlEvents:UIControlEventTouchUpInside];
        
        [_infoSlidingView.buttonStarred addTarget:self
                                           action:@selector(didClickButtonStarred:)
                                 forControlEvents:UIControlEventTouchUpInside];
    }
    
    Photo* p = [CoreDataController getStorePhotoByStoreId:store.store_id];
    
    [_infoSlidingView.buttonStarred setTag:[store.store_id intValue]];
    
    [self updateStarred:store.store_id];
    
    
    if(p != nil)
        [self setImage:p.photo_url imageView:_infoSlidingView.imgViewPhoto];
    
    else
        [self setImage:nil imageView:_infoSlidingView.imgViewPhoto];
    
    [_infoSlidingView.labelTitle setText:store.store_name];
    [_infoSlidingView.labelSubtitle setText:store.store_address];
    

    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         CGRect frameUp = _infoSlidingView.frame;
                         frameUp.origin.y = [MGUtilities getViewHeight] - frameUp.size.height;
                         _infoSlidingView.frame = frameUp;
                     }
                     completion:^(BOOL finished){
                         [mapViewMain.mapView deselectAnnotation:_selectedAnnotation animated:YES];
                     }];
    
}

-(void)didClickButtonStarred:(id)sender {
    
    int storeId = (int)((UIButton*)sender).tag;
    NSString* strStoreId = [NSString stringWithFormat:@"%d", storeId];
    
    AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext* context = delegate.managedObjectContext;
    
    Favorite* fave = [CoreDataController getFavoriteByStoreId:strStoreId];
    
    if(fave == nil) {
        [CoreDataController insertFavorite:strStoreId];
    }
    else {
        
        [context deleteObject:fave];
        
        NSError *error;
        if ([context hasChanges] && ![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    
    [self updateStarred:strStoreId];
}

-(void)didClickButtonNext:(id)sender {
    
    DetailViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardDetail"];
    vc.store = _selectedAnnotation.object;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)updateStarred:(NSString*)storeId {
    
    Favorite* fave = [CoreDataController getFavoriteByStoreId:storeId];
    
    
    [_infoSlidingView.buttonStarred setBackgroundImage:[UIImage imageNamed:MAP_STARRED_NORMAL]
                                              forState:UIControlStateNormal];
    
    [_infoSlidingView.buttonStarred setBackgroundImage:[UIImage imageNamed:MAP_STARRED_NORMAL]
                                              forState:UIControlStateNormal];
    
    if(fave != nil) {
        [_infoSlidingView.buttonStarred setBackgroundImage:[UIImage imageNamed:MAP_STARRED_SELECTED]
                                                  forState:UIControlStateNormal];
        
        [_infoSlidingView.buttonStarred setBackgroundImage:[UIImage imageNamed:MAP_STARRED_SELECTED]
                                                  forState:UIControlStateNormal];
    }
}

-(void) hideInfoView {
    
    CGRect frameUp = _infoSlidingView.frame;
    if(frameUp.origin.y == [MGUtilities getViewHeight])
        return;
    
    [UIView animateWithDuration:0.2
                          delay:0.7
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         CGRect frameUp = _infoSlidingView.frame;
                         frameUp.origin.y = [MGUtilities getViewHeight];
                         _infoSlidingView.frame = frameUp;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.slidingViewController.topViewController.view addGestureRecognizer:self.slidingViewController.panGesture];

    [super viewWillAppear:animated];
    self.screenName = @"Map Screen";
}

-(void)setImage:(NSString*)imageUrl imageView:(UIImageView*)imgView {
    
    [imgView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:SLIDER_PLACEHOLDER]];
}


-(void)loadMapPinImage:(NSString*)imageUrl annotationView:(MKPinAnnotationView*)mKPinAnnotationView {
    
    NSURL* url = [NSURL URLWithString:imageUrl];
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:url];
    
    UIImage* imgPlaceholder = [UIImage imageNamed:MAP_PIN];
    mKPinAnnotationView.image = imgPlaceholder;
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [imgView setImageWithURLRequest:urlRequest
                   placeholderImage:imgPlaceholder
                            success:^(NSURLRequest* request, NSHTTPURLResponse* response, UIImage* image) {
                                
                                [MGUtilities fadeView:mKPinAnnotationView fadeOut:YES duration:0.5];
                                mKPinAnnotationView.image = image;
                                [MGUtilities fadeView:mKPinAnnotationView fadeOut:NO duration:0.5];
                                
                            } failure:^(NSURLRequest* request, NSHTTPURLResponse* response, NSError* error) {
                                
                                mKPinAnnotationView.image = imgPlaceholder;
                            }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
//    NSLog(@"%@",[[touch view]description]);
    
    if(![[touch view] isKindOfClass:[MKPinAnnotationView class]]) {
        [self hideInfoView];
    }
}

-(IBAction)didClickButtonRoute:(id)sender {
    
    if(![MGUtilities hasInternetConnection]) {
        
        [MGUtilities showAlertTitle:LOCALIZED(@"NETWORK_ERROR")
                            message:LOCALIZED(@"NETWORK_ERROR_DETAILS")];
        
        return;
    }
    
    if(_myLocation == nil) {
        [MGUtilities showAlertTitle:LOCALIZED(@"USER_LOCATION_ERROR")
                            message:LOCALIZED(@"USER_LOCATION_ERROR_DETAILS")];
        
        return;
    }
    
    if(_selectedAnnotation == nil) {
        [MGUtilities showAlertTitle:LOCALIZED(@"MAP_PIN_ERROR")
                            message:LOCALIZED(@"MAP_PIN_ERROR_DETAILS")];
        
        return;
    }
    
    for (id<MKOverlay> overlay in [mapViewMain.mapView overlays]) {
        if ([overlay isKindOfClass:[MKPolyline class]]) {
            [mapViewMain.mapView removeOverlay:overlay];
        }
    }
    
    [self beginParsingRoute];

}

-(IBAction)didClickButtonFindLocation:(id)sender {
    
    _isAllowDetectLocation = YES;
}

-(void)beginParsingRoute {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = LOCALIZED(@"CREATING_ROUTES");
    
    [self.view addSubview:hud];
	
    NSMutableArray* routeArray = [NSMutableArray new];
    __strong typeof(NSMutableArray*) strongRouteArray = routeArray;
    
    [self.view setUserInteractionEnabled:NO];
	[hud showAnimated:YES whileExecutingBlock:^{
        
		[self performParseRoute:strongRouteArray];
        
	} completionBlock:^{
        
		[hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        [self displayOverlay:strongRouteArray];
        
	}];
    
}

-(void)performParseRoute:(NSMutableArray*)routeArray {
    
    NSArray* array = [MGMapRoute getRouteFrom:_myLocation.coordinate to:_selectedAnnotation.coordinate];
    
    for(id entry in array) {
        [routeArray addObject:entry];
    }
}

-(void)displayOverlay:(NSMutableArray*)routeArray {
    
    NSInteger routeCount = routeArray.count;
    CLLocationCoordinate2D coordsArray[routeCount];
    
    if(routeCount > 0) {
        for(int i = 0; i < routeCount; i++) {
            
            CLLocation* location = [routeArray objectAtIndex:i];
            coordsArray[i] = location.coordinate;
        }
        
        MKPolyline* routePolyLine = [MKPolyline polylineWithCoordinates:coordsArray count:routeCount];
        [mapViewMain.mapView addOverlay:routePolyLine];
    }
}

-(void)getDistance {
    
    CLLocationCoordinate2D coord = _selectedAnnotation.coordinate;
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coord.latitude
                                                      longitude:coord.longitude];
    
    double distance = [_myLocation distanceFromLocation:location] / 1000;
    
    double miles = distance * KM_TO_MILES;
    labelDistance.text = [NSString stringWithFormat:@"%.02f %@", miles, LOCALIZED(@"MAP_DISTANCE_UNIT")];
}

-(IBAction)didClickButtonSearch:(id)sender {
    
    [self hideInfoView];
}

-(void)searchResults:(NSMutableArray *)array {
    
    [self removeMapPolygons];
    [self removeMapPolylines];
    [self removeMapAnnotations];
    
    [_arrayData removeAllObjects];
    
    _arrayData = array;
    [self addMapAnnotations];
    [mapViewMain zoomAndFitAnnotations];
}

-(IBAction)didClickButtonNearby:(id)sender {
    
    if(_myLocation != nil) {
        
        [self removeMapPolygons];
        [self removeMapPolylines];
        [self removeMapAnnotations];
        
        NSMutableArray* array = [NSMutableArray arrayWithArray:[CoreDataController getAllStores]];
        [_arrayData removeAllObjects];
        
        for(Store* store in array) {
            
            CLLocation *location;
            location = [[CLLocation alloc] initWithLatitude:[store.lat floatValue]
                                                  longitude:[store.lon floatValue]];
            
            double distance = [location distanceFromLocation:_myLocation];
            
            if(distance <= MAX_RADIUS_NEARBY_IN_METERS) {
                [_arrayData addObject:store];
            }
        }
        
        [self addMapAnnotations];
        [mapViewMain zoomAndFitAnnotations];
    }
    else {
        [MGUtilities showAlertTitle:LOCALIZED(@"LOCATION_SERVICE_ERROR")
                            message:LOCALIZED(@"LOCATION_SERVICE_NOT_ENABLED")];
    }
}


#pragma mark ########################################################################
#pragma mark - Navigation Segue
#pragma mark ########################################################################

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
