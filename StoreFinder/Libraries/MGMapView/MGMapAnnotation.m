//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "MGMapAnnotation.h"

@implementation MGMapAnnotation

@synthesize name = _name;
@synthesize description = _description;
@synthesize info = _info;
@synthesize coordinate = _coordinate;
@synthesize object;

-(id) initWithCoordinate:(CLLocationCoordinate2D) coordinate name:(NSString*)name description:(NSString*)description {
    self = [super init];
    if(self) {
        _name = name;
        _description = [description copy];
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return _name;
}

- (NSString *)subtitle {
    
    if ([_description isKindOfClass:[NSNull class]])
        return @"";
    else
        return _description;
}

-(NSString*) info {
    if ([_info isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return _info;
}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
}

@end
