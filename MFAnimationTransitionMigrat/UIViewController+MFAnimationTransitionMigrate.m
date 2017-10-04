//
//  UIViewController+AnimationTransitionMigrate.m
//  testCollectionView
//
//  Created by Lyman Li on 2017/10/3.
//  Copyright © 2017年 Lyman Li. All rights reserved.
//

#import "UIViewController+MFAnimationTransitionMigrate.h"
#import "MFAnimationTransitionMigrateEnter.h"
#import "MFAnimationTransitionMigrateExit.h"
#import <objc/runtime.h>

static void *mf_sourceViewKeys = &mf_sourceViewKeys;
static void *mf_targetViewKeys = &mf_targetViewKeys;
static void *mf_interactivePopTransition = &mf_interactivePopTransition;

@interface UIViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *mf_interactivePopTransition;

@end

@implementation UIViewController (MFAnimationTransitionMigrate)

- (void)mf_setMigrateTargetView:(UIView *)view withTag:(NSString *)tag {

    if (!self.mf_targetViewKeys) {
        self.mf_targetViewKeys = [[NSMutableDictionary alloc] init];
    }
    [self.mf_targetViewKeys setObject:view forKey:tag];
}

- (void)mf_setMigrateSourceView:(UIView *)view withTag:(NSString *)tag {

    if (!self.mf_sourceViewKeys) {
        self.mf_sourceViewKeys = [[NSMutableDictionary alloc] init];
    }
    [self.mf_sourceViewKeys setObject:view forKey:tag];
}

- (void)mf_registerNavigationControllerDelegate {

    self.navigationController.delegate = self;
}

- (void)mf_removeNavigationControllerDelegate {

    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

- (void)mf_enablePopInteractivePopTransition {

    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(mf_handlePopRecognizer:)];
    popRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRecognizer];
}

#pragma mark - setter
- (void)setMf_sourceViewKeys:(NSMutableDictionary *)keys {

    objc_setAssociatedObject(self, &mf_sourceViewKeys, keys, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMf_targetViewKeys:(NSMutableDictionary *)keys {

    objc_setAssociatedObject(self, &mf_targetViewKeys, keys, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMf_interactivePopTransition:(UIPercentDrivenInteractiveTransition *)transition {

    objc_setAssociatedObject(self, &mf_interactivePopTransition, transition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter
- (NSMutableDictionary *)mf_sourceViewKeys {

    return objc_getAssociatedObject(self, &mf_sourceViewKeys);
}

- (NSMutableDictionary *)mf_targetViewKeys {

    return objc_getAssociatedObject(self, &mf_targetViewKeys);
}

- (UIPercentDrivenInteractiveTransition *)mf_interactivePopTransition {

    return objc_getAssociatedObject(self, &mf_interactivePopTransition);
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    if (fromVC == self) {
        if (operation == UINavigationControllerOperationPush &&
            [self.mf_sourceViewKeys count] > 0) {
            return [[MFAnimationTransitionMigrateEnter alloc] init];
        }
        else if (operation == UINavigationControllerOperationPop &&
                 [self.mf_targetViewKeys count] > 0) {
            return [[MFAnimationTransitionMigrateExit alloc] init];
        }
    }

    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[MFAnimationTransitionMigrateExit class]]) {
        return self.mf_interactivePopTransition;
    }
    else {
        return nil;
    }
}

#pragma mark - UIGestureRecognizer pop handler
- (void)mf_handlePopRecognizer:(UIScreenEdgePanGestureRecognizer*)recognizer {
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // Create a interactive transition and pop the view controller
        self.mf_interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // Update the interactive transition's progress
        [self.mf_interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // Finish or cancel the interactive transition
        if (progress > 0.5) {
            [self.mf_interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.mf_interactivePopTransition cancelInteractiveTransition];
        }
        
        self.mf_interactivePopTransition = nil;
    }
    
}

@end
