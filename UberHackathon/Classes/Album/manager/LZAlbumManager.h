//
//  LZAlbumManager.h
//  LZAlbum
//
//  Created by lzw on 15/4/1.
//  Copyright (c) 2015年 lzw. All rights reserved.
//

#import "LCAlbum.h"
#import "LZComment.h"

@interface LZAlbumManager : NSObject

+ (LZAlbumManager *)manager;

- (void)createAlbumWithText:(NSString*)text photos:(NSArray*)photos error:(NSError**)error;

-(void)findAlbumWithBlock:(AVArrayResultBlock)block;

- (void)addUserToCache:(AVUser *)user;

-(void)commentToUser:(AVUser *)toUser AtAlbum:(LCAlbum*)album content:(NSString*)content block:(AVBooleanResultBlock)block;

-(void)digOrCancelDigOfAlbum:(LCAlbum *)album block:(AVBooleanResultBlock)block;

- (void)deleteUnusedFiles;

@end
