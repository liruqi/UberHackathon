//
//  CYLHomeViewController.m
//  CYLCustomTabBarDemo
//
//  Created by 微博@iOS程序犭袁 (http://weibo.com/luohanchenyilong/) on 10/20/15.
//  Copyright © 2015 https://github.com/ChenYilong . All rights reserved.
//

#import "CYLHomeViewController.h"
#import "CYLMultipleFilterController.h"
#import "CYLFilterParamsTool.h"
#import "AppDelegate.h"

@interface CYLHomeViewController ()<FilterControllerDelegate>

@property (nonatomic, strong) CYLMultipleFilterController *filterController;
@property (nonatomic, strong) CYLFilterParamsTool         *filterParamsTool;

@end

@implementation CYLHomeViewController

#pragma mark - View lifecycle

/**
 *  懒加载filterController
 *
 *  @return filterController
 */
- (CYLMultipleFilterController *)filterController {
    if (_filterController == nil) {
        _filterController = [[CYLMultipleFilterController alloc] initWithNibName:@"FilterBaseController" bundle:nil];
        _filterController.delegate = self;
    }
    return _filterController;
}
- (void)rightBarButtonClicked:(id)sender {
    self.filterParamsTool = [[CYLFilterParamsTool alloc] init];
    [NSKeyedArchiver archiveRootObject:self.filterParamsTool toFile:self.filterParamsTool.filename];
    [self initLeftBarButtonItem];
    [self filterControllerDidCompleted:nil];
}
- (void)leftBarButtonClicked:(id)sender {
    [_filterController refreshFilterParams];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.filterController showInView:delegate.window];
}

/**
 * 初始化leftNavgationItem
 */
- (void)initLeftBarButtonItem {
    self.filterParamsTool = nil;
    BOOL shouldShowModified = [self.filterParamsTool.filterParamsDictionary[kMultipleFilterSettingModified] boolValue];
    UIImage *image;
    if (shouldShowModified) {
        image =
        [[UIImage
          imageNamed:@"navigationbar_leftBarButtonItem_itis_multiple_choice_filter_params_modified"]
         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    } else {
        image =
        [[UIImage
          imageNamed:@"navigationbar_leftBarButtonItem_itis_multiple_choice_filter_params_normal"]
         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonClicked:)];
    self.navigationItem.leftBarButtonItem = item;
}

#pragma mark - 🔌 FilterControllerDelegate Method

- (void)filterControllerDidCompleted:(FilterBaseController *)controller {
    self.filterParamsTool = nil;
    [self initLeftBarButtonItem];
    self.filterParamsTool = nil;
    NSString *message =  @"展示全部";
    NSString *areaMessage = @"🔵不筛选地区";
    NSString *foodMessage = @"🔴不筛选食物";
    NSString *area = self.filterParamsTool.filterParamsContentDictionary[@"Hospital"];
    id dicValue = area;
    if ((dicValue) && (dicValue != [NSNull null])) {
        areaMessage = [NSString stringWithFormat:@"🔵筛选地区:%@", area];;
    }
    NSMutableArray *messageArray = self.filterParamsTool.filterParamsContentDictionary[@"skilled"];
    if (self.filterParamsTool.filterParamsContentDictionary[@"skilled"] && self.filterParamsTool.filterParamsContentDictionary[@"skilled"] != [NSNull null]) {
        __weak __typeof(messageArray) weakMessageArray = messageArray;
        [messageArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            obj =  [@"🔴" stringByAppendingString:obj];
            [weakMessageArray replaceObjectAtIndex:idx withObject:obj];
        }];
        NSString *skilled = [messageArray componentsJoinedByString:@"\n"];
        if (skilled.length >0) {
            foodMessage = skilled;
        }
    }
    message = [NSString stringWithFormat:@"%@\n%@", areaMessage, foodMessage];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    NSUInteger delaySeconds = 1;
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    [self initLeftBarButtonItem];

   // [self.navigationController.tabBarItem setBadgeValue:@"3"];
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark - Methods

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ Controller Cell %ld", self.title, (long)indexPath.row]];
}

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%ld", indexPath.row+1]];
}
@end
