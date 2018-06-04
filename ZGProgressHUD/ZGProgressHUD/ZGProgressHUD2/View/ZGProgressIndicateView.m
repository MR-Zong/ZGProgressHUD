//
//  ZGProgressIndicateView.m
//  ZGProgressHUD
//
//  Created by 徐宗根 on 2018/6/4.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGProgressIndicateView.h"

// disk 圆盘
@interface ZGProgressDiskView : UIView

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat rotationRate;

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;
- (void)startAnimating;
- (void)stopAnimating;


@end


@implementation ZGProgressDiskView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color
{
    if (self = [super initWithFrame:frame]) {
        
        CAShapeLayer *layer = [CAShapeLayer new];
        layer.lineWidth = 10;
        //圆环的颜色
        layer.strokeColor = color.CGColor;
        //背景填充色
        layer.fillColor = [UIColor clearColor].CGColor;
        //设置半径
        CGFloat radius = self.bounds.size.width/2.0;
        //按照顺时针方向
        BOOL clockWise = YES;
        //初始化一个路径
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.center radius:radius startAngle:(1.25*M_PI) endAngle:1.75f*M_PI clockwise:clockWise];
        layer.path = [path CGPath];
        [self.layer addSublayer:layer];
    }
    return self;
}


- (void)startAnimating
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat: M_PI *2];
    animation.duration = 1.0/self.rotationRate;
    animation.autoreverses = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [self.layer addAnimation:animation forKey:nil];
}

- (void)stopAnimating
{
    ;
}

@end



@interface ZGProgressIndicateView ()

@property (nonatomic, strong) ZGProgressDiskView *whiteDisk;
@property (nonatomic, strong) ZGProgressDiskView *redDisk;
@property (nonatomic, strong) ZGProgressDiskView *orangeDisk;
@property (nonatomic, strong) ZGProgressDiskView *blueDisk;

@end


@implementation ZGProgressIndicateView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor darkGrayColor];
        
        _blueDisk = [[ZGProgressDiskView alloc] initWithFrame:self.bounds color:[UIColor colorWithRed:9/255.0 green:69/255.0 blue:255/255 alpha:1]];
        _blueDisk.rotationRate = 0.2;
        [self addSubview:_blueDisk];
    
        _orangeDisk = [[ZGProgressDiskView alloc] initWithFrame:self.bounds color:[UIColor colorWithRed:253/255.0 green:135/255.0 blue:9/255.0 alpha:1]];
        _orangeDisk.rotationRate = 0.4;
        [self addSubview:_orangeDisk];

        _redDisk = [[ZGProgressDiskView alloc] initWithFrame:self.bounds color:[UIColor colorWithRed:196/255.0 green:27/255.0 blue:1/255.0 alpha:1]];
        _redDisk.rotationRate = 0.5;
        [self addSubview:_redDisk];
        
        _whiteDisk = [[ZGProgressDiskView alloc] initWithFrame:self.bounds color:[UIColor whiteColor]];
        _whiteDisk.rotationRate = 0.6;
        [self addSubview:_whiteDisk];
    }
    
    return self;
}


- (void)startAnimating
{
    [self.whiteDisk startAnimating];
    [self.redDisk startAnimating];
    [self.orangeDisk startAnimating];
    [self.blueDisk startAnimating];
}

- (void)stopAnimating
{
    [self.whiteDisk stopAnimating];
    [self.redDisk stopAnimating];
    [self.orangeDisk stopAnimating];
    [self.blueDisk stopAnimating];
}

@end
