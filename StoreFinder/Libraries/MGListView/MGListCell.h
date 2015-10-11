//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTopLeftLabel.h"
#import "RateView.h"

@interface MGListCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel* labelTitle;
@property (nonatomic, retain) IBOutlet UILabel* labelSubtitle;

@property (nonatomic, retain) IBOutlet MGTopLeftLabel* topLeftLabelSubtitle;

@property (nonatomic, retain) IBOutlet UILabel* labelDescription;
@property (nonatomic, retain) IBOutlet UILabel* labelInfo;
@property (nonatomic, retain) IBOutlet UILabel* labelDetails;
@property (nonatomic, retain) IBOutlet UILabel* labelExtraInfo;

@property (nonatomic, retain) IBOutlet UIImageView* imgViewThumb;
@property (nonatomic, retain) IBOutlet UIImageView* imgViewBg;
@property (nonatomic, retain) IBOutlet UIImageView* imgViewPic;
@property (nonatomic, retain) IBOutlet UIImageView* imgViewArrow;
@property (nonatomic, retain) IBOutlet UIImageView* imgViewSelectionBackground;
@property (nonatomic, retain) IBOutlet UIImageView* imgViewFeatured;
@property (nonatomic, retain) IBOutlet UIImageView* imgViewFave;

@property (nonatomic, retain) IBOutlet UIImageView* imgViewIcon;

@property (nonatomic, retain) UIImage* selectedImage;
@property (nonatomic, retain) UIImage* unselectedImage;

@property (nonatomic, retain) UIImage* selectedImageIcon;
@property (nonatomic, retain) UIImage* unselectedImageIcon;

@property (nonatomic, retain) UIImage* selectedImageArrow;
@property (nonatomic, retain) UIImage* unselectedImageArrow;

@property (nonatomic, retain) UIColor* selectedColor;
@property (nonatomic, retain) UIColor* unSelectedColor;

@property (nonatomic, retain) id object;

@property (nonatomic, retain) IBOutlet UILabel* labelStatus;
@property (nonatomic, retain) IBOutlet UILabel* labelDateAdded;
@property (nonatomic, retain) IBOutlet UILabel* labelAddress;
@property (nonatomic, retain) IBOutlet UILabel* labelDesc;
@property (nonatomic, retain) IBOutlet UILabel* labelDistance;

@property (nonatomic, retain) IBOutlet UILabel* labelDateAddedVal;
@property (nonatomic, retain) IBOutlet MGTopLeftLabel* topLeftLabelAddressVal;
@property (nonatomic, retain) IBOutlet MGTopLeftLabel* topLeftLabelAddress2Val;
@property (nonatomic, retain) IBOutlet MGTopLeftLabel* topLeftLabelDescVal;

@property (nonatomic, retain) IBOutlet UIButton* buttonDirections;

@property (nonatomic, retain) IBOutlet MGMapView* mapViewCell;

@property (nonatomic, retain) IBOutlet UILabel* labelHeader4;
@property (nonatomic, retain) IBOutlet UILabel* labelHeader3;
@property (nonatomic, retain) IBOutlet UILabel* labelHeader2;
@property (nonatomic, retain) IBOutlet UILabel* labelHeader1;

@property (nonatomic, retain) IBOutlet UILabel* lblNonSelectorTitle;

@property (nonatomic, retain) IBOutlet RateView* ratingView;


@end
