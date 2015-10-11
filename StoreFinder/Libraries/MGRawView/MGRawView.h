//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTopLeftLabel.h"
#import "RateView.h"
#import "MGMapView.h"
#import "NMRangeSlider.h"
#import "MGTextField.h"
#import "MGButton.h"

@class MGRawView;

@protocol MGRawViewDelegate <NSObject>

-(void) MGRawView:(MGRawView*)view didPressedAnyButton:(UIButton*)button;

@end

@interface MGRawView : UIView <UITextFieldDelegate> {
    
    __weak id <MGRawViewDelegate> _delegate;
    id _object;
}
@property (nonatomic, retain) id object;

@property (nonatomic, retain) IBOutlet UILabel* labelTitle;
@property (nonatomic, retain) IBOutlet UILabel* labelSubtitle;
@property (nonatomic, retain) IBOutlet UILabel* labelDescription;
@property (nonatomic, retain) IBOutlet UILabel* labelInfo;
@property (nonatomic, retain) IBOutlet UILabel* labelDetails;
@property (nonatomic, retain) IBOutlet UILabel* labelExtraInfo;

@property (nonatomic, retain) IBOutlet MGButton* buttonGo;

@property (nonatomic, weak) __weak id <MGRawViewDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIButton* buttonCustom;
@property (nonatomic, retain) IBOutlet UITextField* textFieldCustom;
@property (nonatomic, retain) UITextField* activeTextField;
@property (nonatomic, retain) IBOutlet UIImageView* imgViewThumb;
@property (nonatomic, retain) IBOutlet UISegmentedControl* segmentAnimation;


@property (nonatomic, retain) IBOutlet MGTopLeftLabel* topLeftLabelAddress;
@property (nonatomic, retain) IBOutlet MGTopLeftLabel* topLeftLabelDescription;
//@property (nonatomic, retain) IBOutlet MGTopLeftLabel* topLeftLabelAmenities;
//@property (nonatomic, retain) IBOutlet UILabel* labelWorkingHours;


//@property (nonatomic, retain) IBOutlet RateView* ratingViewPrice;
//@property (nonatomic, retain) IBOutlet RateView* ratingViewFood;

//@property (nonatomic, retain) IBOutlet RateView* ratingViewFoodTo;
//@property (nonatomic, retain) IBOutlet RateView* ratingViewPriceTo;

//@property (nonatomic, retain) IBOutlet UITextField* textFieldCategory;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldKeywords;

@property (nonatomic, retain) IBOutlet UILabel* label1;
@property (nonatomic, retain) IBOutlet UILabel* label2;
@property (nonatomic, retain) IBOutlet UILabel* label3;
@property (nonatomic, retain) IBOutlet UILabel* label4;
@property (nonatomic, retain) IBOutlet UILabel* label5;

//@property (nonatomic, retain) IBOutlet UIButton* buttonSearch;
//@property (nonatomic, retain) IBOutlet UIButton* buttonCall;
@property (nonatomic, retain) IBOutlet UIButton* buttonEmail;
//@property (nonatomic, retain) IBOutlet UIButton* buttonWeb;
//@property (nonatomic, retain) IBOutlet UIButton* buttonShare;
@property (nonatomic, retain) IBOutlet UIButton* buttonFave;
//@property (nonatomic, retain) IBOutlet UIButton* buttonFb;
//@property (nonatomic, retain) IBOutlet UIButton* buttonTwitter;
//@property (nonatomic, retain) IBOutlet UIButton* buttonSMS;
//@property (nonatomic, retain) IBOutlet UIButton* buttonClear;



//@property (nonatomic, retain) IBOutlet UILabel* labelName;
//@property (nonatomic, retain) IBOutlet UILabel* labelYear;
//@property (nonatomic, retain) IBOutlet UILabel* labelModel;
//@property (nonatomic, retain) IBOutlet UILabel* labelMake;
//@property (nonatomic, retain) IBOutlet UILabel* labelPrice;
//@property (nonatomic, retain) IBOutlet UILabel* labelDesc;
//@property (nonatomic, retain) IBOutlet UILabel* labelMileage;
//@property (nonatomic, retain) IBOutlet UILabel* labelBodyStyle;
//@property (nonatomic, retain) IBOutlet UILabel* labelDoors;
//@property (nonatomic, retain) IBOutlet UILabel* labelExteriorColor;
//@property (nonatomic, retain) IBOutlet UILabel* labelInteriorColor;
//@property (nonatomic, retain) IBOutlet UILabel* labelFuelType;
//@property (nonatomic, retain) IBOutlet UILabel* labelEngine;
//@property (nonatomic, retain) IBOutlet UILabel* labelTransmission;
//@property (nonatomic, retain) IBOutlet UILabel* labelDriveTrain;
//@property (nonatomic, retain) IBOutlet UILabel* labelWheelbase;
//@property (nonatomic, retain) IBOutlet UILabel* labelCarType;
//@property (nonatomic, retain) IBOutlet UILabel* labelNotes;
//@property (nonatomic, retain) IBOutlet UILabel* labelAddress;
//@property (nonatomic, retain) IBOutlet UILabel* labelPhone;

//@property (nonatomic, retain) IBOutlet UILabel* labelSalesMonFri;
//@property (nonatomic, retain) IBOutlet UILabel* labelSalesSat;
//@property (nonatomic, retain) IBOutlet UILabel* labelSalesSun;

//@property (nonatomic, retain) IBOutlet UILabel* labelServiceMonFri;
//@property (nonatomic, retain) IBOutlet UILabel* labelServiceSat;
//@property (nonatomic, retain) IBOutlet UILabel* labelServiceSun;

@property (nonatomic, retain) IBOutlet UILabel* labelPhotos;


//@property (nonatomic, retain) IBOutlet MGMapView* mapViewDirections;

//@property (nonatomic, retain) IBOutlet NMRangeSlider* rangeSliderPrice;
//@property (nonatomic, retain) IBOutlet UILabel* labelRangeSliderMin;
//@property (nonatomic, retain) IBOutlet UILabel* labelRangeSliderMax;

//@property (nonatomic, retain) IBOutlet UIButton* buttonMake;
//@property (nonatomic, retain) IBOutlet UIButton* buttonYear;
//@property (nonatomic, retain) IBOutlet UIButton* buttonModel;
//@property (nonatomic, retain) IBOutlet UIButton* buttonDealer;
//@property (nonatomic, retain) IBOutlet UIButton* buttonGalleries;
@property (nonatomic, retain) IBOutlet UIButton* buttonStarred;

//@property (nonatomic, retain) IBOutlet UIImageView* imgViewGalleryThumb1;
//@property (nonatomic, retain) IBOutlet UIImageView* imgViewGalleryThumb2;
//@property (nonatomic, retain) IBOutlet UIImageView* imgViewGalleryThumb3;


//@property (nonatomic, retain) IBOutlet UIButton* buttonBack;
//@property (nonatomic, retain) IBOutlet UIButton* buttonLogin;
//@property (nonatomic, retain) IBOutlet UIButton* buttonRegister;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldUsername;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldPassword;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldEmail;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldFullName;

//@property (nonatomic, retain) IBOutlet UITextField* textFieldSellerName;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldDealerName;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldContactNo;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldSMSNo;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldAddress;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldFacebookPage;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldTwitter;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldWebsite;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldSalesMonFri;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldSalesSat;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldSalesSun;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldServiceMonFri;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldServiceSat;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldServiceSun;

//@property (nonatomic, retain) IBOutlet UISegmentedControl* segmentCarType;
//@property (nonatomic, retain) IBOutlet UITextView* textViewNotes;
//@property (nonatomic, retain) IBOutlet UITextView* textViewDetails;

@property (nonatomic, retain) IBOutlet UIButton* buttonNext;
@property (nonatomic, retain) IBOutlet UIButton* buttonPhotos;
//@property (nonatomic, retain) IBOutlet UIButton* buttonDone;
//@property (nonatomic, retain) IBOutlet UIButton* buttonDelete;

//@property (nonatomic, retain) IBOutlet UIButton* buttonSeller;


//@property (nonatomic, retain) IBOutlet UITextField* textFieldCarName;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldPrice;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldModel;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldYear;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldMake;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldMileage;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldBodyStyle;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldDoors;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldExteriorColor;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldInteriorColor;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldFuelType;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldEngine;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldTransmission;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldDriveTrain;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldWheelbase;
//
//@property (nonatomic, retain) IBOutlet MGTextField* textFieldMGUsername;
//@property (nonatomic, retain) IBOutlet MGTextField* textFieldMGPassword;
//@property (nonatomic, retain) IBOutlet MGTextField* textFieldMGEmail;
//@property (nonatomic, retain) IBOutlet MGTextField* textFieldMGFullName;
//
//@property (nonatomic, retain) IBOutlet UILabel* labelContactNo;
//@property (nonatomic, retain) IBOutlet UILabel* labelEmail;
//@property (nonatomic, retain) IBOutlet UILabel* labelFb;
//@property (nonatomic, retain) IBOutlet UILabel* labelTwitter;
//@property (nonatomic, retain) IBOutlet UILabel* labelWebsite;
//@property (nonatomic, retain) IBOutlet UILabel* labelSMSNo;
//
//@property (nonatomic, retain) IBOutlet UILabel* labelZipCode;
//@property (nonatomic, retain) IBOutlet UILabel* labelCountry;
//
//@property (nonatomic, retain) IBOutlet UILabel* labelLinkedIn;
//@property (nonatomic, retain) IBOutlet UILabel* labelCompany;
//@property (nonatomic, retain) IBOutlet UILabel* labelDateAdded;
//@property (nonatomic, retain) IBOutlet MGTopLeftLabel* labelTopLeftLabelAddressVal;
//@property (nonatomic, retain) IBOutlet UIButton* buttonView;
//
//@property (nonatomic, retain) IBOutlet UILabel* labelCompanyVal;
//@property (nonatomic, retain) IBOutlet UILabel* labelDateAddedVal;
//@property (nonatomic, retain) IBOutlet UILabel* labelLinkedInVal;
//@property (nonatomic, retain) IBOutlet UILabel* labelContactNoVal;
//@property (nonatomic, retain) IBOutlet UILabel* labelEmailVal;
//@property (nonatomic, retain) IBOutlet UILabel* labelFbVal;
//@property (nonatomic, retain) IBOutlet UILabel* labelTwitterVal;
//@property (nonatomic, retain) IBOutlet UILabel* labelSMSNoVal;

@property (nonatomic, retain) IBOutlet UIImageView* imgViewPhoto;
//@property (nonatomic, retain) IBOutlet UIButton* buttonThumb;
//@property (nonatomic, retain) IBOutlet UIButton* buttonLargePhoto;
//@property (nonatomic, retain) IBOutlet UIButton* buttonPropertyType;
//
//
//@property (nonatomic, retain) IBOutlet UITextField* textFieldName;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldCompany;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldZipCode;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldCountry;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldFb;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldLinkedIn;
//
//@property (nonatomic, retain) IBOutlet UILabel* labelStatus;
//@property (nonatomic, retain) IBOutlet UILabel* labelBeds;
//@property (nonatomic, retain) IBOutlet UILabel* labelBath;
//@property (nonatomic, retain) IBOutlet UILabel* labelSqft;
//@property (nonatomic, retain) IBOutlet UILabel* labelPriceSqft;
//@property (nonatomic, retain) IBOutlet UILabel* labelRooms;
//@property (nonatomic, retain) IBOutlet UILabel* labelLotSize;
//@property (nonatomic, retain) IBOutlet UILabel* labelBuiltIn;
//@property (nonatomic, retain) IBOutlet UILabel* labelPropertyType;
//
//@property (nonatomic, retain) IBOutlet UITextField* textFieldStatus;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldBeds;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldBaths;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldSqft;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldPriceSqft;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldRooms;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldLotSize;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldBuiltIn;
//@property (nonatomic, retain) IBOutlet UITextField* textFieldPropertyType;
//
//@property (nonatomic, retain) IBOutlet UISegmentedControl* segmentStatus;



-(id)initWithNibName:(NSString*)nibNameOrNil;

- (id)initWithFrame:(CGRect)frame nibName:(NSString*)nibNameOrNil;

@end