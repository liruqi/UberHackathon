//
//  AttractionIntroViewController.h
//  UberHackathon
//
//  Created by 孙恺 on 16/1/17.
//  Copyright © 2016年 微博@iOS程序犭袁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBHViewSpot.h"

@interface AttractionIntroViewController : UIViewController

@property (nonatomic, strong) UIImage *headerImage;
@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) NSString *cityName;

@property (nonatomic, strong) NSString *locationName;

@property (nonatomic, strong) UBHViewSpot *model;

@end
