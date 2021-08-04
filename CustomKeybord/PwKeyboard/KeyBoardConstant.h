//
//  KeyBoardConstant.h
//  CustomKeybord
//
//  Created by Ketty on 2018/1/10.
//  Copyright © 2018年 Ketty. All rights reserved.
//

#ifndef KeyBoardConstant_h
#define KeyBoardConstant_h
#define IS_IPHONE6 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 667 || [UIScreen mainScreen].bounds.size.width == 667)

#define IS_IPHONE6_PLUS ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 736 || [UIScreen mainScreen].bounds.size.width == 736)
#define AUTO_ADAPT_SIZE_VALUE(iPhone4_5, iPhone6, iPhone6plus) (IS_IPHONE6 ? iPhone6 : (IS_IPHONE6_PLUS ? iPhone6plus : iPhone4_5))
#define DeviceWidth [UIScreen mainScreen].bounds.size.width
#define DeviceHeight [UIScreen mainScreen].bounds.size.height
//防止循环引用，弱化对象
#define WS(weakSelf,object) typeof(object) __weak weakSelf = object

#define G_KeyWindow          [UIApplication sharedApplication].keyWindow
#define G_SCREEN_W ([UIScreen mainScreen].bounds.size.width)
#define G_SCREEN_H ([UIScreen mainScreen].bounds.size.height)
//rgb颜色转换（16进制->10进制）
#define KBColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#endif /* KeyBoardConstant_h */
