//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "MGParser.h"

@implementation MGParser


+(NSDictionary*) getJSONAtURL:(NSString*)urlStr {
    
    NSError *error = nil;
    NSError *errorJSON = nil;
    
    NSURL* url = [NSURL URLWithString:urlStr];
    NSData* data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedAlways | NSDataReadingUncached error:&error];
    NSDictionary* resultsDictionary = [data objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&errorJSON];
    
    if(error != nil)
        NSLog(@"getJSONAtURL ERROR** = %@", error.localizedDescription);
    
    if(errorJSON != nil)
        NSLog(@"getJSONAtURL ERROR** = %@", errorJSON.localizedDescription);
    
    return resultsDictionary;
}

+(NSArray*) getJSONArayAtURL:(NSString*)urlStr {
    NSURL* url = [NSURL URLWithString:urlStr];
    NSData* data = [NSData dataWithContentsOfURL:url];
    NSArray* resultsDictionary = [data objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode];
    
    return resultsDictionary;
}

@end
