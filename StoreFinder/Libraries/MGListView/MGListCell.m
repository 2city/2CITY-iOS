//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "MGListCell.h"

@implementation MGListCell


@synthesize labelTitle;
@synthesize labelSubtitle;
@synthesize topLeftLabelSubtitle;


@synthesize labelDescription;
@synthesize labelInfo;
@synthesize labelDetails;
@synthesize labelExtraInfo;
@synthesize imgViewThumb;
@synthesize imgViewBg;
@synthesize imgViewPic;


@synthesize selectedImage;
@synthesize unselectedImage;
@synthesize imgViewSelectionBackground;

@synthesize selectedColor;
@synthesize unSelectedColor;
@synthesize imgViewArrow;

@synthesize selectedImageArrow;
@synthesize unselectedImageArrow;

@synthesize selectedImageIcon;
@synthesize unselectedImageIcon;

@synthesize imgViewIcon;

@synthesize object;


@synthesize labelStatus;
@synthesize labelDateAdded;
@synthesize labelAddress;
@synthesize labelDesc;

@synthesize labelDateAddedVal;
@synthesize topLeftLabelAddressVal;
@synthesize topLeftLabelAddress2Val;
@synthesize topLeftLabelDescVal;
@synthesize mapViewCell;

@synthesize labelHeader1;
@synthesize labelHeader2;
@synthesize labelHeader3;
@synthesize labelHeader4;
@synthesize imgViewFave;
@synthesize labelDistance;

@synthesize ratingView;

@synthesize buttonDirections;

@synthesize lblNonSelectorTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // Configure the view for the selected state
    [super setSelected:selected animated:animated];
    
    if(selected) {
        imgViewSelectionBackground.image = selectedImage;
        imgViewArrow.image = selectedImageArrow;
        labelTitle.textColor = selectedColor;
        imgViewIcon.image = selectedImageIcon;
    }
    else {
        imgViewSelectionBackground.image = unselectedImage;
        imgViewArrow.image = unselectedImageArrow;
        labelTitle.textColor = unSelectedColor;
        imgViewIcon.image = unselectedImageIcon;
    }
}

@end
