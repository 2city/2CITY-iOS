//
//  ImageViewerController.m
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "ImageViewerController.h"

@interface ImageViewerController ()

@end

@implementation ImageViewerController

@synthesize imageViewer;
@synthesize imageArray;
@synthesize selectedIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.navigationItem.titleView = [MGUIAppearance createLogo:HEADER_LOGO];
    self.view.backgroundColor = BG_VIEW_COLOR;
    
    [MGUIAppearance enhanceNavBarController:self.navigationController
                               barTintColor:WHITE_TEXT_COLOR
                                  tintColor:WHITE_TEXT_COLOR
                             titleTextColor:WHITE_TEXT_COLOR];
    
    imageViewer.imageViewerDelegate = self;
    imageViewer.imageCount = imageArray.count;
    [imageViewer setNeedsReLayout];
    [imageViewer setPage:selectedIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) MGImageViewer:(MGImageViewer *)_imageViewer didCreateRawScrollView:(MGRawScrollView *)rawScrollView atIndex:(int)index{
    
    Photo* photo = [imageArray objectAtIndex:index];
    NSURL* url = [NSURL URLWithString:photo.photo_url];
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:url];
    
    __weak typeof(rawScrollView.imageView ) weakImgRef = rawScrollView.imageView;
    UIImage* imgPlaceholder = [UIImage imageNamed:IMAGE_VIEWER_PLACEHOLDER_IMAGE];
    
    [weakImgRef setImageWithURLRequest:urlRequest placeholderImage:imgPlaceholder
                               success:^(NSURLRequest* request, NSHTTPURLResponse* response, UIImage* image) {
                                   [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                       
                                       rawScrollView.imageView.image = image;
                                       CGRect rect = rawScrollView.imageView.frame;
                                       rect.size = image.size;
                                       rawScrollView.imageView.frame = rect;
                                       
                                       CGFloat newZoomScale = rawScrollView.frame.size.width / rawScrollView.imageView.frame.size.width;
                                       rawScrollView.minimumZoomScale = newZoomScale;
                                       [rawScrollView setZoomScale:newZoomScale animated:YES];
                                       //                 rawScrollView.contentSize = image.size;
                                       
                                       [imageViewer centerScrollViewContents:rawScrollView];
                                   }];
                                   
                               } failure:^(NSURLRequest* request, NSHTTPURLResponse* response, NSError* error) {
                                   
                               }];
}

-(IBAction)didClickBarButtonDone:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
