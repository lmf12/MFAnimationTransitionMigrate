//
//  TableViewController.m
//  MFAnimationTransitionMigratDemo
//
//  Created by Lyman Li on 2017/10/4.
//  Copyright © 2017年 Lyman Li. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "ThirdViewController.h"
#import "UIViewController+MFAnimationTransitionMigrate.h"

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"TableView页面";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [self.view addSubview:tableView];
}

#pragma mark - tableview dataSource and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [self mf_setMigrateSourceView:cell.image withTag:@"imageView"];
    [self mf_setMigrateSourceView:cell.view withTag:@"view"];
    
    [self.navigationController pushViewController:[[ThirdViewController alloc] init] animated:YES];
}

@end
