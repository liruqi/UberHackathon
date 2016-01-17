//
//  AttractionIntroViewController.m
//  UberHackathon
//
//  Created by 孙恺 on 16/1/17.
//  Copyright © 2016年 微博@iOS程序犭袁. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "UberCell.h"
#import "AttractionIntroCell.h"
#import "AttractionIntroViewController.h"
#import "UINavigationBar+Awesome.h"

#define NAVBAR_CHANGE_POINT 50

@interface AttractionIntroViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AttractionIntroViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[UBHViewSpot alloc] init];
        _cityName = [NSString string];
        _headerImage = [[UIImage alloc] init];
        self.imageURLString = [[NSString alloc] init];
        [self.tableView registerClass :[AttractionIntroCell class] forCellReuseIdentifier:@"attractonIntroCell"];
    }
    return self;
}

- (void)callMap {
    BOOL hasBaiduMap = NO;
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]){
        hasBaiduMap = YES;
    }
    NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/marker?location=49.047669,116.313082&title=位置&content=位置&src=UberHackathon"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *mapBtn = [[UIBarButtonItem alloc] initWithTitle:@"查看地图" style:UIBarButtonItemStylePlain target:self action:@selector(callMap)];
    [self.navigationItem setRightBarButtonItem:mapBtn];
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [imageView setImage:self.headerImage];
    [self.tableView setTableHeaderView:imageView];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(-64, 0, 0, 0)];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"attractonIntroCell"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor blueColor]];
    
    
    [imageView sd_setImageWithURL:self.imageURLString placeholderImage:[UIImage imageNamed:@"demo_2.jpg"]];
    // Do any additional setup after loading the view from its nib.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor *color = [UIColor colorWithWhite:10.0/255.0f alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

#pragma mark UITableViewDatasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    AttractionIntroCell *tempcell = ((AttractionIntroCell *)[tableView cellForRowAtIndexPath:indexPath]);
//    return tempcell.topLabel.frame.size.height+20+tempcell.textView.frame.size.height;
    if (!indexPath.row) {
        return 40;
    }
    return 400;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.locationName;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.row) {
        static NSString *CellIdentifier = @"ubercell";
        UberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"UberCell" owner:self options:nil] lastObject];
        }
        [cell setPickupLongitude:120.112482 latitude:30.246211 nickname:@"灵隐寺"];
        [cell setDropoffLongitude:120.141377 latitude:30.257793 nickname:@"西湖"];
        return cell;
    }
    static NSString *CellIdentifier = @"attractonIntroCell";
    AttractionIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AttractionIntroCell" owner:self options:nil] lastObject];

    }
    
    switch (indexPath.row) {
        case 0:
//            [cell.topLabel setText:@"景点名称"];
//            [cell.textView setText:@"222"];
            break;
        case 1:
            [cell.topLabel setText:@"景点介绍"];
            break;
        default:
            break;
    }
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
