//
//  NewsDetailViewController.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : GAITrackedViewController

@property (nonatomic, retain) IBOutlet UIBarButtonItem* barButtonBack;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* barButtonForward;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* barButtonRefresh;
@property (nonatomic, retain) IBOutlet UIWebView* webViewMain;
@property (nonatomic, retain) NSString* strUrl;
@property (nonatomic, retain) NSString* strShow;

-(IBAction)didClickBarButtonBack:(id)sender;
-(IBAction)didClickBarButtonForward:(id)sender;
-(IBAction)didClickBarButtonRefresh:(id)sender;

@end
