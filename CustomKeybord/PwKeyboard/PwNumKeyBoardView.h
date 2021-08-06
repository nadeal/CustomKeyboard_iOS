//
//  PwNumKeyBoardView.h
//  CustomKeybord
//
//  Created by King on 2018/1/10.
//  Copyright © 2018年 King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBoardConstant.h"
#import "PwKeyboardBaseView.h"
@interface PwNumKeyBoardView : PwKeyboardBaseView
- (void)reRankNum;

/**
 数字键盘是否每次使用都随记排布   默认固定数字键盘
 */
@property (nonatomic, assign) BOOL allowRandomLayout;

@end
