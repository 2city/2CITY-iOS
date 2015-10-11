//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGMapAnnotation.h"
#import "MGDrawView.h"

#define METES_PER_MILE 1609.344

@class MGMapView;

@protocol MGMapViewDelegate <NSObject>

-(void) MGMapView:(MGMapView*)mapView didSelectMapAnnotation:(MGMapAnnotation*)mapAnnotation;
-(void) MGMapView:(MGMapView*)mapView didAccessoryTapped:(MGMapAnnotation*)mapAnnotation;
-(void) MGMapView:(MGMapView*)mapView didCreateMKPinAnnotationView:(MKPinAnnotationView*)mKPinAnnotationView viewForAnnotation:(id<MKAnnotation>)annotation;



@optional
-(MKOverlayView*)MGMapView:(MGMapView *)mapView viewForOverlay:(id)overlay;
-(MKOverlayRenderer*)MGMapView:(MGMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay;
-(void) MGMapView:(MGMapView*)mapView geoCodePlaceMark:(CLPlacemark *)placemarks addressDictionary:(NSDictionary*)dic;
-(void)MGMapView:(MGMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation;

- (void)MGMapView:(MGMapView *)mapView
 annotationView:(MKAnnotationView *)annotationView
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState;

@end

@interface MGMapView : UIView <MKMapViewDelegate> {
    
    NSMutableArray* _mapAnnotations;
    id <MGMapViewDelegate> _delegate;
    MGMapAnnotation* _currentAnnotation;
}

@property (nonatomic, retain) IBOutlet MKMapView* mapView;
@property (nonatomic, retain) id <MGMapViewDelegate> delegate;
@property (nonatomic, retain) MGMapAnnotation* currentAnnotation;

-(void) baseInit;
-(void) setMapData:(NSMutableArray*)mutableArray;
-(void) setSelectedAnnotation:(CLLocationCoordinate2D)coordinate;
-(void)removeAllAnnotations;
-(void)showsUserLocation:(BOOL)willShow;
-(void)zoomAndFitAnnotations;
-(void)setRegion:(MKCoordinateRegion)region animated:(BOOL)animated;
-(MKCoordinateRegion)regionThatFits:(MKCoordinateRegion)region;
-(void)moveCenterByOffset:(CGPoint)offset from:(CLLocationCoordinate2D)coordinate;
-(void)getAddressFromLatLon:(CLLocation *)bestLocation;

@end
