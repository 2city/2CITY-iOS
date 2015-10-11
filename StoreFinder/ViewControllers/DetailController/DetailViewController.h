//
//  DetailViewController.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : GAITrackedViewController

@property (nonatomic, retain) IBOutlet MGListView* tableViewMain;
@property (nonatomic, retain) Store* store;

@end
