//
//  StoreViewController.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreViewController : GAITrackedViewController

@property (nonatomic, retain) IBOutlet MGListView* listViewMain;
@property (nonatomic, retain) IBOutlet StoreCategory* storeCategory;

@end
