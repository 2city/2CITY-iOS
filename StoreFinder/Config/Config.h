//
//  Config.h
// 
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#ifndef StoreFinder_Config_h
#define StoreFinder_Config_h

//// Change this on your own consumer key
//#define TWITTER_CONSUMER_KEY @"tOdoDTf8Ugzx9biT7X1alpTmy"
//
//// Change this on your own consumer secret
//#define TWITTER_CONSUMER_SECRET @"4rZhvHZTwEH9us2kKjCbRQKp7MfylohkQWuKLOubgPeE6xflmO"


// Change this on your own consumer key
#define TWITTER_CONSUMER_KEY @"H38nfnHau0QiP3y5nY2zhL8Ie"

// Change this on your own consumer secret
#define TWITTER_CONSUMER_SECRET @"ZKYBB29KIxcXPLIlVnPj2YyP2o2P1HQx28r3ioRcPIbLk2s9wv"



// You AdMob Banner Unit ID
#define BANNER_UNIT_ID @"26c4d22648d9483e"

// Your email that you wish that users on your app will contact you.
#define ABOUT_US_EMAIL @"torressilvasergio@gmail.com"

// Change this url depending on the name of your web hosting.
#define BASE_URL @"http://2city.merkabahnk.net/"


// AdMob background color
#define AD_BG_COLOR [UIColor clearColor]

// AdMob banner height
#define AD_BANNER_HEIGHT 50

// SHOW ADS ONLY IN MAIN VIEW (NEWS+SLIDER)
#define SHOW_ADS_MAIN_VIEW YES

// SHOW ADS ON FAVORITES VIEW
#define SHOW_ADS_FAVORITES_VIEW NO

// SHOW ADS ON FEATURED VIEW
#define SHOW_ADS_FEATURED_VIEW NO

// SHOW ADS ON FOR SEARCH VIEW
#define SHOW_ADS_SEARCH_VIEW NO

// SHOW ADS ON FOR NEWS VIEW
#define SHOW_ADS_NEWS_VIEW NO

// SHOW ADS ON CATEGORY VIEW
#define SHOW_ADS_CATEGORY_VIEW NO

// SHOW ADS ON MAP VIEW
#define SHOW_ADS_MAP_VIEW NO

// SHOW ADS ON STORE VIEW
#define SHOW_ADS_STORE_VIEW NO

// SHOW ADS ON STORE DETAIL VIEW
#define SHOW_ADS_STORE_DETAIL_VIEW NO

// KILOMETER TO MILES CONVERSION
#define KM_TO_MILES 0.621371f


// DO NOT EDIT THIS
// WE USE THIS FOR DEBUGGING PURPOSES
#define WILL_DOWNLOAD_DATA YES

// DO NOT EDIT THIS
#define CATEGORY_JSON_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"rest/categories.php"]

// DO NOT EDIT THIS
#define DATA_JSON_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"rest/data.php"]

// DO NOT EDIT THIS
#define DATA_NEWS_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"rest/data_news.php"]

// DO NOT EDIT THIS
#define REGISTER_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"rest/register.php"]

// DO NOT EDIT THISz
#define USER_PHOTO_UPLOAD_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"rest/file_uploader_user_photo.php"]

// DO NOT EDIT THIS
#define REVIEWS_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"rest/review_load_more.php"]

// DO NOT EDIT THIS
#define POST_REVIEW_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"rest/post_review.php"]

// DO NOT EDIT THIS
#define POST_RATING_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"rest/post_rating.php"]

// DO NOT EDIT THIS
#define GET_RATING_USER_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"rest/get_rating_user.php"]

// DO NOT EDIT THIS
#define LOGIN_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"rest/login.php"]

// DO NOT EDIT THIS
#define UPDATE_USER_PROFILE_URL [NSString stringWithFormat:@"%@%@", BASE_URL, @"rest/update_user_profile.php"]

// DO NOT EDIT THIS
#define WEATHER_URL @"http://api.openweathermap.org/data/2.5/weather?"

// DO NOT EDIT THIS
#define ICON_URL @"http://openweathermap.org/img/w/"

// DO NOT EDIT THIS
#define STATUS_SUCCESS @"-1"

// DO NOT EDIT THIS
#define STATUS_ERROR_LOGIN @"1"

// DO NOT EDIT THIS
#define STATUS_ERROR_CREDENTIALS @"2"

// DO NOT EDIT THIS
#define STATUS_ERROR_INVALID_ACCESS @"3"

// DO NOT EDIT THIS
#define STATUS_ERROR_USERNAME_EXIST @"4"

// DO NOT EDIT THIS
#define STATUS_ERROR_OUT_OF_SYNC @"5"

// DO NOT EDIT THIS
#define STATUS_CAN_RATE @"1"

// DO NOT EDIT THIS
#define ANCHOR_LEFT_PEEK 44.0

// DO NOT EDIT THIS
#define ANCHOR_RIGHT_PEEK 276.0

// DO NOT EDIT THIS
#define SEARCH_RADIUS_KILOMETERS 300

// DO NOT EDIT THIS
#define SEARCH_RADIUS_KILOMETERS_DEFAULT 50

// DO NOT EDIT THIS
#define SEARCH_RADIUS_KILOMETERS_MINIMUM 0


// Adjust this if you want to display reviews at a
// certain count and shows the View More Comments
#define MAX_REVIEW_COUNT_PER_LISTING 5

// Edit this to increase radius to show stores nearby
#define MAX_RADIUS_NEARBY_IN_METERS 20000


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) // iPhone and       iPod touch style UI

#define IS_IPHONE_5_IOS7 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_6_IOS7 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6P_IOS7 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0f)
#define IS_IPHONE_4_AND_OLDER_IOS7 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height < 568.0f)

#define IS_IPHONE_5_IOS8 (IS_IPHONE && ([[UIScreen mainScreen] nativeBounds].size.height/[[UIScreen mainScreen] nativeScale]) == 568.0f)
#define IS_IPHONE_6_IOS8 (IS_IPHONE && ([[UIScreen mainScreen] nativeBounds].size.height/[[UIScreen mainScreen] nativeScale]) == 667.0f)
#define IS_IPHONE_6P_IOS8 (IS_IPHONE && ([[UIScreen mainScreen] nativeBounds].size.height/[[UIScreen mainScreen] nativeScale]) == 736.0f)
#define IS_IPHONE_4_AND_OLDER_IOS8 (IS_IPHONE && ([[UIScreen mainScreen] nativeBounds].size.height/[[UIScreen mainScreen] nativeScale]) < 568.0f)

#define IS_IPHONE_5 ( ( [ [ UIScreen mainScreen ] respondsToSelector: @selector( nativeBounds ) ] ) ? IS_IPHONE_5_IOS8 : IS_IPHONE_5_IOS7 )
#define IS_IPHONE_6 ( ( [ [ UIScreen mainScreen ] respondsToSelector: @selector( nativeBounds ) ] ) ? IS_IPHONE_6_IOS8 : IS_IPHONE_6_IOS7 )
#define IS_IPHONE_6P ( ( [ [ UIScreen mainScreen ] respondsToSelector: @selector( nativeBounds ) ] ) ? IS_IPHONE_6P_IOS8 : IS_IPHONE_6P_IOS7 )
#define IS_IPHONE_4_AND_OLDER ( ( [ [ UIScreen mainScreen ] respondsToSelector: @selector( nativeBounds ) ] ) ? IS_IPHONE_4_AND_OLDER_IOS8 : IS_IPHONE_4_AND_OLDER_IOS7 )


#endif
