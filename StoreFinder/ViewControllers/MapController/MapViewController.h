//
//  MapViewController.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : GAITrackedViewController <MGMapViewDelegate, CLLocationManagerDelegate> {
    
    UIPanGestureRecognizer* _panRecognizer;
    UIView* _drawView;
    CAShapeLayer* _shapeLayer;
    UIBezierPath* _path;
    NSMutableArray* _points;
    NSMutableArray* _insideBoundsArray;
    MKCoordinateRegion _coordinateRegion;
    NSMutableArray* _arrayData;
    CLLocationManager* _myLocationManager;
    CLLocation* _myLocation;
    MGRawView* _infoSlidingView;
    BOOL _isAllowDetectLocation;
    MGMapAnnotation* _selectedAnnotation;
    
}

@property (nonatomic, retain) IBOutlet MGMapView* mapViewMain;
@property (nonatomic, retain) IBOutlet UIButton* buttonDraw;
@property (nonatomic, retain) IBOutlet UILabel* labelDistance;

-(IBAction)didClickButtonDraw:(id)sender;
-(IBAction)didClickButtonRefresh:(id)sender;
-(IBAction)didClickButtonRoute:(id)sender;
-(IBAction)didClickButtonFindLocation:(id)sender;
-(IBAction)didClickButtonSearch:(id)sender;
-(IBAction)didClickButtonNearby:(id)sender;

@end
