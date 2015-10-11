//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "MGMapRoute.h"

#define GOOGLE_MAPS_URL @"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=false"

@implementation MGMapRoute

+(NSArray*)getRouteFrom:(CLLocationCoordinate2D)coordFrom to:(CLLocationCoordinate2D)coordTo {
    
    NSString* strUrl = [NSString stringWithFormat:GOOGLE_MAPS_URL, coordFrom.latitude, coordFrom.longitude, coordTo.latitude, coordTo.longitude];
    
    NSString* encodeStrUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL* url = [NSURL URLWithString:encodeStrUrl];
    NSData* data = [NSData dataWithContentsOfURL:url];
    
    if(data == nil)
        return nil;
    
    NSError * error;
    NSMutableDictionary * json = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
    
    NSString* jsonStr = [self parseResponse:json];
    
    if(jsonStr == nil)
        return nil;
    
    return [self decodePolyLine:jsonStr];
}

+(NSString *)parseResponse:(NSDictionary *)response {
    
    NSArray *routes = [response objectForKey:@"routes"];
    NSDictionary *route = [routes lastObject];
    
    if (route) {
        NSString *overviewPolyline = [[route objectForKey:@"overview_polyline"] objectForKey:@"points"];
        return overviewPolyline;
    }
    
    return nil;
}

+(NSMutableArray *)decodePolyLine:(NSString *)encodedStr {
    
    NSMutableString *encoded = [[NSMutableString alloc] initWithCapacity:[encodedStr length]];
    [encoded appendString:encodedStr];
    
    //[encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\" options:NSLiteralSearch range:NSMakeRange(0, [encoded length])];
    
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger lat=0;
    NSInteger lng=0;
    
    while(index < len) {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        
        NSInteger dlat = ((result & 1) ? ~(result >> 1)
                          : (result >> 1));
        lat += dlat;
        shift = 0;
        result = 0;
        
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        
        NSInteger dlng = ((result & 1) ? ~(result >> 1)
                          : (result >> 1));
        lng += dlng;
        
        NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5];
        NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
        CLLocation *location = [[CLLocation alloc] initWithLatitude: [latitude floatValue] longitude:[longitude floatValue]];
        
        [array addObject:location];
    }
    return array;
}




@end
