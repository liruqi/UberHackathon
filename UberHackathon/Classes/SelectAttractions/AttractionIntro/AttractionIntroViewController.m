//
//  AttractionIntroViewController.m
//  UberHackathon
//
//  Created by 孙恺 on 16/1/17.
//  Copyright © 2016年 微博@iOS程序犭袁. All rights reserved.
//

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
        _cityName = [NSString string];
        _headerImage = [[UIImage alloc] init];
        [self.tableView registerClass :[AttractionIntroCell class] forCellReuseIdentifier:@"attractonIntroCell"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
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
    return 100;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"景点介绍";
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
        return cell;
    }
    static NSString *CellIdentifier = @"attractonIntroCell";
    AttractionIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AttractionIntroCell" owner:self options:nil] lastObject];

    }
    
    switch (indexPath.row) {
        case 0:
            [cell.topLabel setText:@"景点名称"];
            [cell.textView setText:@"222"];
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
