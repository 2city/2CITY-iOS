


#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    kMenuAnimationOpen = 0,
    kMenuAnimationClosed = 1
}kMenuAnimation;


@interface MGUtilities : NSObject

+(BOOL)hasInternetConnection;

+(void)showAlertTitle:(NSString*)title message:(NSString*)msg;

+(void)createBorders:(UIImageView*)imgView
         borderColor:(UIColor*)borderColor
         shadowColor:(UIColor*)shadowColor
         borderWidth:(float)borderWidth;

+(void)createBorders:(UIImageView*)imgView
         borderColor:(UIColor*)borderColor
         shadowColor:(UIColor*)shadowColor
         borderWidth:(float)borderWidth
        borderRadius:(CGFloat)radius;

+(void)createBordersInView:(UIView*)view
               borderColor:(UIColor*)borderColor
               shadowColor:(UIColor*)shadowColor
               borderWidth:(float)borderWidth
              borderRadius:(CGFloat)radius;

+(NSString*)removeDelimetersInPhoneNo:(NSString*)contactNo;

+(BOOL)isRetinaDisplay;
+(UIImage*)convertImageToRetina:(UIImage*)image;
+(BOOL)validateEmail:(NSString*)email;
+(void)showStatusNotifier:(NSString*)status textColor:(UIColor*)color viewController:(UIViewController*)vc duration:(float)duration;

+(CGFloat)getWindowWidth;
+(CGFloat)getWindowHeight;
+(CGFloat)getViewWidth;
+(CGFloat)getViewHeight;


+(void)showStatusNotifier:(NSString*)status
                textColor:(UIColor*)color
           viewController:(UIViewController*)vc
                 duration:(float)duration
                  bgColor:(UIColor*)bgColor
                      atY:(float)y;

+(NSString*)writeImage:(UIImage*)image isThumb:(int)isThumb;
+(void)fadeView:(UIView *)thisView fadeOut:(BOOL)fadeOut duration:(float)duration;

+(double)getDistanceInKilotemeters:(CLLocation*)fromLocation toLocation:(CLLocation*)toLocation;

@end
