//
//  ViewController.m
//  TestUICollectionView
//
//  Created by chiery on 14/11/5.
//  Copyright (c) 2014年 NONE. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"
#import "XIBViewController.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ViewController

- (void)dealloc {

    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    
}

- (void)viewDidLoad {

    [self setupTableView];
    
}

- (void)setupTableView {

    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = indexPath.row ==0?@"demo描述":@"XIB描述";
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row == 0) {
        DemoViewController *demoVC = [DemoViewController new];
        [self.navigationController pushViewController:demoVC animated:YES];
    }
    else {
    
        XIBViewController *XIBVC = [XIBViewController new];
        [self.navigationController pushViewController:XIBVC animated:YES];
    
    }
    
}

@end
