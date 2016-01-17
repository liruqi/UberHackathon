//
//  UberCell.m
//  UberHackathon
//
//  Created by 孙恺 on 16/1/17.
//  Copyright © 2016年 微博@iOS程序犭袁. All rights reserved.
//


#import "UberCell.h"

@implementation UberCell

- (void)awakeFromNib {
    // Initialization code
    self.button = [[RequestButton alloc] initWithColorStyle:RequestButtonColorStyleWhite];
    [self setBackgroundColor:[UIColor colorWithRed:192.0f/255.0f green:192.0f/255.0f blue:200.0f/255.0f alpha:1.0f]];
    
    [self addSubview:self.button];
}

- (void)setDropoffLongitude:(float)longitude latitude:(float)latitude nickname:(NSString *)nickname {
    [self.button setDropoffLocationWithLatitude:[NSString stringWithFormat:@"%f",latitude] longitude:[NSString stringWithFormat:@"%f", longitude] nickname:nickname address:nil];
}

- (void)setPickupLongitude:(float)longitude latitude:(float)latitude nickname:(NSString *)nickname {
    [self.button setPickupLocationWithLatitude:[NSString stringWithFormat:@"%f",latitude] longitude:[NSString stringWithFormat:@"%f", longitude] nickname:nickname address:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
