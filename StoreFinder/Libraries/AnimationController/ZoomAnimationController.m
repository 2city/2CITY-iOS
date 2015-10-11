//
//  ZoomAnimationController.m
//  Galavanta
//
//
//  Copyright (c) 2014 MERKABAHNK LLC. All rights reserved.
//

#import "ZoomAnimationController.h"

@interface ZoomAnimationController ()

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation ZoomAnimationController

-(id)init{
    self = [super init];
    
    if(self){
        
        self.presentationDuration = 1.0;
        self.dismissalDuration = 0.5;
    }
    
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return self.isPresenting ? self.presentationDuration : self.dismissalDuration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    
    self.transitionContext = transitionContext;
    if(self.isPresenting){
        [self executePresentationAnimation:transitionContext];
    }
    else{
     
        [self executeDismissalAnimation:transitionContext];
    }
    
}

-(void)executePresentationAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView* inView = [transitionContext containerView];
    
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect offScreenFrame = inView.frame;
     offScreenFrame.origin.y = inView.frame.size.height;
     toViewController.view.frame = offScreenFrame;
    
    toViewController.view.backgroundColor = [UIColor blackColor];
    
    [inView insertSubview:toViewController.view aboveSubview:fromViewController.view];
    
    CFTimeInterval duration = self.presentationDuration;
    CFTimeInterval halfDuration = duration/2;
    
    CATransform3D t1 = [self firstTransform];
    CATransform3D t2 = [self secondTransformWithView:fromViewController.view];
    

    [UIView animateKeyframesWithDuration:halfDuration delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.5f animations:^{
            fromViewController.view.layer.transform = t1;
            fromViewController.view.alpha = 0.6;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5f relativeDuration:0.5f animations:^{
            
            fromViewController.view.layer.transform = t2;
        }];
        
    } completion:^(BOOL finished) {
        
    }];

    
    [UIView animateWithDuration:duration delay:(halfDuration - (0.3*halfDuration)) usingSpringWithDamping:0.7f initialSpringVelocity:6.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        toViewController.view.frame = inView.frame;
        
    } completion:^(BOOL finished) {
        [self.transitionContext completeTransition:YES];
    }];
}

-(void)executeDismissalAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView* inView = [transitionContext containerView];
    
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    toViewController.view.frame = inView.frame;
    CATransform3D scale = CATransform3DIdentity;
    toViewController.view.layer.transform = CATransform3DScale(scale, 0.6, 0.6, 1);
    toViewController.view.alpha = 0.6;
    
    [inView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    CGRect frameOffScreen = inView.frame;
    frameOffScreen.origin.y = inView.frame.size.height;
    
    NSTimeInterval duration = self.dismissalDuration;
    NSTimeInterval halfDuration = duration/2;
   
    CATransform3D t1 = [self firstTransform];
    
    [UIView animateKeyframesWithDuration:halfDuration delay:halfDuration - (0.3*halfDuration) options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.5f animations:^{
            toViewController.view.layer.transform = t1;
            toViewController.view.alpha = 1.0;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5f relativeDuration:0.5f animations:^{
            
            toViewController.view.layer.transform = CATransform3DIdentity;
        }];
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
    
    [UIView animateWithDuration:halfDuration animations:^{
        fromViewController.view.frame = frameOffScreen;
    } completion:^(BOOL finished) {

    }];
    

}

-(CATransform3D)firstTransform{
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    t1 = CATransform3DRotate(t1, 15.0f*M_PI/180.0f, 1, 0, 0);
    
    return t1;
    
}

-(CATransform3D)secondTransformWithView:(UIView*)view{
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = [self firstTransform].m34;
    t2 = CATransform3DTranslate(t2, 0, view.frame.size.height*-0.08, 0);
    t2 = CATransform3DScale(t2, 0.8, 0.8, 1);
    
    return t2;
}

@end
