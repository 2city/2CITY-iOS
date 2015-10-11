//
//  MGFooterView.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "MGRawView.h"

@interface MGFooterView : MGRawView

@property (nonatomic, retain) IBOutlet UIButton* buttonFacebook;
@property (nonatomic, retain) IBOutlet UIButton* buttonTwitter;
@property (nonatomic, retain) IBOutlet UIButton* buttonSMS;
@property (nonatomic, retain) IBOutlet UIButton* buttonCall;
@property (nonatomic, retain) IBOutlet UIButton* buttonEmail;
@property (nonatomic, retain) IBOutlet UIButton* buttonWebsite;
@property (nonatomic, retain) IBOutlet UIButton* buttonRoute;

@property (nonatomic, retain) IBOutlet UIButton* buttonPost;
@property (nonatomic, retain) IBOutlet UITextView* textViewReview;

@end
