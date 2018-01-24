//
//  ZGTestController.m
//  ZGProgressHUD
//
//  Created by 徐宗根 on 2018/1/24.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGTestController.h"
#import "ZGProgressHUD.h"
#import "ZGTestView.h"

@interface ZGTestController ()

@property (nonatomic, strong) UIScrollView *sv;

@end

@implementation ZGTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _sv.contentSize = CGSizeMake(3*self.view.bounds.size.width, 0);
    _sv.pagingEnabled = YES;
    _sv.backgroundColor = [UIColor yellowColor];
    
    for (int i=0; i<3; i++) {
        ZGTestView *view = [[ZGTestView alloc] initWithFrame:CGRectMake(i*_sv.bounds.size.width, 0, _sv.bounds.size.width, _sv.bounds.size.height)];        
        [_sv addSubview:view];
    }
    [self.view addSubview:_sv];
}


@end
