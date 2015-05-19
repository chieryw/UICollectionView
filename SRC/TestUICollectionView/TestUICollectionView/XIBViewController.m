//
//  XIBViewController.m
//  TestUICollectionView
//
//  Created by chiery on 15/5/19.
//  Copyright (c) 2015年 qunar. All rights reserved.
//

#import "XIBViewController.h"
#import "XIBCollectionViewCell.h"

@interface XIBViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation XIBViewController

- (void)dealloc {

    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupCollectionView];
    
}


- (void)setupCollectionView {

    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.collectionViewLayout = [self setCollectionFlowLayout];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"XIBCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"XIBCollectionViewCell"];

}

// 初始化UICollectionViewFlowLayout
- (UICollectionViewFlowLayout *)setCollectionFlowLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置左右之间的间隔
    layout.minimumInteritemSpacing = 1;
    // 设置上下之间的间隔
    layout.minimumLineSpacing = 5;
    
    return layout;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifierCell = @"XIBCollectionViewCell";
    XIBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierCell forIndexPath:indexPath];
    
    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake((CGRectGetWidth(self.view.frame) - 2)/3, 168);
    
}

@end
