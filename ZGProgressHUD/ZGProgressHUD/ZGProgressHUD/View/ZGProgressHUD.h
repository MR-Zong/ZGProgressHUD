//
//  ZGProgressHUD.h
//  ZGProgressHUD
//
//  Created by 徐宗根 on 16/12/3.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZGProgressHUDMode){
    ZGProgressHUDModeIndeterminate, // 一直显示，不消失
    ZGProgressHUDModeText, // 显示文本，1秒后消失
    ZGProgressHUDModeToast, // 跟text一样效果
};

@interface ZGProgressHUD : UIView

#pragma mark - 类方法 简单，方便，但有些场合不适用
+ (void)showInView:(UIView *)view message:(NSString *)message mode:(ZGProgressHUDMode)mode;
+ (void)dismiss;

#pragma mark - 对象方法 稍微不方便 ，适用所有场合
/** 多个progressHud 要同时存在一个界面时候（最常见是，scrollView 水平多页）
 * 就需要 每个控制器，自己 alloc init 一个 ZGProgressHUD
 * 让他们互相独立，互不干扰
 */
- (void)showInView:(UIView *)view message:(NSString *)message mode:(ZGProgressHUDMode)mode;
- (void)dismiss;


@end
