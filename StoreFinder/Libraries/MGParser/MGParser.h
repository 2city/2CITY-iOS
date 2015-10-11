//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"

@interface MGParser : NSObject

+(NSDictionary*) getJSONAtURL:(NSString*)urlStr;

+(NSArray*) getJSONArayAtURL:(NSString*)urlStr;

@end
