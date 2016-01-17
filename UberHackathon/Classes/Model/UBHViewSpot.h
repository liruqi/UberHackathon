//
//  UBHViewSpot.h
//  UberHackathon
//
//  Created by Ruqi on 16/1/2016.
//  Copyright © 2016 微博@iOS程序犭袁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
#import <MapKit/MapKit.h>

@interface UBHViewSpot : AVObject<AVSubclassing>

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* city;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *suggestion;
//@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, strong) NSString* intro;
@property (nonatomic, strong) NSString* image;

//+ (NSArray*) suggestedViewSpotsForBeijing;

@end
