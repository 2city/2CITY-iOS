


#import "MGUtilities.h"
#import "Reachability.h"

@implementation MGUtilities

+(BOOL)hasInternetConnection {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        return YES;
    }
    
    return NO;
}

+(void)showAlertTitle:(NSString*)title message:(NSString*)msg {
    UIAlertView* alertView;
    
    alertView = [[UIAlertView alloc] initWithTitle:title
                                           message:msg
                                          delegate:nil
                                 cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
    
    [alertView show];
}


+(void)createBorders:(UIImageView*)imgView
         borderColor:(UIColor*)borderColor
         shadowColor:(UIColor*)shadowColor
         borderWidth:(float)borderWidth {
    
    [imgView.layer setShadowOpacity:0.80f];
    [imgView.layer setShadowOffset:CGSizeMake(1.0f, 1.0f)];
    [imgView.layer setShadowColor:[shadowColor CGColor]];
    
    [imgView.layer setBorderWidth:borderWidth];
    [imgView.layer setBorderColor:[borderColor CGColor]];
    
//    [imgView.layer setShouldRasterize:YES];
    [imgView.layer setMasksToBounds:YES];
}

+(void)createBorders:(UIImageView*)imgView
         borderColor:(UIColor*)borderColor
         shadowColor:(UIColor*)shadowColor
         borderWidth:(float)borderWidth
        borderRadius:(CGFloat)radius {
    
    [imgView.layer setShadowOpacity:0.80f];
    [imgView.layer setShadowOffset:CGSizeMake(1.0f, 1.0f)];
    [imgView.layer setShadowColor:[shadowColor CGColor]];

    imgView.layer.cornerRadius = radius;
    imgView.clipsToBounds = YES;
    [imgView.layer setBorderWidth:borderWidth];
    [imgView.layer setBorderColor:[borderColor CGColor]];
    
//    [imgView.layer setShouldRasterize:YES];
    [imgView.layer setMasksToBounds:YES];
}


+(void)createBordersInView:(UIView*)view
               borderColor:(UIColor*)borderColor
               shadowColor:(UIColor*)shadowColor
               borderWidth:(float)borderWidth
              borderRadius:(CGFloat)radius {
    
    [view.layer setShadowOpacity:0.80f];
    [view.layer setShadowOffset:CGSizeMake(1.0f, 1.0f)];
    [view.layer setShadowColor:[shadowColor CGColor]];
    
    view.layer.cornerRadius = radius;
    view.clipsToBounds = YES;
    [view.layer setBorderWidth:borderWidth];
    [view.layer setBorderColor:[borderColor CGColor]];
    
    [view.layer setMasksToBounds:YES];
}


+(NSString*)removeDelimetersInPhoneNo:(NSString*)contactNo {
    
    NSString* phone = [contactNo stringByReplacingOccurrencesOfString:@"(" withString:@""];
    
    phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    
    return phone;
}


+(BOOL)isRetinaDisplay {
    
    BOOL isRetinaDisplay = NO;
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        isRetinaDisplay = [[UIScreen mainScreen] scale] == 2.0 ? YES : NO;
    
    return isRetinaDisplay;
}

+(UIImage*)convertImageToRetina:(UIImage*)image {
    UIImage* retinaImage=[UIImage imageWithCGImage:[image CGImage] scale:2.0 orientation:UIImageOrientationUp];
    
    return retinaImage;
}

+(BOOL)validateEmail:(NSString*)email {
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];

    if ([emailTest evaluateWithObject:email] == YES) {
        return YES;
    }
    
    return NO;
}

+(void)showStatusNotifier:(NSString*)status textColor:(UIColor*)color viewController:(UIViewController*)vc duration:(float)duration{
    MGRawView* rawView = [[MGRawView alloc] initWithNibName:@"NotificationView"];
    
    [rawView.labelTitle setText:status];
    [rawView.labelTitle setTextColor:color];
    
    CGRect frame = rawView.frame;
    frame.origin.y = 64;
    
    rawView.frame = frame;
    
    [vc.view addSubview:rawView];
    
    [UIView animateWithDuration:1.0
                          delay:duration
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         rawView.alpha = 0.0;
                     }
     
                     completion:^(BOOL finished) {
                         [rawView removeFromSuperview];
                     }
     ];
}

+(void)showStatusNotifier:(NSString*)status
                textColor:(UIColor*)color
           viewController:(UIViewController*)vc
                 duration:(float)duration
                  bgColor:(UIColor*)bgColor
                      atY:(float)y {
    
    MGRawView* rawView = [[MGRawView alloc] initWithNibName:@"NotificationView"];
    
    rawView.layer.zPosition = 99999;
    rawView.backgroundColor = bgColor;
    [rawView.labelTitle setText:status];
    [rawView.labelTitle setTextColor:color];
    
    CGRect frame = rawView.frame;
    frame.origin.y = y;
    
    rawView.frame = frame;
    rawView.alpha = 0.0;
    
    [vc.view addSubview:rawView];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         rawView.alpha = 1.0;
                     }
     
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:duration
                                               delay:2.0
                                             options: UIViewAnimationOptionCurveEaseInOut
                                          animations:^ {
                                              rawView.alpha = 0.0;
                                          }
                          
                                          completion:^(BOOL finished) {
                                              [rawView removeFromSuperview];
                                          }
                          ];
                     }
     ];
}



+(CGFloat)getWindowHeight {
    return [UIScreen mainScreen].applicationFrame.size.height;
}

+(CGFloat)getViewHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+(CGFloat)getViewWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+(CGFloat)getWindowWidth {
    return [UIScreen mainScreen].applicationFrame.size.width;
}


+(NSString*)writeImage:(UIImage*)image isThumb:(int)isThumb {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/images"];
    
    NSError* error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:&error];
    }
    
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString* uniqueId = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    
    NSString* fileName = [NSString stringWithFormat:@"thumb_%@.png",uniqueId];
    
    if(!isThumb)
        fileName = [NSString stringWithFormat:@"large_%@.png",uniqueId];
    
    NSLog(@"filename = %@", fileName);
    
    NSString* path = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSData* data = UIImagePNGRepresentation(image);
    [data writeToFile:path atomically:YES];
    
    return path;
}

+(void)fadeView:(UIView *)thisView fadeOut:(BOOL)fadeOut duration:(float)duration {
    
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    if (fadeOut) {
        thisView.alpha = 0;
    } else {
        thisView.alpha = 1;
    }
    [UIView commitAnimations];
}

+(double)getDistanceInKilotemeters:(CLLocation*)fromLocation toLocation:(CLLocation*)toLocation {
    
    
    double distance = [toLocation distanceFromLocation:fromLocation] / 1000;
    
    return distance;
}


@end
