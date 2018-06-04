//
//  ZGProgressHUD2.m
//  ZGProgressHUD
//
//  Created by 徐宗根 on 2018/6/4.
//  Copyright © 2018年 XuZonggen. All rights reserved.
//

#import "ZGProgressHUD2.h"
#import "ZGProgressIndicateView.h"

ZGProgressHUD2 *_zgProgressHUD2_;

@interface ZGProgressHUD2ContentView : UIView

+ (instancetype)contentViewWithView:(UIView *)view message:(NSString *)message mode:(ZGProgressHUD2Mode)mode;
@end

@implementation ZGProgressHUD2ContentView

+ (instancetype)contentViewWithView:(UIView *)view message:(NSString *)message mode:(ZGProgressHUD2Mode)mode
{
    ZGProgressHUD2ContentView *contentView = [[ZGProgressHUD2ContentView alloc] init];
    CGFloat contentViewWidth = view.bounds.size.width;
    CGFloat contentViewHeight = 0;
    
    // 高斯模糊背景
    UIBlurEffect *ef = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *ve = [[UIVisualEffectView alloc] initWithEffect:ef];
    ve.frame = CGRectMake(0, 0, 200, 200);
    [contentView addSubview:ve];
    
    if (mode == ZGProgressHUD2Mode_indeterminate) {
        
        contentViewWidth = 100;
        contentViewHeight = contentViewWidth;
        
        if (message.length > 0) {

            ZGProgressIndicateView *indicator = [[ZGProgressIndicateView alloc] initWithFrame:CGRectMake((contentViewWidth - 60) / 2.0, 10, 60, 60)];
            [indicator startAnimating];
            [contentView addSubview:indicator];

            UILabel *textLabel = [[UILabel alloc] init];
            textLabel.text = message;
            textLabel.textColor = [UIColor whiteColor];
            textLabel.textAlignment = NSTextAlignmentCenter;
            textLabel.font = [UIFont systemFontOfSize:14];
            textLabel.frame = CGRectMake(0,60 + 10,contentViewWidth,21);
            [contentView addSubview:textLabel];
        }else {
            ZGProgressIndicateView *indicator = [[ZGProgressIndicateView alloc] initWithFrame:CGRectMake((contentViewWidth - 60) / 2.0, (contentViewHeight - 60) / 2.0, 60, 60)];
            [indicator startAnimating];
            [contentView addSubview:indicator];

        }
    }else if (mode == ZGProgressHUD2Mode_text || mode == ZGProgressHUD2Mode_toast){
        if (message.length > 0) {
            UILabel *textLabel = [[UILabel alloc] init];
            textLabel.text = message;
            textLabel.textColor = [UIColor whiteColor];
            textLabel.textAlignment = NSTextAlignmentCenter;
            textLabel.font = [UIFont systemFontOfSize:14];
            CGFloat textLabelHeight = 21;
            CGFloat textLabelWidth = [message boundingRectWithSize:CGSizeMake(view.bounds.size.width, textLabelHeight) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :textLabel.font} context:nil].size.width;
            
            if (textLabelWidth >= contentViewWidth) {
                textLabelWidth = contentViewWidth - 2*20;
            }
            contentViewWidth = textLabelWidth + 2*15;
            contentViewHeight = textLabelHeight + 2*10;
            
            textLabel.frame = CGRectMake((contentViewWidth - textLabelWidth) / 2.0, (contentViewHeight - textLabelHeight) / 2.0, textLabelWidth, textLabelHeight);
            [contentView addSubview:textLabel];
        }
    }
    
    contentView.backgroundColor = [UIColor blackColor];
    contentView.layer.cornerRadius = 10;
    contentView.layer.masksToBounds = YES;
    contentView.frame = CGRectMake((view.frame.size.width - contentViewWidth) / 2.0, (view.frame.size.height - contentViewHeight) / 2.0, contentViewWidth, contentViewHeight);
    return contentView;
}

@end

@interface ZGProgressHUD2 ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) ZGProgressHUD2ContentView *contentView;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) ZGProgressHUD2Mode mode;

@end

@implementation ZGProgressHUD2

+ (instancetype)progressHUDWithView:(UIView *)view message:(NSString *)message mode:(ZGProgressHUD2Mode)mode
{
    ZGProgressHUD2 *progressHUD = [[ZGProgressHUD2 alloc] initWithFrame:view.bounds];
    progressHUD.message = message;
    progressHUD.mode = mode;
    return progressHUD;
}


+ (void)showInView:(UIView *)view message:(NSString *)message mode:(ZGProgressHUD2Mode)mode
{
    if (!view) {
        return;
    }
    
    if (_zgProgressHUD2_.window) {
        [self dismiss];
    }
    _zgProgressHUD2_ = [ZGProgressHUD2 progressHUDWithView:view message:message mode:mode];
    [view addSubview:_zgProgressHUD2_];
}

+ (void)dismiss
{
    if (!_zgProgressHUD2_.window) {
        return;
    }
    
    [_zgProgressHUD2_ removeFromSuperview];
    _zgProgressHUD2_ = nil;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _maskView = [[UIView alloc] initWithFrame:self.bounds];
    _maskView.backgroundColor = [UIColor clearColor];
    [self addSubview:_maskView];
}


#pragma mark - 对象方法
- (void)showInView:(UIView *)view message:(NSString *)message mode:(ZGProgressHUD2Mode)mode
{
    if (!view) {
        return;
    }
    
    if (self.window) {
        [self dismiss];
    }
    
    [self removeAllSubviews];
    [self  setupViews];
    
    self.frame = view.bounds;
    self.message = message;
    self.mode = mode;
    
    [view addSubview:self];
}

- (void)dismiss
{
    if (!self.window) {
        return;
    }
    
    [self removeFromSuperview];
    
}

- (void)removeAllSubviews
{
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}

#pragma mark - setter
- (void)setMode:(ZGProgressHUD2Mode)mode
{
    _mode = mode;
    
    self.contentView = [ZGProgressHUD2ContentView contentViewWithView:self message:self.message mode:mode];
    [self addSubview:self.contentView];
    
    if (mode == ZGProgressHUD2Mode_toast || mode == ZGProgressHUD2Mode_text) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                self.contentView.alpha = 0;
            }completion:^(BOOL finished) {
                if (finished) {
                    [self dismiss];
                }
            }];
        });
    }
}

@end
