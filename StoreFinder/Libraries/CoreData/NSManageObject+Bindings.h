//
//  NSManageObject+Bindings.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (SafeSetValuesKeysWithDictionary)

-(void)safeSetValuesForKeysWithDictionary:(NSDictionary*)keyedValues;
-(void)safeSetValuesForKeysWithDictionary:(NSDictionary*)keyedValues dateFormatter:(NSDateFormatter*)dateFormatter;

@end
