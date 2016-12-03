//
//  ViewController.m
//  ZGProgressHUD
//
//  Created by 徐宗根 on 16/12/3.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import "ViewController.h"
#import "ZGProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Example:Loading
//    [ZGProgressHUD showInView:self.view message:@"最大输入字数不能超过140~" mode:ZGProgressHUDModeText];
    
}

- (void)example
{
    [ZGProgressHUD showInView:self.view message:@"最大输入字数不能超过140~" mode:ZGProgressHUDModeToast];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self example];
}

@end
