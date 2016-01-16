//
//  UBHViewSpot.m
//  UberHackathon
//
//  Created by Ruqi on 16/1/2016.
//  Copyright © 2016 微博@iOS程序犭袁. All rights reserved.
//

#import "UBHViewSpot.h"

@implementation UBHViewSpot

+ (NSArray*) suggestedViewSpotsForBeijing {
    NSMutableArray* ret = [NSMutableArray array];
    NSError* e;
    UBHViewSpot *s1 = [[UBHViewSpot alloc] initWithDictionary:@{
        @"name":@"颐和园",
        @"city":@"北京",
        @"image":@"http://t1.gstatic.com/images?q=tbn:ANd9GcS2dVjv2e7F-rFzWuoH_htaSJCL_wzRCuU6pJS_ytuvsqIvNXQ3"}
                                                        error:& e];
    [ret addObject:s1];
    return ret;
}

@end
