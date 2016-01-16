//
//  version 1.0.0
//
//  Created by 新浪微博：iOS卡卡
//  Copyright (c) 2015年 KK. All rights reserved.
//

#import "MBProgressHUD+KK.h"

// 正常是2秒
#define  kTime   2.0f

@implementation MBProgressHUD (KK)

//---------------------显示成功,几秒后消失------------------------------------
/** 显示成功文字和图片,几秒后消失 */
+ (void)showSuccess:(NSString *)success
{
    [self showText:success icon:@"success.png" view:nil];
}
/** 显示成功文字和图片,几秒后消失(放到指定view中) */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self showText:success icon:@"success.png" view:view];
}

//------------------------显示出错,几秒后消失---------------------------------
/** 显示出错图片和文字,几秒后消失 */
+ (void)showError:(NSString *)error
{
    [self showText:error icon:@"error.png" view:nil];
}
/** 显示出错图片和文字,几秒后消失(放到指定view中) */
+ (void)showError:(NSString *)error toView:(UIView *)view
{
    [self showText:error icon:@"error.png" view:view];
}

//--------------------------显示信息,几秒后消失-------------------------------
/**  只显示文字,几秒后消失 */
+ (void)showText:(NSString *)text
{
    [self showText:text icon:nil view:nil];
}
/**  只显示文字,几秒后消失(放到指定view中) */
+ (void)showText:(NSString *)text view:(UIView *)view
{
    [self showText:text icon:nil view:view];
}

/**  只显示图片,几秒后消失 */
+ (void)showIcon:(NSString *)icon
{
    [self showText:nil icon:icon view:nil];
}
/**  只显示图片,几秒后消失(放到指定view中) */
+ (void)showIcon:(NSString *)icon view:(UIView *)view
{
    [self showText:nil icon:icon view:view];
}

/**  显示文字和图片,几秒后消失 */
+ (void)showText:(NSString *)text icon:(NSString *)icon
{
    [self showText:text icon:icon view:nil];
}
/**  显示文字和图片,几秒后消失(放到指定view中) */
+ (void)showText:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.labelText = text;
    hud.labelFont = [UIFont systemFontOfSize:22];
    hud.minSize = CGSizeMake(160, 160);
    //GCC的C扩充功能Code Block Evaluation，
    //    hud.color = kColorTheme;
    
    // YES代表需要蒙版效果(默认是NO)
//    hud.dimBackground = YES;
    
    // 设置图片
    NSString *imgStr = [NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgStr]];
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 几秒之后再消失
    [hud hide:YES afterDelay:kTime];
}


//*******************************我是快乐的分割线*************************************/
//--------------------------显示HUD-------------------------------
/** 只显示菊花(需要主动让它消失,HUD放在Window中) */
+ (MBProgressHUD *)showHUD
{
    return [self showMessage:nil toView:nil];
}

/** 显示菊花和文字(需要主动让它消失,HUD放在Window中) */
+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

/** 显示菊花和文字(需要主动让它消失，HUD放到指定view中) */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    
    hud.labelFont = [UIFont systemFontOfSize:22];
    hud.minSize = CGSizeMake(160, 160);
//    hud.size = CGSizeMake(100, 100);
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果(默认是NO)
//    hud.dimBackground = YES;

    return hud;
}

//--------------------------隐藏HUD-------------------------------
/** 隐藏HUD(HUD在Window中) */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
/** 隐藏HUD(HUD在指定view中) */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self hideHUDForView:view animated:YES];
}


@end
