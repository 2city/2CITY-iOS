

#import <Foundation/Foundation.h>
#import "UserSession.h"

@interface UserAccessSession : NSObject

+(void)storeUserSession:(UserSession*)session;
+(UserSession*)getUserSession;

+(void) clearAllSession;
+(BOOL)isLoggedIn;

+(BOOL)isLoggedFromSocial;

@end
