//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "MGTopLeftLabel.h"

@implementation MGTopLeftLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void) drawTextInRect:(CGRect)inFrame {
    CGRect draw = [self textRectForBounds:inFrame limitedToNumberOfLines:[self numberOfLines]];
    
    draw.origin = CGPointZero;
    
    [super drawTextInRect:draw];
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
