//
//  UberCell.h
//  UberHackathon
//
//  Created by 孙恺 on 16/1/17.
//  Copyright © 2016年 微博@iOS程序犭袁. All rights reserved.
//

@import UberRides;
#import <UIKit/UIKit.h>

@interface UberCell : UITableViewCell

@property (nonatomic, strong) RequestButton *button;

- (void)setDropoffLongitude:(float)longitude latitude:(float)latitude nickname:(NSString *)nickname;

- (void)setPickupLongitude:(float)longitude latitude:(float)latitude nickname:(NSString *)nickname;

@end
