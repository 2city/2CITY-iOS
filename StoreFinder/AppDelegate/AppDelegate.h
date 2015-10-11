//
//  AppDelegate.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"
#import "SideViewController.h"
#import "ReviewViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) ContentViewController* contentViewController;
@property (nonatomic, strong) SideViewController* sideViewController;

+(AppDelegate*) instance;

@property (nonatomic, strong) CLLocation* myLocation;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(void) saveContext;
@property (strong, nonatomic) NSString *buyURLGlobal;

@property (strong, nonatomic) FBSession *session;

@property (nonatomic, strong) METransitions *transitions;

-(void)setTransitionIndex:(int)index;
-(int)getTransitionIndex;

@end
