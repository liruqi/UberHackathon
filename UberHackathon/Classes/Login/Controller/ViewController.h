//
//  ViewController.h
//  VideoWelcome
//
//  Created by 王晨晓 on 15/7/15.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CompletionBlock)(void);

@interface ViewController : UIViewController
//self.completionBlock可能被另一个线程改为空，造成crash，使用atomic会确保self.completionBlock的原子性
@property (copy) CompletionBlock completionBlock;

@end

