//
//  MGLoginView.m
//  StoreFinder
//
//
//  Copyright (c) 2014 Mangasaur Games. All rights reserved.
//

#import "MGLoginView.h"

@implementation MGLoginView

@synthesize buttonCancel;
@synthesize buttonBack;
@synthesize buttonLogin;
@synthesize buttonRegister;
@synthesize textFieldUsername;
@synthesize textFieldPassword;
@synthesize textFieldEmail;
@synthesize textFieldFullName;
@synthesize buttonTwitter;
@synthesize buttonFb;

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
