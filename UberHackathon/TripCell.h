//
//  TripCell.h
//  UberHackathon
//
//  Created by 陈宜龙 on 16/1/17.
//  Copyright © 2016年 微博@iOS程序犭袁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
