//
//  AppDelegate.m
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "ECSlidingViewController.h"
#import <Parse/Parse.h>

@interface AppDelegate () <FHSTwitterEngineAccessTokenDelegate>

@property (nonatomic, strong) ECSlidingViewController *slidingViewController;

@end

@implementation AppDelegate

@synthesize sideViewController;
@synthesize contentViewController;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize session;
@synthesize myLocation;
@synthesize transitions;
@synthesize buyURLGlobal;
+(AppDelegate *)instance {
    
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:ANALYTICSID];
id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    // Enable IDFA collection.
    tracker.allowIDFACollection = YES;
    
    [Parse setApplicationId:@"TWbCpafyft1l00iKwOwPSoMHamNAsa4AC6qoV34n" clientKey:@"J7PKDrwRLpRbzS7sJQvQA9CsSE5uWG5Xc73PgLm8"];
//    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
//                                                    UIUserNotificationTypeBadge |
//                                                    UIUserNotificationTypeSound);
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
//                                                                             categories:nil];
//    [application registerUserNotificationSettings:settings];
//    [application registerForRemoteNotifications];

    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [application registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
        [application registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
    
    
    // Override point for customization after application launch.
    
    // Override point for customization after application launch.
    [MGUIAppearance enhanceNavBarAppearance:NAV_BAR_BG];
    
    [MGUIAppearance enhanceBarButtonAppearance:WHITE_TINT_COLOR];
    
    [MGUIAppearance enhanceToolbarAppearance:NAV_BAR_BG];
    
    if (DOES_SUPPORT_IOS7) {
        [application setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    UINavigationController* navController = [storyboard instantiateViewControllerWithIdentifier:@"storyboardNavigation"];
    
    sideViewController = [storyboard instantiateViewControllerWithIdentifier:@"storyboardSideView"];
    
    self.slidingViewController = [ECSlidingViewController slidingWithTopViewController:navController];
    self.slidingViewController.underLeftViewController  = sideViewController;
    self.slidingViewController.underRightViewController = nil;
    
    self.slidingViewController.anchorRightPeekAmount  = ANCHOR_LEFT_PEEK; //44.0
    self.slidingViewController.anchorLeftRevealAmount = ANCHOR_RIGHT_PEEK; //276.0
    
    self.window.rootViewController = self.slidingViewController;
    [self.window makeKeyAndVisible];
    
    [[FHSTwitterEngine sharedEngine] permanentlySetConsumerKey:TWITTER_CONSUMER_KEY
                                                     andSecret:TWITTER_CONSUMER_SECRET];
    
    [[FHSTwitterEngine sharedEngine]setDelegate:self];
    
    [MGFileManager deleteAllFilesAtDocumentsFolderWithExt:@"png"];
    
    [self setTransitionIndex:[self getTransitionIndex]];
    
    UserSession* user = [UserAccessSession getUserSession];
    
    if( user == nil ) {

    
    UIStoryboard *storyboard1 = [UIStoryboard storyboardWithName:@"User_iPhone" bundle:nil];
    UIViewController *vc = [storyboard1 instantiateViewControllerWithIdentifier:@"storyboardLogin"];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    AppDelegate* delegate = [AppDelegate instance];
    [[delegate.window rootViewController] presentViewController:vc animated:YES completion:nil];
    }
    
    buyURLGlobal = [self menuTicketURL];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBAppEvents activateApp];
    
    [FBAppCall handleDidBecomeActiveWithSession:self.session];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [self.session close];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[ @"global" ];
    [currentInstallation saveInBackground];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    // You can add your app-specific url handling code here if needed
    
    return wasHandled;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"db_data.sqlite"];
    
    // important part starts here
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                             nil];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        // and ends here
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // Do something
    }
    return _persistentStoreCoordinator;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
//- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
//{
//    if (_persistentStoreCoordinator != nil) {
//        return _persistentStoreCoordinator;
//    }
//    
//    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"db_data.sqlite"];
//    
//    NSError *error = nil;
//    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
//    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
//        /*
//         Replace this implementation with code to handle the error appropriately.
//         
//         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//         
//         Typical reasons for an error here include:
//         * The persistent store is not accessible;
//         * The schema for the persistent store is incompatible with current managed object model.
//         Check the error message to determine what the actual problem was.
//         
//         
//         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
//         
//         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
//         * Simply deleting the existing store:
//         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
//         
//         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
//         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
//         
//         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
//         
//         */
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
//    
//    return _persistentStoreCoordinator;
//}

-(NSString*)menuTicketURL
{
//
    NSString *strUrl=@"";
    NSString *strURL = [NSString stringWithFormat:@"http://2city.merkabahnk.net/rest/ticket.php"];
    NSData *respData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[strURL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    NSError* error;
    id json = [NSJSONSerialization
                     JSONObjectWithData:respData //1
                     
                     options:kNilOptions
                     error:&error];
    if(!error)
    {
        strURL = [[[json objectForKey:@"ticket"] objectAtIndex:0] objectForKey:@"ticket_url"];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Error in loading Buy Ticket!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    return strURL;

    
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - TWITTER

- (NSString *)loadAccessToken {
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"TWITTER_ACCESS_TOKEN"];
}

- (void)storeAccessToken:(NSString *)accessToken {
    [[NSUserDefaults standardUserDefaults]setObject:accessToken forKey:@"TWITTER_ACCESS_TOKEN"];
}

- (METransitions *)transitions {
    if (transitions) return transitions;
    
    transitions = [[METransitions alloc] init];
    
    return transitions;
}


-(int)getTransitionIndex {
    return [[[NSUserDefaults standardUserDefaults]objectForKey:@"TRANSITION_INDEX"] intValue];
}

-(void)setTransitionIndex:(int)index {
    
    NSDictionary *transitionData = self.transitions.all[index];
    id<ECSlidingViewControllerDelegate> transition = transitionData[@"transition"];
    
    if (transition == (id)[NSNull null]) {
        self.slidingViewController.delegate = nil;
    } else {
        self.slidingViewController.delegate = transition;
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d", index] forKey:@"TRANSITION_INDEX"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
