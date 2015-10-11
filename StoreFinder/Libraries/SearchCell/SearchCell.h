//
//  SearchCell.h
//  RealEstateFinder
//
//
//  Copyright (c) 2014 Mangasaur Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIPickerView* pickerPriceMin;
@property (nonatomic, retain) IBOutlet UIPickerView* pickerPriceMax;
@property (nonatomic, retain) IBOutlet UIPickerView* pickerPropertyType;
@property (nonatomic, retain) IBOutlet UIPickerView* pickerSquareFoot;
@property (nonatomic, retain) IBOutlet UIPickerView* pickerYearBuiltMin;
@property (nonatomic, retain) IBOutlet UIPickerView* pickerYearBuiltMax;
@property (nonatomic, retain) IBOutlet UIPickerView* pickerLotSize;



@property (nonatomic, retain) IBOutlet UISegmentedControl* segmentControlBeds;
@property (nonatomic, retain) IBOutlet UISegmentedControl* segmentControlBaths;

@end
