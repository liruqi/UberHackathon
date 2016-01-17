//
//  UberCell.m
//  UberHackathon
//
//  Created by 孙恺 on 16/1/17.
//  Copyright © 2016年 微博@iOS程序犭袁. All rights reserved.
//

@import UberRides;
#import "UberCell.h"

@implementation UberCell

- (void)awakeFromNib {
    // Initialization code
    RequestButton *button = [[RequestButton alloc] initWithColorStyle:RequestButtonColorStyleWhite];
    
//    NSLog(@"%f",button.frame.size.height);
//    [button setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0f, [UIScreen mainScreen].bounds.size.height/2.0f)];
    
    [self addSubview:button];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
