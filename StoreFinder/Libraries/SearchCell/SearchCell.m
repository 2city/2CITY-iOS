//
//  SearchCell.m
//  RealEstateFinder
//
//
//  Copyright (c) 2014 Mangasaur Games. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell

@synthesize pickerPriceMin;
@synthesize pickerPriceMax;
@synthesize pickerPropertyType;
@synthesize pickerSquareFoot;
@synthesize pickerYearBuiltMin;
@synthesize pickerYearBuiltMax;
@synthesize pickerLotSize;

@synthesize segmentControlBaths;
@synthesize segmentControlBeds;




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
