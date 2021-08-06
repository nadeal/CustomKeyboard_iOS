//
//  PwCustomKeyboard.h
//  CustomKeybord
//
//  Created by King on 2018/1/9.
//  Copyright © 2018年 King. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PWKeyboardType) {
    PWKeyboardTypeNum = 1,
    PWKeyboardTypeLetters = 2,//字母
    PWKeyboardTypeSymbol = 3//字符
};

@class PwCustomKeyboard;
@protocol CustomKeyboardDelegate <NSObject>
/** 点击return按钮 */
- (void)customKeyboardDidClickedReturn:(PwCustomKeyboard *)customKeyboard;
@end


@interface PwCustomKeyboard : UIView

/** 需要操作的textView */
@property(nonatomic, strong) UITextView *textView;
@property(nonatomic, strong) UITextField *textField;

- (instancetype)initWithTextView:(UITextView *)textView;
- (instancetype)initWithTextField:(UITextField *)field;

/**
 允许空格  默认不允许输入空格
 */
@property (nonatomic, assign) BOOL allowSpace;

/**
 不允许点击按键时，有变化颜色 默认点击按钮时会产生阴影
 */
@property (nonatomic, assign) BOOL forbidClickedShow;

/**
 数字键盘是否每次使用都随记排布   默认固定数字键盘
 */
@property (nonatomic, assign) BOOL allowRandomLayout;

/**
 仅支持特定键盘  字母  字符  数字
 */
@property (nonatomic, assign) PWKeyboardType onlyKeyboardType;

/**
 禁止某个键盘方式
 */
@property (nonatomic, assign) PWKeyboardType forbidKeyBoardType;

@property (nonatomic, weak) id<CustomKeyboardDelegate> delegate;
@end
