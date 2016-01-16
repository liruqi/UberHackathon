//
//  MBProgressHUD+CYLAddition.h
//  UberHackathon
//
//  Created by 陈宜龙 on 16/1/16.
//  Copyright © 2016年 微博@iOS程序犭袁. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface UIViewController (CYLAddition)

- (void)showNetworkIndicator;

- (void)hideNetworkIndicator;

- (void)showProgress;

- (void)hideProgress;

- (void)alert:(NSString *)text;

- (BOOL)alertError:(NSError *)error;

- (BOOL)filterError:(NSError *)error;

- (void)runInMainQueue:(void (^)())queue;

- (void)runInGlobalQueue:(void (^)())queue;

- (void)runAfterSecs:(float)secs block:(void (^)())block;

- (void)showHUDText:(NSString *)text;

- (void)toast:(NSString *)text;

- (void)toast:(NSString *)text duration:(NSTimeInterval)duration;

- (void)showErrorAlert:(NSString *)text;

- (void)showSuccessAlert:(NSString *)text;

@end
