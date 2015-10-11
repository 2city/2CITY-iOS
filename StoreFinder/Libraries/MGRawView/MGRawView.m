//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "MGRawView.h"

@implementation MGRawView

@synthesize object;
@synthesize labelTitle;
@synthesize labelSubtitle;
@synthesize labelDescription;
@synthesize labelInfo;
@synthesize labelDetails;
@synthesize labelExtraInfo;
@synthesize buttonGo;
@synthesize segmentAnimation;

@synthesize delegate = _delegate;

@synthesize buttonCustom;
@synthesize textFieldCustom;

@synthesize activeTextField;
@synthesize imgViewThumb;

@synthesize topLeftLabelAddress;
//@synthesize topLeftLabelAmenities;
@synthesize topLeftLabelDescription;
//@synthesize labelWorkingHours;


//@synthesize buttonCall;
@synthesize buttonFave;
@synthesize buttonEmail;
//@synthesize buttonShare;
//@synthesize buttonWeb;

//@synthesize ratingViewFoodTo;
//@synthesize ratingViewPriceTo;

//@synthesize textFieldCategory;
//@synthesize textFieldKeywords;

@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize label4;
@synthesize label5;
//@synthesize buttonSearch;



//@synthesize labelName;
//@synthesize labelYear;
//@synthesize labelModel;
//@synthesize labelMake;
//@synthesize labelPrice;
//@synthesize labelDesc;
//@synthesize labelMileage;
//@synthesize labelBodyStyle;
//@synthesize labelDoors;
//@synthesize labelExteriorColor;
//@synthesize labelInteriorColor;
//@synthesize labelFuelType;
//@synthesize labelEngine;
//@synthesize labelTransmission;
//@synthesize labelDriveTrain;
//@synthesize labelWheelbase;
//@synthesize labelCarType;
//@synthesize labelNotes;
//@synthesize labelAddress;
//@synthesize labelPhone;
//@synthesize mapViewDirections;



//@synthesize labelSalesMonFri;
//@synthesize labelSalesSat;
//@synthesize labelSalesSun;
//
//@synthesize labelServiceMonFri;
//@synthesize labelServiceSat;
//@synthesize labelServiceSun;


//@synthesize buttonFb;
//@synthesize buttonTwitter;
//@synthesize buttonSMS;
//@synthesize buttonClear;

//@synthesize rangeSliderPrice;
//@synthesize labelRangeSliderMin;
//@synthesize labelRangeSliderMax;

//@synthesize buttonMake;
//@synthesize buttonModel;
//@synthesize buttonYear;
//@synthesize buttonDealer;
//@synthesize buttonGalleries;
//
//@synthesize imgViewGalleryThumb1;
//@synthesize imgViewGalleryThumb2;
//@synthesize imgViewGalleryThumb3;
//
//
//@synthesize buttonBack;
//@synthesize buttonLogin;
//@synthesize buttonRegister;
//@synthesize textFieldUsername;
//@synthesize textFieldPassword;
//@synthesize textFieldEmail;
//@synthesize textFieldFullName;
//
//@synthesize textFieldDealerName;
//@synthesize textFieldContactNo;
//@synthesize textFieldSMSNo;
//@synthesize textFieldAddress;
//@synthesize textFieldFacebookPage;
//@synthesize textFieldTwitter;
//@synthesize textFieldWebsite;
//@synthesize textFieldSalesMonFri;
//@synthesize textFieldSalesSat;
//@synthesize textFieldSalesSun;
//@synthesize textFieldServiceMonFri;
//@synthesize textFieldServiceSat;
//@synthesize textFieldServiceSun;
//@synthesize textFieldSellerName;

//@synthesize segmentCarType;
//@synthesize textViewNotes;

@synthesize buttonNext;
//@synthesize buttonDone;
@synthesize buttonPhotos;
//@synthesize buttonDelete;
@synthesize labelPhotos;

//@synthesize buttonSeller;

//@synthesize textFieldMGUsername;
//@synthesize textFieldMGPassword;
//@synthesize textFieldMGEmail;
//@synthesize textFieldMGFullName;



//@synthesize labelContactNo;
//@synthesize labelEmail;

//@synthesize labelFb;
//@synthesize labelTwitter;
//@synthesize labelWebsite;
//@synthesize labelSMSNo;

@synthesize imgViewPhoto;
//@synthesize buttonThumb;
//@synthesize buttonLargePhoto;
//@synthesize textViewDetails;
@synthesize buttonStarred;

//@synthesize labelCompany;
//@synthesize labelDateAdded;
//@synthesize labelTopLeftLabelAddressVal;
//@synthesize buttonView;

//@synthesize labelCompanyVal;
//@synthesize labelDateAddedVal;
//@synthesize labelLinkedInVal;
//@synthesize labelContactNoVal;
//@synthesize labelEmailVal;
//@synthesize labelFbVal;
//@synthesize labelTwitterVal;
//@synthesize labelSMSNoVal;

//@synthesize labelLinkedIn;
//@synthesize labelCountry;

//@synthesize textFieldName;
//@synthesize textFieldCompany;
//@synthesize textFieldZipCode;
//@synthesize textFieldCountry;
//@synthesize textFieldFb;
//@synthesize textFieldLinkedIn;


//@synthesize labelStatus;
//@synthesize labelBeds;
//@synthesize labelBath;
//@synthesize labelSqft;
//@synthesize labelPriceSqft;
//@synthesize labelRooms;
//@synthesize labelLotSize;
//@synthesize labelBuiltIn;
//@synthesize labelPropertyType;


//@synthesize textFieldStatus;
//@synthesize textFieldBeds;
//@synthesize textFieldBaths;
//@synthesize textFieldSqft;
//@synthesize textFieldPriceSqft;
//@synthesize textFieldRooms;
//@synthesize textFieldLotSize;
//@synthesize textFieldBuiltIn;
//@synthesize textFieldPropertyType;
//@synthesize segmentStatus;
//@synthesize buttonPropertyType;

-(id)initWithNibName:(NSString*)nibNameOrNil {
    self = [super init];
    
    if (self) {
        // Initialization code
        NSArray* _nibContents = [[NSBundle mainBundle] loadNibNamed:nibNameOrNil
                                                              owner:self
                                                            options:nil];
        self = [_nibContents objectAtIndex:0];
        [self baseInit];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame nibName:(NSString*)nibNameOrNil {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray* _nibContents = [[NSBundle mainBundle] loadNibNamed:nibNameOrNil
                                                              owner:self
                                                            options:nil];
        self = [_nibContents objectAtIndex:0];
        //        self.frame = frame;
        
        [self baseInit];
    }
    
    return self;
}


-(void)baseInit {
    [buttonCustom addTarget:self action:@selector(didClickButtons:) forControlEvents:UIControlEventTouchUpInside];
    textFieldCustom.delegate = self;
}


-(void)didClickButtons:(id)sender {
    [self.delegate MGRawView:self didPressedAnyButton:sender];
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView * view in [self subviews]) {
        if (view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event]) {
            return YES;
        }
    }
    return NO;
}*/

// dismisses the keyboard when a user selects the return key
- (BOOL) textFieldShouldReturn: (UITextField *) theTextField {
	[theTextField resignFirstResponder];
	return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField {
    activeTextField = textField;
}

@end
