//
//  SecondViewController.m
//  MFAnimationTransitionMigratDemo
//
//  Created by Lyman Li on 2017/10/4.
//  Copyright © 2017年 Lyman Li. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "UIViewController+MFAnimationTransitionMigrate.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor blueColor]];
    self.navigationItem.title = @"页面2";
    
    [self initLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    [self mf_registerNavigationControllerDelegate];
}

- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];
    [self mf_removeNavigationControllerDelegate];
}

#pragma mark - init
- (void)initLayout {

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 250, 100, 150)];
    [imageView setImage:[UIImage imageNamed:@"chen"]];
    [self.view addSubview:imageView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(150, 250, 100, 100)];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    UIButton *normalButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [normalButton setTitle:@"跳转页面3" forState:UIControlStateNormal];
    [normalButton setBackgroundColor:[UIColor blackColor]];
    [normalButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:normalButton];
    
    [self mf_setMigrateSourceView:imageView withTag:@"imageView"];
    [self mf_setMigrateSourceView:view withTag:@"view"];
}

#pragma mark - action
- (void)onClick:(id)sender {

    [self.navigationController pushViewController:[[ThirdViewController alloc] init] animated:YES];
}

@end
