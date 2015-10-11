//
//  ContentViewController.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ContentViewController : GAITrackedViewController
{
//    CLLocationManager *locManager;
}

@property (nonatomic, retain) IBOutlet MGListView* listViewNews;

@end
