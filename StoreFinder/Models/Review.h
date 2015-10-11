//
//  Review.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Review : NSManagedObject

@property (nonatomic, retain) NSString * updated_at;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSString * store_id;
@property (nonatomic, retain) NSString * review;
@property (nonatomic, retain) NSString * review_id;
@property (nonatomic, retain) NSString * created_at;

@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * last_name;

@end
