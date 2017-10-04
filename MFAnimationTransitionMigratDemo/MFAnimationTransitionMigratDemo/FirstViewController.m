//
//  FirstViewController.m
//  MFAnimationTransitionMigratDemo
//
//  Created by Lyman Li on 2017/10/4.
//  Copyright © 2017年 Lyman Li. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "TableViewController.h"
#import "CollectionViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.title = @"页面1";
    
    [self initLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - init
- (void)initLayout {

    UIButton *normalButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 200, 50)];
    [normalButton setTitle:@"普通跳转" forState:UIControlStateNormal];
    [normalButton setBackgroundColor:[UIColor blueColor]];
    [normalButton addTarget:self action:@selector(onNormalButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:normalButton];
    
    UIButton *tableViewButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 200, 50)];
    [tableViewButton setTitle:@"TableView跳转" forState:UIControlStateNormal];
    [tableViewButton setBackgroundColor:[UIColor blueColor]];
    [tableViewButton addTarget:self action:@selector(onTableViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tableViewButton];
    
    UIButton *collectionViewButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, 200, 50)];
    [collectionViewButton setTitle:@"CollectionView跳转" forState:UIControlStateNormal];
    [collectionViewButton setBackgroundColor:[UIColor blueColor]];
    [collectionViewButton addTarget:self action:@selector(onCollectionViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectionViewButton];
}

#pragma mark - action
- (void)onNormalButtonClick:(id)sender {

    [self.navigationController pushViewController:[[SecondViewController alloc] init] animated:YES];
}

- (void)onTableViewButtonClick:(id)sender {
    
    [self.navigationController pushViewController:[[TableViewController alloc] init] animated:YES];
}

- (void)onCollectionViewButtonClick:(id)sender {

    [self.navigationController pushViewController:[[CollectionViewController alloc] init] animated:YES];
}

@end
