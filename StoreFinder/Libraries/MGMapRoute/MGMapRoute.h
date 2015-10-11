//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGMapRoute : NSObject

+(NSArray*)getRouteFrom:(CLLocationCoordinate2D)coordFrom to:(CLLocationCoordinate2D)coordTo;

@end
