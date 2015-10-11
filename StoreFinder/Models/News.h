//
//  News.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface News : NSManagedObject

@property (nonatomic, retain) NSString * news_url;
@property (nonatomic, retain) NSString * news_title;
@property (nonatomic, retain) NSString * news_content;
@property (nonatomic, retain) NSString * news_id;
@property (nonatomic, retain) NSString * updated_at;
@property (nonatomic, retain) NSString * created_at;
@property (nonatomic, retain) NSString * photo_url;

@end
