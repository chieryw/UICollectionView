//
//  CustomReusableView.m
//  TestUICollectionView
//
//  Created by chiery on 14/11/5.
//  Copyright (c) 2014年 qunar. All rights reserved.
//

#import "CustomReusableView.h"

@implementation CustomReusableView

- (void)dealloc
{
    self.title = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = [[UILabel alloc]initWithFrame:self.bounds];
        self.title.backgroundColor = [UIColor clearColor];
        [self addSubview:self.title];
    }
    return self;
}

@end
