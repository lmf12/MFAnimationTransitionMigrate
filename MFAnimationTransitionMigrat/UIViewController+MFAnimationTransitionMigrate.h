//
//  UIViewController+AnimationTransitionMigrate.h
//  testCollectionView
//
//  Created by Lyman Li on 2017/10/3.
//  Copyright © 2017年 Lyman Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MFAnimationTransitionMigrate)

@property (nonatomic, strong) NSMutableDictionary *mf_sourceViewKeys;

@property (nonatomic, strong) NSMutableDictionary *mf_targetViewKeys;


- (void)mf_setMigrateTargetView:(UIView *)view withTag:(NSString *)tag;

- (void)mf_setMigrateSourceView:(UIView *)view withTag:(NSString *)tag;

- (void)mf_registerNavigationControllerDelegate;

- (void)mf_removeNavigationControllerDelegate;

- (void)mf_enablePopInteractivePopTransition;

@end
