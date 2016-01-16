//
//  MCAlbumReplyView.m
//  LZAlbum
//
//  Created by lzw on 15/3/30.
//  Copyright (c) 2015年 lzw. All rights reserved.
//

#import "LZAlbumReplyView.h"
#import "LZInputAccessoryView.h"

@interface LZAlbumReplyView ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField* textField;

@property (nonatomic,strong) UITextField* inputTextField;

@property (nonatomic,strong) LZInputAccessoryView* customInputAccessoryView;

@end

@implementation LZAlbumReplyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithWhite:0.910 alpha:1.000];
        [self addSubview:self.textField];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

-(void)keyboardDidShow{
    [self becomeFirstResponderForInputTextField];
}

-(void)becomeFirstResponderForTextField{
    if([self.textField isFirstResponder]==NO){
        [self.textField becomeFirstResponder];
    }
}

-(void)becomeFirstResponderForInputTextField{
    if([self.inputTextField isFirstResponder]==NO){
        [self.inputTextField becomeFirstResponder];
    }
}

-(void)resignFirstResponderForTwoTextFields{
    if([self.inputTextField isFirstResponder]){
        [self.inputTextField resignFirstResponder];
    }
    
    if([self.textField isFirstResponder]){
        [self.textField resignFirstResponder];
    }
    CGRect frame = self.customInputAccessoryView.keyboardViewProxy.frame;
    CGFloat keyboardMaxH = CGRectGetHeight([UIScreen mainScreen].bounds);
    if (self.customInputAccessoryView.keyboardViewProxy != nil && frame.origin.y != keyboardMaxH) {
        frame.origin.y = keyboardMaxH;
        self.customInputAccessoryView.keyboardViewProxy.frame = frame;
    }
}

-(void)show{
    [self becomeFirstResponderForTextField];
}

-(void)dismiss{
    [self resignFirstResponderForTwoTextFields];
}

-(UITextField*)textField{
    if(_textField==nil){
        _textField=[[UITextField alloc] initWithFrame:CGRectZero];
        _textField.inputAccessoryView=self.customInputAccessoryView;
        _textField.returnKeyType=UIReturnKeySend;
    }
    return _textField;
}

-(UIView*)customInputAccessoryView{
    if(_customInputAccessoryView==nil){
        _customInputAccessoryView=[[LZInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
        _customInputAccessoryView.backgroundColor = [UIColor colorWithWhite:0.910 alpha:1.000];
        [_customInputAccessoryView addSubview:self.inputTextField];
    }
    return _customInputAccessoryView;
}

-(UITextField*)inputTextField{
    if(_inputTextField==nil){
        _inputTextField=[[UITextField alloc] initWithFrame:CGRectMake(kLZAlbumReplyViewPadding, kLZAlbumReplyViewPadding, CGRectGetWidth(_customInputAccessoryView.frame)-kLZAlbumReplyViewPadding*2, 44-kLZAlbumReplyViewPadding*2)];
        _inputTextField.delegate=self;
        _inputTextField.returnKeyType=UIReturnKeySend;
        _inputTextField.borderStyle=UITextBorderStyleRoundedRect;
    }
    return _inputTextField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.text.length>0){
        if([_albumReplyViewDelegate respondsToSelector:@selector(albumReplyView:didReply:)]){
            [_albumReplyViewDelegate albumReplyView:self didReply:textField.text];
        }
    }
    return YES;
}

-(void)finishReply{
    [self resignFirstResponderForTwoTextFields];
    self.inputTextField.text=nil;
}

@end
