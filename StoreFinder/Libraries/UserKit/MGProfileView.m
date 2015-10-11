//
//  MGProfileView.m
//  StoreFinder
//
//
//  Copyright (c) 2014 Mangasaur Games. All rights reserved.
//

#import "MGProfileView.h"

@implementation MGProfileView

@synthesize textFieldFirstName;
@synthesize textFieldLastName;
@synthesize textFieldEmail;
@synthesize textFieldPassword;
@synthesize textFieldUsername;
@synthesize textFieldFullName;

@synthesize labelEmail;
@synthesize labelFirstName;
@synthesize labelLastName;
@synthesize imgViewThumb;
@synthesize imgViewCover;

@synthesize buttonThumb;
@synthesize buttonCover;
@synthesize buttonUpdate;
@synthesize buttonLogout;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
