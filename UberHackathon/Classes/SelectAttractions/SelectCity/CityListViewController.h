//
//  CityListViewController.h
//
//  Created by Bit Watermelon on 11-11-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityListDelegate <NSObject>

- (void)didSelectCityWithName:(NSString *)cityName;

@end

@interface CityListViewController : UIViewController {
    NSDictionary *cities;  
    NSArray *keys;
}

// TODO: 通过代理回调城市
@property(nonatomic, assign) id<CityListDelegate>delegete;

@property (nonatomic, retain) NSDictionary *cities;  
@property (nonatomic, retain) NSArray *keys;
@property (nonatomic, assign) BOOL draggable; // Default: YES

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
