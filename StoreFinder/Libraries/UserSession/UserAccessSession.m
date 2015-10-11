

#import "UserAccessSession.h"

#define FACEBOOK_ID     @"sekln0LDNKANWdskf"
#define TWITTER_ID      @"OIanlknfalk3lnk2a"
#define USER_ID         @"23vponrnkl32brlkn"
#define LOGIN_HASH      @"340bji4riwbnlrvas"
#define FULL_NAME       @"5b03i3ipbp3454LLK"
#define USER_NAME       @"65po7jboyioen2Kid"
#define EMAIL           @"54690j945safnKNKI"
#define THUMB_URL       @"sadnka008adklasdk"
#define PHOTO_URL       @"8dsfu99s121kn3jkk"

#define IS_LOGIN        @"3b90jKADN3902q3v2"


@implementation UserAccessSession

+(BOOL)isLoggedIn {
    
    BOOL isLoggedIn = [[[NSUserDefaults standardUserDefaults]objectForKey:IS_LOGIN] isEqual: @"1"] ? YES : NO;
    
    return isLoggedIn;
}

+(void)storeUserSession:(UserSession*)session {
    
    [[NSUserDefaults standardUserDefaults]setObject:session.facebookId forKey:FACEBOOK_ID];
    [[NSUserDefaults standardUserDefaults]setObject:session.twitterId forKey:TWITTER_ID];
    [[NSUserDefaults standardUserDefaults]setObject:session.userId forKey:USER_ID];
    [[NSUserDefaults standardUserDefaults]setObject:session.loginHash forKey:LOGIN_HASH];
    [[NSUserDefaults standardUserDefaults]setObject:session.fullName forKey:FULL_NAME];
    [[NSUserDefaults standardUserDefaults]setObject:session.userName forKey:USER_NAME];
    [[NSUserDefaults standardUserDefaults]setObject:session.email forKey:EMAIL];
    [[NSUserDefaults standardUserDefaults]setObject:session.coverPhotoUrl forKey:PHOTO_URL];
    [[NSUserDefaults standardUserDefaults]setObject:session.thumbPhotoUrl forKey:THUMB_URL];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:IS_LOGIN];
}

+(UserSession*)getUserSession {
    
    if([[NSUserDefaults standardUserDefaults]objectForKey:USER_ID] == nil)
        return nil;
    
    UserSession* userSession = [UserSession new];
    userSession.facebookId = [[NSUserDefaults standardUserDefaults]objectForKey:FACEBOOK_ID];
    userSession.twitterId = [[NSUserDefaults standardUserDefaults]objectForKey:TWITTER_ID];
    userSession.userId = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
    userSession.loginHash = [[NSUserDefaults standardUserDefaults]objectForKey:LOGIN_HASH];
    userSession.fullName = [[NSUserDefaults standardUserDefaults]objectForKey:FULL_NAME];
    userSession.userName = [[NSUserDefaults standardUserDefaults]objectForKey:USER_NAME];
    userSession.email = [[NSUserDefaults standardUserDefaults]objectForKey:EMAIL];
    
    userSession.coverPhotoUrl = [[NSUserDefaults standardUserDefaults]objectForKey:PHOTO_URL];
    userSession.thumbPhotoUrl = [[NSUserDefaults standardUserDefaults]objectForKey:THUMB_URL];
    
    
    return userSession;
}

+(void) clearAllSession {
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:FACEBOOK_ID];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:TWITTER_ID];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:USER_ID];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:LOGIN_HASH];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:FULL_NAME];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:USER_NAME];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:EMAIL];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:PHOTO_URL];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:THUMB_URL];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"address"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"agent_id"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"contact_no"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"country"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"created_at"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"email"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"name"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"sms"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"updated_at"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"zipcode"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"photo_url"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"thumb_url"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"twitter"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"fb"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"linkedin"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"company"];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"user_id"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:IS_LOGIN];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)isLoggedFromSocial {
    
    NSString* fbId = [[NSUserDefaults standardUserDefaults]objectForKey:FACEBOOK_ID];
    NSString* twitterId = [[NSUserDefaults standardUserDefaults]objectForKey:TWITTER_ID];
    
    BOOL isLoggedFromSocial = NO;
    
    if(fbId != nil && fbId.length > 0)
        isLoggedFromSocial = YES;
    
    if(twitterId != nil && twitterId.length > 0)
        isLoggedFromSocial = YES;
    
    return isLoggedFromSocial;
}

@end
