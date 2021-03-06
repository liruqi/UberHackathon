//
//  AppDelegate.m
//  CYLCustomTabBarDemo
//
//  Created by 微博@iOS程序犭袁 (http://weibo.com/luohanchenyilong/) on 10/20/15.
//  Copyright © 2015 https://github.com/ChenYilong . All rights reserved.
//

@import UberRides;

#import "AppDelegate.h"
#import "CYLTabBarController.h"
#import "LZAlbumVC.h"
#import "UBAttractionsViewController.h"
#import "CYLMessageViewController.h"
#import "CYLMineViewController.h"
#import "CYLSameFityViewController.h"
//========== AVOS ============公众账号的 KKKK
#import <AVOSCloud/AVOSCloud.h>
static NSString *const AVOS_APP_ID = @"0y463z4tk9wk4zbtkq4qn21kshdm9zetj8mkouiqkaoovn4e";
static NSString *const AVOS_APP_KEY = @"j9de7xoza1gbvkbp0b6qudz10s9lkwsxqll2nvwrjfty3a58";
#import "ViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic) CYLTabBarController *tabBarController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[RidesClient sharedInstance] configureClientID:@"Gg8KD0ik3y5JKdRtB4HModzlIJA_hZ0s"];
    
    //========== AVOS ============
    
    //设置AVOSCloud
    [AVOSCloud setApplicationId:AVOS_APP_ID
                      clientKey:AVOS_APP_KEY];
    //希望能提供更详细的日志信息，打开日志的方式是在 AVOSCloud 初始化语句之后加上下面这句：
    
#ifndef __OPTIMIZE__
    [AVOSCloud setAllLogsEnabled:YES];
#endif

    // 设置主窗口,并设置跟控制器
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    // Applications are expected to have a root view controller at the end of application launch
    self.window.rootViewController = [[UIViewController alloc] init];
    [self.window makeKeyAndVisible];

    if ([AVUser currentUser]) {
        [self toMain];
    } else {
        [self toLogin];
    }
    return YES;
}

- (void)toMain {
    [self setupViewControllers];
    [self customizeInterface];
    self.window.rootViewController = self.tabBarController;
}

- (void)toLogin {
    ViewController *loginViewController = [[ViewController alloc] init];
    loginViewController.completionBlock = ^ {
        [self toMain];
    };
    [self.window setRootViewController:loginViewController];
}

- (void)setupViewControllers {
    UBAttractionsViewController *firstViewController = [[UBAttractionsViewController alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    LZAlbumVC *secondViewController = [[LZAlbumVC alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    CYLMineViewController *fourthViewController = [[CYLMineViewController alloc] init];
    UIViewController *fourthNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:tabBarController];
    
    [tabBarController setViewControllers:@[
                                           firstNavigationController,
                                           secondNavigationController,
                                           fourthNavigationController
                                           ]];
    self.tabBarController = tabBarController;
}

/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
 */
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"home_normal",
                            CYLTabBarItemSelectedImage : @"home_highlight",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"发现",
                            CYLTabBarItemImage : @"mycity_normal",
                            CYLTabBarItemSelectedImage : @"mycity_highlight",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"account_normal",
                            CYLTabBarItemSelectedImage : @"account_highlight"
                            };
    NSArray *tabBarItemsAttributes = @[ dict1, dict2,  dict4 ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

- (void)customizeInterface {
    [self setUpNavigationBarAppearance];
    [self setUpTabBarItemTextAttributes];
}

/**
 *  设置navigationBar样式
 */
- (void)setUpNavigationBarAppearance {

    
    
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    if ([UINavigationBar conformsToProtocol:@protocol(UIAppearanceContainer)]) {
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor]}];
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:(51) / 255.f green:(171) / 255.f blue:(160) / 255.f alpha:1.f]];
        [[UINavigationBar appearance] setTranslucent:NO];
    }
}

/**
 *  tabBarItem 的选中和不选中文字属性
 */
- (void)setUpTabBarItemTextAttributes {
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 设置背景图片
//    UITabBar *tabBarAppearance = [UITabBar appearance];
//    [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background_os7"]];
}
@end
