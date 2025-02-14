//
//  PwKeyboardBaseView.h
//  CustomKeybord
//
//  Created by King on 2018/1/10.
//  Copyright © 2018年 King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PwKeyboardBaseView : UIView
@property(nonatomic, copy) void(^btnClickedCallback)(NSString *str);
@property(nonatomic, copy) void(^deleteBtnClickedCallback)(void);
@property(nonatomic, copy) void(^returnBtnClickedCallback)(void);
- (UIButton *)configBtn:(CGRect)btnRect title:(NSString *)title contentView:(UIView *)contentView;
@end
