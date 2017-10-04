//
//  CollectionViewController.m
//  MFAnimationTransitionMigratDemo
//
//  Created by Lyman Li on 2017/10/4.
//  Copyright © 2017年 Lyman Li. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "UIViewController+MFAnimationTransitionMigrate.h"
#import "ThirdViewController.h"

@interface CollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"CollectionView页面";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self initCollectView];
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
- (void) initCollectView {
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[self.view bounds] collectionViewLayout:[self createLayout]];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    [self.view addSubview:self.collectionView];
    
}

- (UICollectionViewLayout *)createLayout {
    
    //创建流水布局
    UICollectionViewFlowLayout *layout = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        //设置间距
        NSInteger margin = 10;
        layout.minimumInteritemSpacing = margin;
        layout.minimumInteritemSpacing = margin;
        
        //设置item尺寸
        CGFloat itemW = ([self.view bounds].size.width - (3 + 1) * margin) / 3;
        CGFloat itemH = itemW;
        layout.itemSize = CGSizeMake(itemW, itemH);
        
        layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
        
        // 设置水平滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        layout;
    });
    
    return layout;
}

#pragma mark - collectionView dataSource and delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 30;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [self mf_setMigrateSourceView:cell.image withTag:@"imageView"];
    [self mf_setMigrateSourceView:cell.view withTag:@"view"];
    
    [self.navigationController pushViewController:[[ThirdViewController alloc] init] animated:YES];
}


@end
