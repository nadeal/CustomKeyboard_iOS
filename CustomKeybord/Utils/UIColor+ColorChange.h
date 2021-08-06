//
//  UIColor+ColorChange.h
//
//  Created by Nadeal on 2018/7/9.
//  Copyright © 2018年 Nadeal Pang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIColor (ColorChange)



/**
 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB) 范例：fba76e
 */
+ (UIColor *) colorWithHexString: (NSString *)color;

+(UIImage*) createImageWithColor: (UIColor*) color;

+(UIColor*) colorFromImg:(UIImage*) img;

+(UIColor*) colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
@end
