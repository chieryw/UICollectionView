//
//  ViewController.m
//  TestUICollectionView
//
//  Created by chiery on 14/11/5.
//  Copyright (c) 2014年 NONE. All rights reserved.
//

#import "ViewController.h"
#import "CustomReusableView.h"
#import "UIScrollView+PullToRefreshCoreText.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
}

@end

@implementation ViewController

- (void)dealloc
{
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    _collectionView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configureDataArray];
    [self initCollectionView];
    [self addReflesh];
}

#pragma mark - 
// 配置基本的信息
- (void)configureDataArray
{
    if (!_dataArray) {
        _dataArray = [@[
                       [UIColor redColor],
                       [UIColor blueColor],
                       [UIColor yellowColor],
                       [UIColor redColor],
                       [UIColor blueColor],
                       [UIColor yellowColor],
                       [UIColor redColor],
                       [UIColor blueColor],
                       [UIColor yellowColor],
                       [UIColor redColor],
                       [UIColor blueColor],
                       [UIColor yellowColor],
                       [UIColor blueColor],
                       [UIColor yellowColor],
                       [UIColor redColor],
                       [UIColor blueColor],
                       [UIColor yellowColor],
                       [UIColor blueColor],
                       [UIColor yellowColor],
                       [UIColor redColor],
                       [UIColor blueColor],
                       [UIColor yellowColor],
                       [UIColor blueColor],
                       [UIColor yellowColor],
                       [UIColor redColor],
                       [UIColor blueColor],
                       [UIColor yellowColor]
                       ] mutableCopy];
    }
}

// 初始化UICollectionViewFlowLayout
- (UICollectionViewFlowLayout *)setCollectionFlowLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置左右之间的间隔
    layout.minimumInteritemSpacing = 0;
    // 设置上下之间的间隔
    layout.minimumLineSpacing = 0;
    
    return layout;
}

// 初始化CollectionView
- (void)initCollectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[self setCollectionFlowLayout]];
        
        // 注册一个自定义的Cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        // 注册一个自定义的Header
        [_collectionView registerClass:[CustomReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        // 注册代理
        _collectionView.delegate = self;
        // 数据来源
        _collectionView.dataSource = self;
        
        _collectionView.scrollEnabled = YES;
        
        _collectionView.backgroundColor = [UIColor colorWithRed:10/255.0 green:100/255.0 blue:18/255.0 alpha:1];
        
        // 添加collectionView
        [self.view addSubview:_collectionView];
    }
}

- (void)addReflesh
{
    if (_collectionView) {
        __weak typeof(self) weakSelf = self;
        [_collectionView addPullToRefreshWithPullText:@"Loading"
                                        pullTextColor:[UIColor blackColor]
                                         pullTextFont:[UIFont systemFontOfSize:20]
                                       refreshingText:@"Finish"
                                  refreshingTextColor:[UIColor redColor]
                                   refreshingTextFont:[UIFont systemFontOfSize:20]
                                               action:^{
                                                   [weakSelf changedDataArray];
                                               }];
    }
}

- (void)changedDataArray
{
    __weak typeof(self) weakSelf = self;
    __weak typeof(_collectionView) weakCollectionView = _collectionView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf->_dataArray addObject:[UIColor blackColor]];
        [strongSelf->_collectionView reloadData];
        [weakCollectionView finishLoading];
    });
}

#pragma mark - UICollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierCell = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierCell forIndexPath:indexPath];
    cell.backgroundColor = _dataArray[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CustomReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    head.title.text = @"这是我实现的CollectionView的Header";
    head.title.textAlignment = NSTextAlignmentCenter;
    return head;
}

#pragma mark - UIColectionViewDelegate method
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld,%ld",(long)indexPath.section,(long)indexPath.row);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(self.view.frame), 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger band = indexPath.row%4;
    switch (band) {
        case 0:
            return CGSizeMake(100, 100);
            break;
        case 1:
            return CGSizeMake(60, 80);
            break;
        case 2:
            return CGSizeMake(100, 120);
            break;
        case 3:
            return CGSizeMake(40,60);
            break;
            
        default:
            break;
    }
    return CGSizeMake(100, 100);
}

@end
