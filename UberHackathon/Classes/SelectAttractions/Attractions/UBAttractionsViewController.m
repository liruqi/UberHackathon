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

// Table cells
#import "JBParallaxCell.h"

@interface UBAttractionsViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *tableItems;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation UBAttractionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    // Load the items in the table
    self.tableItems = @[[UIImage imageNamed:@"demo_1.jpg"],
                        [UIImage imageNamed:@"demo_2.jpg"],
                        [UIImage imageNamed:@"demo_3.jpg"],
                        [UIImage imageNamed:@"demo_4.png"],
                        [UIImage imageNamed:@"demo_1.jpg"],
                        [UIImage imageNamed:@"demo_2.jpg"],
                        [UIImage imageNamed:@"demo_3.jpg"],
                        [UIImage imageNamed:@"demo_4.png"],
                        [UIImage imageNamed:@"demo_3.jpg"],
                        [UIImage imageNamed:@"demo_2.jpg"],
                        [UIImage imageNamed:@"demo_1.jpg"],
                        [UIImage imageNamed:@"demo_4.png"]];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self.view addSubview:self.tableView];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"北京" style:UIBarButtonItemStylePlain target:self action:@selector(onChangeCity:)];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"parallaxCell";
    JBParallaxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[JBParallaxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSLog(@"111");
    
    cell.titleLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Cell %d",), indexPath.row];
    cell.subtitleLabel.text = [NSString stringWithFormat:NSLocalizedString(@"This is a parallex cell %d",),indexPath.row];
    cell.parallaxImage.image = self.tableItems[indexPath.row];
    
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
