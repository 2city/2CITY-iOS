//
//  SideViewController.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideViewController : GAITrackedViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIImageView *imgSlide;
}
-(IBAction)didClickButtonMenu:(id)sender;
@property(nonatomic, retain) IBOutlet UITableView* tableViewSide;
@property(nonatomic, retain) IBOutlet UIButton* buttonMenuClose;

-(void)updateUI;

@end
