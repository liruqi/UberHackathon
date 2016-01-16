//
//  MCEntryFormController.m
//  MCAlbum
//
//  Created by lzw on 15/4/29.
//  Copyright (c) 2015年 lzw. All rights reserved.
//

#import "LZEntryFormController.h"
#import "LZEntryForm.h"
#import <AVOSCloud/AVOSCloud.h>
#import "AVUser+MCCustomUser.h"
#import "AppDelegate.h"

@interface LZEntryFormController()

@property (nonatomic,strong) FXFormController *formController;

@end

@implementation LZEntryFormController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableViewStyle=UITableViewStyleGrouped;
        self.title=@"登录";
    }
    return self;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    self.formController=[[FXFormController alloc] init];
    self.formController.tableView=self.tableView;
    self.formController.form=[[LZEntryForm alloc] init];
}

-(void)submitLogin:(UITableViewCell<FXFormFieldCell> *)cell{
    LZLoginForm *loginForm=cell.field.form;
    WEAKSELF
    [AVUser logInWithUsernameInBackground:loginForm.username password:loginForm.password block:^(AVUser *user, NSError *error) {
        if([weakSelf filterError:error]){
            [weakSelf toMainVC];
        }
    }];
}

-(void)submitRegister:(UITableViewCell<FXFormFieldCell> *)cell{
    LZRegisterForm *registerForm=cell.field.form;
    if(registerForm.username.length>0 && registerForm.password.length>0
       && registerForm.avatar!=nil){
        UIImage *avatarImage=[[self class] roundImage:registerForm.avatar toSize:CGSizeMake(200, 200) radius:10];
        AVFile *avatar=[AVFile fileWithData:UIImagePNGRepresentation(avatarImage)];
        WEAKSELF
        [avatar saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if([weakSelf filterError:error]){
                AVUser *user=[[AVUser alloc] init];
                user.username=registerForm.username;
                user.password=registerForm.password;
                [user setAvatar:avatar];
                [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if([weakSelf filterError:error]){
                        [weakSelf toMainVC];
                    }
                }];
            }
        }];
    } else {
        [self alert:@"请完善资料"];
    }
}

-(void)toMainVC{
//    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
//    [appDelegate toNextController];
}


+(UIImage *)roundImage:(UIImage *) image toSize:(CGSize)size radius: (float) radius;
{
    CGRect rect=CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:radius] addClip];
    [image drawInRect:rect];
    UIImage* rounded = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return rounded;
}

@end
