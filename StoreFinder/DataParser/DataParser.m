//
//  DataParser.m
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC All rights reserved.
//

#import "DataParser.h"
#import "AppDelegate.h"

@implementation DataParser

+(NSMutableArray*)parseStoreFromURLFormatJSON:(NSString*)urlStr {
    
    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext* context = delegate.managedObjectContext;
    
    NSDictionary* dict = [self getJSONAtURL:urlStr];
    NSMutableArray* array = [NSMutableArray new];
    if(dict != nil) {
        
        NSDictionary* dictEntry = [dict objectForKey:@"categories"];
        for(NSDictionary* dictCat in dictEntry) {
            
            NSString* className = NSStringFromClass([StoreCategory class]);
            NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:context];
            StoreCategory* cat = (StoreCategory*)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            
            [cat safeSetValuesForKeysWithDictionary:dictCat];
            
            [array addObject:cat];
        }
        
        dictEntry = [dict objectForKey:@"photos"];
        for(NSDictionary* dictCat in dictEntry) {
            
            NSString* className = NSStringFromClass([Photo class]);
            NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:context];
            Photo* photo = (Photo*)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            
            [photo safeSetValuesForKeysWithDictionary:dictCat];
            
            [array addObject:photo];
        }
        
        dictEntry = [dict objectForKey:@"stores"];
        for(NSDictionary* dictCat in dictEntry) {
            
            NSString* className = NSStringFromClass([Store class]);
            NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:context];
            Store* store = (Store*)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            
            [store safeSetValuesForKeysWithDictionary:dictCat];
            
            [array addObject:store];
        }
    }
    
    return array;
}

+(NSMutableArray*)parseReviewsFromURLFormatJSON:(NSString*)urlStr
                                      loginHash:(NSString*)loginHash
                                        storeId:(NSString*)storeId {
    
    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext* context = delegate.managedObjectContext;
    
    NSDictionary* dict = [self getJSONAtURL:urlStr];
    NSMutableArray* array = [NSMutableArray new];
    if(dict != nil) {
        
        NSDictionary* dictEntry = [dict objectForKey:@"reviews"];
        for(NSDictionary* dictCat in dictEntry) {
            
            NSString* className = NSStringFromClass([Review class]);
            NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:context];
            Review* rev = (Review*)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            
            [rev safeSetValuesForKeysWithDictionary:dictCat];
            
            [array addObject:rev];
        }
    }
    
    return array;
}


+(NSMutableArray*)parseNewsFromURLFormatJSON:(NSString*)urlStr {
    
    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext* context = delegate.managedObjectContext;
    
    NSDictionary* dict = [self getJSONAtURL:urlStr];
    NSMutableArray* array = [NSMutableArray new];
    if(dict != nil) {
        
        NSDictionary* dictEntry = [dict objectForKey:@"news"];
        for(NSDictionary* dictCat in dictEntry) {
            
            NSString* className = NSStringFromClass([News class]);
            NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:context];
            News* news = (News*)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            
            [news safeSetValuesForKeysWithDictionary:dictCat];
            
            [array addObject:news];
        }
    }
    
    return array;
}

+(void)fetchServerData {
    
    if(WILL_DOWNLOAD_DATA && [MGUtilities hasInternetConnection]) {
        
        AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSManagedObjectContext* context = delegate.managedObjectContext;
        
        @try {
            NSMutableArray* arrayData;
            [CoreDataController deleteAllObjects:@"Store"];
            [CoreDataController deleteAllObjects:@"StoreCategory"];
            [CoreDataController deleteAllObjects:@"Photo"];
            [CoreDataController deleteAllObjects:@"Review"];
            [CoreDataController deleteAllObjects:@"Rating"];
            [CoreDataController deleteAllObjects:@"News"];
            
            arrayData = [DataParser parseStoreFromURLFormatJSON:DATA_JSON_URL];
            if(arrayData != nil && arrayData.count > 0) {
                
                NSError *error;
                if ([context hasChanges] && ![context save:&error]) {
                    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                }
            }
            
            NSArray* arrayNews = [DataParser parseNewsFromURLFormatJSON:DATA_NEWS_URL];
            if(arrayNews != nil && arrayNews.count > 0) {
                
                NSError *error;
                if ([context hasChanges] && ![context save:&error]) {
                    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"exception = %@", exception.debugDescription);
        }
    }
}

+(void)fetchNewsData {
    
    if(WILL_DOWNLOAD_DATA && [MGUtilities hasInternetConnection]) {
        
        AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSManagedObjectContext* context = delegate.managedObjectContext;
        
        @try {
            [CoreDataController deleteAllObjects:@"News"];
            
            NSArray* arrayNews = [DataParser parseNewsFromURLFormatJSON:DATA_NEWS_URL];
            if(arrayNews != nil && arrayNews.count > 0) {
                
                
                NSError *error;
                if ([context hasChanges] && ![context save:&error]) {
                    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"exception = %@", exception.debugDescription);
        }
    }
}

+(void)fetchCategoryData {
    
    if(WILL_DOWNLOAD_DATA && [MGUtilities hasInternetConnection]) {
        
        AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSManagedObjectContext* context = delegate.managedObjectContext;
        
        @try {
            
            NSDictionary* dict = [self getJSONAtURL:CATEGORY_JSON_URL];
            if(dict != nil) {
                
                [CoreDataController deleteAllObjects:@"StoreCategory"];
                
                NSMutableArray* array = [NSMutableArray new];
                NSDictionary* dictEntry = [dict objectForKey:@"categories"];
                for(NSDictionary* dictCat in dictEntry) {
                    
                    NSString* className = NSStringFromClass([StoreCategory class]);
                    NSEntityDescription *entity = [NSEntityDescription entityForName:className
                                                              inManagedObjectContext:context];
                    
                    StoreCategory* cat = (StoreCategory*)[[NSManagedObject alloc] initWithEntity:entity
                                                                  insertIntoManagedObjectContext:context];
                    
                    [cat safeSetValuesForKeysWithDictionary:dictCat];
                    
                    [array addObject:cat];
                }
                NSError *error;
                if ([context hasChanges] && ![context save:&error]) {
                    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"exception = %@", exception.debugDescription);
        }
        
    }
}


@end
