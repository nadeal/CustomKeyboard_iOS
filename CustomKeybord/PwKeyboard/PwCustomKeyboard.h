//
//  PwCustomKeyboard.h
//  CustomKeybord
//
//  Created by King on 2018/1/9.
//  Copyright © 2018年 King. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PwCustomKeyboard;
@protocol CustomKeyboardDelegate <NSObject>
/** 点击return按钮 */
- (void)customKeyboardDidClickedReturn:(PwCustomKeyboard *)customKeyboard;
@end


@interface PwCustomKeyboard : UIView
- (instancetype)initWithTextView:(UITextView *)textView;
- (instancetype)initWithTextField:(UITextField *)field;

@property (nonatomic, weak) id<CustomKeyboardDelegate> delegate;
@end
