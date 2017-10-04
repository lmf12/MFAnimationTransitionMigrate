//
//  MFAnimationTransitionMigrateEnter.m
//  testCollectionView
//
//  Created by Lyman Li on 2017/10/3.
//  Copyright © 2017年 Lyman Li. All rights reserved.
//

#import "MFAnimationTransitionMigrateEnter.h"
#import "UIViewController+MFAnimationTransitionMigrate.h"


@implementation MFAnimationTransitionMigrateEnter

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // 获取需要移动的view列表，和移动后的view列表
    NSMutableArray *sourceViewList = [[NSMutableArray alloc] init];
    NSMutableArray *targetViewList = [[NSMutableArray alloc] init];
    
    NSArray *keys = [[fromViewController mf_sourceViewKeys] allKeys];
    for (NSString *key in keys) {
        if ([[toViewController mf_targetViewKeys] objectForKey:key]) {
            [sourceViewList addObject:[[fromViewController mf_sourceViewKeys] objectForKey:key]];
            [targetViewList addObject:[[toViewController mf_targetViewKeys] objectForKey:key]];
        }
    }
    
    
    // 获取快照列表
    NSMutableArray *snapshotViewList = [[NSMutableArray alloc] init];
    for (UIView * sourceView in sourceViewList) {
        UIView *snapshotView = [sourceView snapshotViewAfterScreenUpdates:NO];
        snapshotView.frame = [containerView convertRect:sourceView.frame fromView:sourceView.superview];
        [snapshotViewList addObject:snapshotView];
    }
    
    // 设置动画开始的初始状态
    for (UIView * sourceView in sourceViewList) {
        sourceView.hidden = YES;
    }
    for (UIView * targetView in targetViewList) {
        targetView.hidden = YES;
    }
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
    
    [containerView addSubview:toViewController.view];
    for (UIView * viewSnapshot in snapshotViewList) {
        [containerView addSubview:viewSnapshot];
    }
    
    // 开始动画
    [UIView animateWithDuration:duration animations:^{
        
        toViewController.view.alpha = 1.0;
        
        for (int index = 0; index < targetViewList.count; ++index) {
            UIView *targetView = targetViewList[index];
            UIView *viewSnapshot = snapshotViewList[index];
            
            CGRect frame = [containerView convertRect:targetView.frame fromView:targetView.superview];
            viewSnapshot.frame = frame;
        }
        
    } completion:^(BOOL finished) {
        for (UIView * sourceView in sourceViewList) {
            sourceView.hidden = NO;
        }
        for (UIView * targetView in targetViewList) {
            targetView.hidden = NO;
        }
        for (UIView * viewSnapshot in snapshotViewList) {
            [viewSnapshot removeFromSuperview];
        }
        
        // 声明动画结束
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
