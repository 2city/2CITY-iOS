//
//  Store.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Store : NSManagedObject

@property (nonatomic, retain) NSString * store_id;
@property (nonatomic, retain) NSString * icon_id;
@property (nonatomic, retain) NSString * category_id;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * phone_no;
@property (nonatomic, retain) NSString * sms_no;
@property (nonatomic, retain) NSString * lon;
@property (nonatomic, retain) NSString * lat;
@property (nonatomic, retain) NSString * store_desc;
@property (nonatomic, retain) NSString * store_address;
@property (nonatomic, retain) NSString * store_name;
@property (nonatomic, retain) NSString * rating_count;
@property (nonatomic, retain) NSString * featured;
@property (nonatomic, retain) NSString * updated_at;
@property (nonatomic, retain) NSString * created_at;
@property (nonatomic, retain) NSString * rating_total;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * distance;
@property (nonatomic, retain) NSString * buy_ticket;
@property (nonatomic, retain) NSString * date_for_ordering;
@property (nonatomic, retain) NSDate * sortDate;
@end
