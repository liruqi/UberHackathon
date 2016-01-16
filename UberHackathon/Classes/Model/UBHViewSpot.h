//
//  UBHViewSpot.h
//  UberHackathon
//
//  Created by Ruqi on 16/1/2016.
//  Copyright © 2016 微博@iOS程序犭袁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import <MapKit/MapKit.h>

@interface UBHViewSpot : JSONModel

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* city;
@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, strong) NSString* intro;
@property (nonatomic, strong) NSString* image;

+ (NSArray*) suggestedViewSpotsForBeijing;

@end
