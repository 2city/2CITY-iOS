//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "MGMapView.h"


@implementation MGMapView

@synthesize mapView;
@synthesize delegate = _delegate;
@synthesize currentAnnotation = _currentAnnotation;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray* nibContents = [[NSBundle mainBundle] loadNibNamed:@"MGMapView"
                                                             owner:self
                                                           options:nil];
        
        self = [nibContents objectAtIndex:0];
        [self baseInit];
        
        if(frame.size.height > 0 && frame.size.width > 0) {
            self.frame = frame;
        }
    }
    
    return self;
}

-(void) baseInit {
    mapView.delegate = self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    for (UIView * view in [self subviews]) {
        
        if (view.userInteractionEnabled &&
            [view pointInside:[self convertPoint:point toView:view] withEvent:event]) {
            
            return YES;
        }
    }
    return NO;
}

-(void) setMapData:(NSMutableArray*)mutableArray {
    _mapAnnotations = mutableArray;
    [self removeAllAnnotations];
    [mapView addAnnotations:_mapAnnotations];
}


-(void)setRegion:(MKCoordinateRegion)region animated:(BOOL)animated {
    [mapView setRegion:region animated:animated];
}

-(MKCoordinateRegion)regionThatFits:(MKCoordinateRegion)region {
    return [mapView regionThatFits:region];
}

-(void) setSelectedAnnotation:(CLLocationCoordinate2D)coordinate {

    for(MGMapAnnotation* annotation in _mapAnnotations) {
        
        if (annotation.coordinate.latitude == coordinate.latitude &&
            annotation.coordinate.longitude == coordinate.longitude) {
            
            [mapView setCenterCoordinate:annotation.coordinate animated:YES];
            [mapView selectAnnotation:annotation animated:YES];
            
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(annotation.coordinate,
                                                                               0.5*METES_PER_MILE ,
                                                                               0.5*METES_PER_MILE);
            
            MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
            [mapView setRegion:adjustedRegion animated:YES];
            break;
        }
    }
}


#pragma mark - Map View

-(MKAnnotationView*) mapView:(MKMapView *)_mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if([annotation isKindOfClass:[MGMapAnnotation class]]) {
        
        static NSString* identifier = @"MapAnnotation";
        MKPinAnnotationView *annotationView = (MKPinAnnotationView*) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if(annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.pinColor = MKPinAnnotationColorRed;
        annotationView.animatesDrop = YES;
        
        [self.delegate MGMapView:self didCreateMKPinAnnotationView:annotationView viewForAnnotation:annotation];
        
        return annotationView;
    }
    
    return nil;
}

-(void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    MGMapAnnotation* mapAnnotation = view.annotation;
    
    [self.delegate MGMapView:self didSelectMapAnnotation:mapAnnotation];
    _currentAnnotation = mapAnnotation;
}

-(void)didTapAccesoryButton:(UITapGestureRecognizer *)gesture {
    [self.delegate MGMapView:self didAccessoryTapped:_currentAnnotation];
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay {
    return [self.delegate MGMapView:self viewForOverlay:overlay];
}

-(MKOverlayRenderer*)mapView:(MKMapView*)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    return [self.delegate MGMapView:self rendererForOverlay:overlay];
}

-(void)removeAllAnnotations {
    NSMutableArray *locs = [[NSMutableArray alloc] init];
    
    for (id <MKAnnotation> annot in [mapView annotations]) {
        if ( ![annot isKindOfClass:[MKUserLocation class]] ) {
            [locs addObject:annot];
        }
    }
    [mapView removeAnnotations:locs];
}

-(void)showsUserLocation:(BOOL)willShow {
    [mapView setShowsUserLocation:willShow];
}

-(void)zoomAndFitAnnotations {
    [mapView showAnnotations:_mapAnnotations animated:YES];
}

- (void)moveCenterByOffset:(CGPoint)offset from:(CLLocationCoordinate2D)coordinate {
    
    CGPoint point = [self.mapView convertCoordinate:coordinate
                                      toPointToView:self.mapView];
    
    point.x += offset.x;
    point.y += offset.y;
    
    CLLocationCoordinate2D center = [self.mapView convertPoint:point
                                          toCoordinateFromView:self.mapView];
    
    [self.mapView setCenterCoordinate:center animated:YES];
}

-(void)getAddressFromLatLon:(CLLocation *)bestLocation {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:bestLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                                   
                       CLPlacemark* placemark = [placemarks objectAtIndex:0];
//                       NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
//                       NSLog(@"locality %@",placemark.locality);
//                       NSLog(@"postalCode %@",placemark.postalCode);
                       
                       NSDictionary* dic = placemark.addressDictionary;
                       [self.delegate MGMapView:self geoCodePlaceMark:placemark addressDictionary:dic];
     }];
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    if ([self.delegate respondsToSelector:@selector(MGMapView:didUpdateUserLocation:)]) {
        [self.delegate MGMapView:self didUpdateUserLocation:userLocation];
    }
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    
    if ([self.delegate respondsToSelector:@selector(MGMapView:annotationView:didChangeDragState:fromOldState:)]) {
        [self.delegate MGMapView:self annotationView:view didChangeDragState:newState fromOldState:oldState];
    }
}


@end