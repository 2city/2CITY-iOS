//
//  CoreDataController.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataController : NSObject

+(void)deleteAllObjects:(NSString *)entityDescription;
+(NSArray*)getFeaturedStores;
+(Photo*)getStorePhotoByStoreId:(NSString*)storeId;
+(NSArray*)getStorePhotosByStoreId:(NSString*)storeId;
+(NSArray*)getNews;
+(NSArray*)getNewsByNewsId:(NSString*)newsId;
+(NSArray*)getCategories;
+(NSArray*) getAllStores;
+(Favorite*) getFavoriteByStoreId:(NSString*)storeId;
+(void)insertFavorite:(NSString*)storeId;
+(NSArray*) getStoreByCategoryId:(NSString*)categoryId;
+(Store*) getStoreByStoreId:(NSString*)storeId;
+(StoreCategory*) getCategoryByCategory:(NSString*)category;
+(NSArray*) getCategoryNames;
+(NSArray*) getFavoriteStores;
+(StoreCategory*) getCategoryByCategoryId:(NSString*)categoryId;

@end
