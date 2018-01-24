//
//  ZGTestView.m
//  ZGProgressHUD
//
//  Created by 徐宗根 on 2018/1/24.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGExampleObjectView.h"
#import "ZGProgressHUD.h"

@interface ZGExampleObjectView ()

@property (nonatomic, strong) ZGProgressHUD *progressHud;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIView *tv;


@end

@implementation ZGExampleObjectView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(80, 360, 180, 60);
        [_btn setTitle:@"点击，模拟网络加载" forState:UIControlStateNormal];
        _btn.backgroundColor = [UIColor blackColor];
        [_btn addTarget:self action:@selector(didTouchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn];
        
        _progressHud = [[ZGProgressHUD alloc] init];
        
        
        [self loadData];
    }
    return self;
}


- (void)didTouchButton:(UIButton *)btn
{
    [self loadData];
}



- (void)loadData
{
    [self.progressHud showInView:self message:@"加载中..." mode:ZGProgressHUDModeIndeterminate];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (1) {
            
            [self.progressHud showInView:self message:@"网络无连接" mode:ZGProgressHUDModeText];
        }
    });
}


@end
