

#import "NSStringExtras.h"

@implementation NSString (ContainsCategory)

- (BOOL) containsString: (NSString*) substring {
    
    NSRange range = [self rangeOfString:substring options:NSCaseInsensitiveSearch];
    BOOL found = (range.location != NSNotFound);
    return found;
}

@end
