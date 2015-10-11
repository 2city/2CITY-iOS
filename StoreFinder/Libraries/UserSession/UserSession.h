

#import <Foundation/Foundation.h>

@interface UserSession : NSObject

@property (nonatomic, retain) NSString* userId;
@property (nonatomic, retain) NSString* loginHash;
@property (nonatomic, retain) NSString* facebookId;
@property (nonatomic, retain) NSString* twitterId;
@property (nonatomic, retain) NSString* userName;
@property (nonatomic, retain) NSString* fullName;
@property (nonatomic, retain) NSString* thumbPhotoUrl;
@property (nonatomic, retain) NSString* coverPhotoUrl;
@property (nonatomic, retain) NSString* email;

@end
