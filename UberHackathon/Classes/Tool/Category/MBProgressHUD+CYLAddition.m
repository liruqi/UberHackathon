//
//  MBProgressHUD+CYLAddition.m
//  UberHackathon
//
//  Created by 陈宜龙 on 16/1/16.
//  Copyright © 2016年 微博@iOS程序犭袁. All rights reserved.
//

#import "MBProgressHUD+CYLAddition.h"

@implementation UIViewController (CYLAddition)

- (void)alert:(NSString*)text {
    [MBProgressHUD showText:text];
}

- (BOOL)alertError:(NSError *)error {
    if (error) {
        NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), error.description);
//        [AVAnalytics event:@"Alert Error" attributes:@{@"desc": error.description}];
    }
    if (error) {
//        if (error.code == kAVIMErrorConnectionLost) {
//            [self alert:@"未能连接聊天服务"];
//        }
//        else
            if ([error.domain isEqualToString:NSURLErrorDomain]) {
            [self alert:@"网络连接发生错误"];
        }
        else {
#ifndef DEBUG
            [self alert:[NSString stringWithFormat:@"%@", error]];
#else
            NSString *info = error.localizedDescription;
            [self alert:info ? info : [NSString stringWithFormat:@"%@", error]];
#endif
        }
        return YES;
    }
    return NO;
}

- (BOOL)filterError:(NSError *)error {
    return [self alertError:error] == NO;
}

- (void)showErrorAlert:(NSString *)text {
    [MBProgressHUD showError:text];
}

- (void)showSuccessAlert:(NSString *)text {
    [MBProgressHUD showSuccess:text];
}

- (void)toast:(NSString *)text duration:(NSTimeInterval)duration {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    //    hud.labelText=text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    hud.detailsLabelText = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:duration];
}

-(void)showNetworkIndicator{
    UIApplication *app=[UIApplication sharedApplication];
    app.networkActivityIndicatorVisible=YES;
}

- (void)hideNetworkIndicator{
    UIApplication *app=[UIApplication sharedApplication];
    app.networkActivityIndicatorVisible=NO;
}

- (void)showProgress {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)hideProgress {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)showHUDText:(NSString*)text{
    [self toast:text];
}

- (void)toast:(NSString *)text {
    [self toast:text duration:2];
}

@end
