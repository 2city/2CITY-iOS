//
//  MGHeaderView.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "MGRawView.h"
#import "RateView.h"

@interface MGHeaderView : MGRawView

@property (nonatomic, retain) IBOutlet RateView* ratingView;
@property (nonatomic, retain) IBOutlet UIButton* buttonRate;
@property (nonatomic, retain) IBOutlet UIImageView* imgViewFeatured;

@end
