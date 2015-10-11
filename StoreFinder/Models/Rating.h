//
//  Rating.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Rating : NSManagedObject

@property (nonatomic, retain) NSString * updated_at;
@property (nonatomic, retain) NSString * created_at;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSString * rating;
@property (nonatomic, retain) NSString * rating_id;
@property (nonatomic, retain) NSString * store_id;

@end
