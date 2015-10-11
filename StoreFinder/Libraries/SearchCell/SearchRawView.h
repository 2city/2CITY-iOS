//
//  SearchRawView.h
//  RealEstateFinder
//
//
//  Copyright (c) 2014 Mangasaur Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchRawView : MGRawView

@property (nonatomic, retain) IBOutlet UIButton* buttonSearch;
@property (nonatomic, retain) IBOutlet UIPickerView* pickerCategories;
@property (nonatomic, retain) IBOutlet UITextField* textFieldKeyword;
@property (nonatomic, retain) IBOutlet UISwitch* switchNearby;
@property (nonatomic, retain) IBOutlet UISlider* sliderRadius;


@property (nonatomic, retain) IBOutlet UILabel* labelNearby;
@property (nonatomic, retain) IBOutlet UILabel* labelCategory;
@property (nonatomic, retain) IBOutlet UILabel* labelRadius;


@end
