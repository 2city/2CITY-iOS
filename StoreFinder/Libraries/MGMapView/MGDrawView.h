//
//  MGDrawView.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGDrawView;

@protocol MGMapDrawViewDelegate <NSObject>

-(void)MGDrawView:(MGDrawView*)drawView touchesMoved:(UITouch *)touch;
-(void)MGDrawView:(MGDrawView*)drawView touchesEnded:(UITouch *)touch;
-(void)MGDrawView:(MGDrawView*)drawView touchesBegan:(UITouch *)touch;

@end

@interface MGDrawView : UIImageView {
    id <MGMapDrawViewDelegate> _delegate;
}

@property(nonatomic, retain) id <MGMapDrawViewDelegate> delegate;

@end
