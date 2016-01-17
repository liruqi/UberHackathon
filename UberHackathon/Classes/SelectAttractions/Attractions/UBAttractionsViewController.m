//
//  JBViewController.m
//  JBParallaxTable
//
// The MIT License (MIT)
//
// Copyright (c) 2014 Javier Berlana @jberlana
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "UBAttractionsViewController.h"
#import "CityListViewController.h"
#import "AttractionIntroViewController.h"
#import "UBHViewSpot.h"
// Table cells
#import "JBParallaxCell.h"
#import "MBProgressHUD+CYLAddition.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString* kCITYNAME = @"kCITYNAME";
@interface UBAttractionsViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, CityListDelegate>

@property (nonatomic, strong) NSMutableArray *tableItems;
@property (nonatomic, strong) NSMutableArray *cityImageURLs;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation UBAttractionsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height) style:UITableViewStylePlain];
    //FIXME:why push then pop inset changed because LTNavigationBar ???
    //    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, self.tabBarController.tabBar.frame.size.height + 20, 0)];
    
    // Load the items in the table
    


                      
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self.view addSubview:self.tableView];
    NSString* cityName = [[NSUserDefaults standardUserDefaults] stringForKey:kCITYNAME];
    if (! cityName || cityName.length == 0) {
        cityName = @"北京";
    }
    self.title = cityName;
    [self queryCityWithName:cityName];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换城市" style:UIBarButtonItemStylePlain target:self action:@selector(onChangeCity:)];
    [self.tableView reloadData];
}

/**
 *  lazy load dataSource
 *
 *  @return NSMutableArray
 */
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)queryCityWithName:(NSString *)cityName {
    AVQuery *query = [AVQuery queryWithClassName:@"UBHViewSpot"];
    [query whereKey:@"city" equalTo:cityName];
    query.cachePolicy = kAVCachePolicyNetworkElseCache;
    [MBProgressHUD showHUD];
    NSArray *objects = [query findObjects];
    self.dataSource = (NSMutableArray *)objects;
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
        [objects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UBHViewSpot *viewSpot = obj;
            UIImage *image = [UIImage imageNamed:@"demo_1.jpg"];
            NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@%@", @(__PRETTY_FUNCTION__), @(__LINE__), viewSpot.image, self.cityImageURLs);
            [self.tableItems addObject:image];
            NSURL *url = [NSURL URLWithString:viewSpot.image];
            [self.cityImageURLs addObject:url];
            if (idx == [objects indexOfObject:[objects lastObject]]) {
                [MBProgressHUD hideHUD];
                [self.tableView reloadData];
            }
//        }];
     
    }];
}

/**
 *  lazy load tableItems
 *
 *  @return NSMutableArray
 */
- (NSMutableArray *)tableItems {
    if (_tableItems == nil) {
        _tableItems = [[NSMutableArray alloc] init];
    }
    return _tableItems;
}
/**
 *  lazy load cityImageURLs
 *
 *  @return NSMutableArray
 */
- (NSMutableArray *)cityImageURLs {
    if (_cityImageURLs == nil) {
        _cityImageURLs = [[NSMutableArray alloc] init];
    }
    return _cityImageURLs;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self scrollViewDidScroll:nil];
}

- (void)onChangeCity:(id)sender {
    CityListViewController *cityListVC = [[CityListViewController alloc] init];
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:cityListVC];
    [self.tabBarController presentViewController:naviVC animated:YES completion:nil];
}

- (void)didSelectCityWithName: (NSString*) name {
    self.title = name;
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:kCITYNAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableItems.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AttractionIntroViewController *attractionIntroVC = [[AttractionIntroViewController alloc] init];
    UBHViewSpot *viewSpot  = self.dataSource[indexPath.row];
    [attractionIntroVC setCityName:viewSpot.city];
    [attractionIntroVC setHeaderImage:self.tableItems[indexPath.row]];
    attractionIntroVC.hidesBottomBarWhenPushed = YES;  // This property needs to be set before pushing viewController to the navigationController's stack.
    [self.navigationController pushViewController:attractionIntroVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"parallaxCell";
    JBParallaxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[JBParallaxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UBHViewSpot *viewSpot  = self.dataSource[indexPath.row];
    cell.titleLabel.text = viewSpot.name;
    //[NSString stringWithFormat:NSLocalizedString(@"Cell %d",), indexPath.row];
    cell.subtitleLabel.text = viewSpot.city;// [NSString stringWithFormat:NSLocalizedString(@"This is a parallex cell %d",),indexPath.row];
    [cell.parallaxImage sd_setImageWithURL:[NSURL URLWithString:viewSpot.image] placeholderImage:[UIImage imageNamed:@"demo_2.jpg"]];
//    cell.parallaxImage.image = self.tableItems[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height/5.0f;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Get visible cells on table view.
    NSArray *visibleCells = [self.tableView visibleCells];
    
    for (JBParallaxCell *cell in visibleCells) {
        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
    }
}


@end
