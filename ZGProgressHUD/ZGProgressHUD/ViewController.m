//
//  ViewController.m
//  ZGProgressHUD
//
//  Created by 徐宗根 on 16/12/3.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import "ViewController.h"
#import "ZGProgressHUD.h"
#import "ZGProgressHUD2.h"
#import "ZGExampleController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Example:Loading
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.tag = 10;
    btn1.frame = CGRectMake(50, 100, 120, 60);
    [btn1 setTitle:@"网络加载样例" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 addTarget:self action:@selector(didTouchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.tag = 20;
    btn2.frame = CGRectMake(CGRectGetMaxX(btn1.frame) + 20, 100, 120, 60);
    [btn2 setTitle:@"toast样例" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor purpleColor];
    [btn2 addTarget:self action:@selector(didTouchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.tag = 30;
    btn3.frame = CGRectMake(btn1.frame.origin.x, 200, 120, 60);
    [btn3 setTitle:@"实例方法样例" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor grayColor];
    [btn3 addTarget:self action:@selector(didTouchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    

    
}

- (void)didTouchButton:(UIButton *)btn
{
    if (btn.tag == 10) {
        [self loadData2];
    }else if(btn.tag == 20){
            [ZGProgressHUD showInView:self.view message:@"最大输入字数不能超过140~" mode:ZGProgressHUDModeToast];
    }else if (btn.tag == 30){
        ZGExampleController *vc = [[ZGExampleController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)loadData
{
    [ZGProgressHUD showInView:self.view message:@"加载中..." mode:ZGProgressHUDModeIndeterminate];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (1) {
       
            [ZGProgressHUD showInView:self.view message:@"网络无连接" mode:ZGProgressHUDModeToast];
        }
    });
}

- (void)loadData2
{
    [ZGProgressHUD2 showInView:self.view message:@"加载中..." mode:ZGProgressHUD2Mode_indeterminate];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 8*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (1) {
            
            [ZGProgressHUD2 showInView:self.view message:@"网络无连接" mode:ZGProgressHUD2Mode_toast];
        }
    });
}


@end
