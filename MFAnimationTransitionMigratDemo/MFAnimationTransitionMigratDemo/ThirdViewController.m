//
//  ThirdViewController.m
//  MFAnimationTransitionMigratDemo
//
//  Created by Lyman Li on 2017/10/4.
//  Copyright © 2017年 Lyman Li. All rights reserved.
//

#import "ThirdViewController.h"
#import "UIViewController+MFAnimationTransitionMigrate.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.title = @"页面3";
    
    [self initLayout];
    
    [self mf_enablePopInteractivePopTransition];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self mf_registerNavigationControllerDelegate];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self mf_removeNavigationControllerDelegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - init
- (void)initLayout {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, 200, 300)];
    [imageView setImage:[UIImage imageNamed:@"chen"]];
    [self.view addSubview:imageView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 400, 250, 100)];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    [self mf_setMigrateTargetView:imageView withTag:@"imageView"];
    [self mf_setMigrateTargetView:view withTag:@"view"];
}


@end
