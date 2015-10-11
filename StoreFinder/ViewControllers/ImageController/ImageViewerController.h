//
//  ImageViewerController.h
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewerController : GAITrackedViewController <MGImageViewerDelegate>

@property (nonatomic, retain) IBOutlet MGImageViewer* imageViewer;
@property (nonatomic, retain) NSArray* imageArray;
@property (nonatomic, assign) int selectedIndex;

-(IBAction)didClickBarButtonDone:(id)sender;

@end
