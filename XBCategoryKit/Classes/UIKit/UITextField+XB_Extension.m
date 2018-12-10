//
//  UITextField+XB_Extension.m
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2018/12/10.
//  Copyright © 2018年 Xinboy. All rights reserved.
//

#import "UITextField+XB_Extension.h"

@implementation UITextField (XB_Extension)

static NSString *const kPlaceholderColorKey = @"placeholderLabel.textColor";

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    /* 这3行代码的作用
        1. 保证创建出placeholderLabel
        2. 保留曾经设置过的占位文字
     */
    NSString *placeholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = placeholder;
    
    if (placeholderColor == nil) {
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:25 alpha:0.22];
        
    }
    
    [self setValue:placeholderColor forKey:kPlaceholderColorKey];
}

- (UIColor *)placeholderColor {
    return [self valueForKeyPath:kPlaceholderColorKey];
}

@end
