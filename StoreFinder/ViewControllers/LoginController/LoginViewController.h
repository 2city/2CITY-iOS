

#import <UIKit/UIKit.h>
#import "MGLoginView.h"

@interface LoginViewController : GAITrackedViewController <UITextFieldDelegate> {
    
    MGLoginView* _loginView;
}

@property (nonatomic, retain) IBOutlet MGRawScrollView* scrollViewLogin;
@property (nonatomic, retain) IBOutlet UIButton* barButtonCancel;

-(IBAction)didClickCancelLogin:(id)sender;

@end
