//
//  HotCityTableViewCell.m
//  Wear
//
//  Created by 孙恺 on 15/11/26.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import "HotCityTableViewCell.h"

@implementation HotCityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)buttonClick:(id)sender {
    [self.delegate didSelectHotCity:((UIButton *)sender).titleLabel.text];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
