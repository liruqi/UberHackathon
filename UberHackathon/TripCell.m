//
//  TripCell.m
//  UberHackathon
//
//  Created by 陈宜龙 on 16/1/17.
//  Copyright © 2016年 微博@iOS程序犭袁. All rights reserved.
//

#import "TripCell.h"

// 价格
// curl -H 'Authorization: Token ErRQ338IAFt5f1wmN6w1fhm38beB4YYgONM1LyE_' 'https://api.uber.com/v1/estimates/price?start_latitude=37.7759792&start_longitude=-122.41823&end_latitude=36.7759792&end_longitude=-121.41823'

@implementation TripCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"Cell";
    TripCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TripCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupAllSubviews];
        [self setupBg];
    }
    return self;
}

/**
 *  设置背景
 */
- (void)setupBg
{
    self.backgroundColor = [UIColor whiteColor];
}

-(void)setupAllSubviews {
    
}

@end
