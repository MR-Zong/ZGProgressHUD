//
//  ZGTestController.m
//  ZGProgressHUD
//
//  Created by 徐宗根 on 2018/1/24.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGExampleController.h"
#import "ZGProgressHUD.h"
#import "ZGExampleObjectView.h"

@interface ZGExampleController ()

@property (nonatomic, strong) UIScrollView *sv;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZGExampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _sv.contentSize = CGSizeMake(3*self.view.bounds.size.width, 0);
    _sv.pagingEnabled = YES;
    _sv.backgroundColor = [UIColor yellowColor];
    
    for (int i=0; i<3; i++) {
        ZGExampleObjectView *view = [[ZGExampleObjectView alloc] initWithFrame:CGRectMake(i*_sv.bounds.size.width, 0, _sv.bounds.size.width, _sv.bounds.size.height)];        
        [_sv addSubview:view];
    }
    [self.view addSubview:_sv];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.backgroundColor = [UIColor blackColor];
    _backBtn.frame = CGRectMake(20, 30, 40, 40);
    [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(didBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"这是scrollView,可以水平滑动 -->";
    _titleLabel.frame = CGRectMake(20, 90, 280, 20);
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_titleLabel];
    
    
}

- (void)didBackBtn:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
