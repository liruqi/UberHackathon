//
//  MyTripViewController.m
//  UberHackathon
//
//  Created by 陈宜龙 on 16/1/17.
//  Copyright © 2016年 微博@iOS程序犭袁. All rights reserved.
//

#import "MyTripViewController.h"
#import "TripCell.h"

@interface MyTripViewController ()

@end
@implementation MyTripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"行程" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    imageView.image = image;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    [self.navigationItem setRightBarButtonItem:cancelBtn];
    
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - UITableViewDelegate

//- (void)tableView:(UITableView *)tableView
//didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    <#statements#>
//}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    TripCell *cell = [TripCell cellWithTableView:tableView];
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    
//    [self configureCell:cell forRowAtIndexPath:indexPath];
//    
//    return cell;
//}
//
//- (void)configureCell:(UITableViewCell *)cell
//    forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    <#statements#>
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[self class] dequeueOrCreateCellByTableView:tableView];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

+ (void)registerCellToTableView:(UITableView *)tableView {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:[[self class] reuseIdentifier]];
}

+ (UITableViewCell *)dequeueOrCreateCellByTableView:(UITableView *)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[[self class] reuseIdentifier]];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[self class] reuseIdentifier]];
        if (cell == nil) {
            [[self class] registerCellToTableView:tableView];
            return [self dequeueOrCreateCellByTableView:tableView];
        }
    }
    return cell;
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
