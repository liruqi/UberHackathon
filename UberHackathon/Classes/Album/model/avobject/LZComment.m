//
//  MCComment.m
//  LZAlbum
//
//  Created by wangyuansong on 15/3/12.
//  Copyright (c) 2015年 lzw. All rights reserved.
//

#import "LZComment.h"

@implementation LZComment

@dynamic album;
@dynamic commentContent;
@dynamic commentUser;
@dynamic toUser;

+(void)load {
    [LZComment registerSubclass];
}

+(NSString*)parseClassName{
    return @"Comment";
}

@end
