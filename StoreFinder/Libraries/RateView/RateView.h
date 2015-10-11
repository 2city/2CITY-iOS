

#import <UIKit/UIKit.h>

@class RateView;

@protocol RateViewDelegate

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating;

@end

@interface RateView : UIView
{
    UIImage* _notSelectedImage;
    UIImage* _halfSelectedImage;
    UIImage* _fullSelectedImage;
    float _rating;
    BOOL _editable;
    NSMutableArray* _imageViews;
    int _maxRating;
    int _midMargin;
    int _leftMargin;
    CGSize _minImageSize;
    
    __weak id <RateViewDelegate> _delegate;
}

@property (strong, nonatomic) UIImage* notSelectedImage;
@property (strong, nonatomic) UIImage* halfSelectedImage;
@property (strong, nonatomic) UIImage* fullSelectedImage;
@property (assign, nonatomic) float rating;
@property (assign) BOOL editable;
@property (strong) NSMutableArray * imageViews;
@property (assign, nonatomic) int maxRating;
@property (assign) int midMargin;
@property (assign) int leftMargin;
@property (assign) CGSize minImageSize;

@property (nonatomic, weak) __weak id <RateViewDelegate> delegate;

@end