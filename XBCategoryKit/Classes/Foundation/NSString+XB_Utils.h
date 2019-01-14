//
//  NSString+Attributed.h
//  XBKit
//
//  Created by Xinbo Hong on 2018/5/29.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (XB_Utils)
#pragma mark - --- 数字字符串格式化 ---

//千分位+ 保留两位小数点：##,###.00
+ (NSString *)positiveFloatFormat:(NSString *)text;

//千分位 整数：##,###
+ (NSString *)positiveIntFormat:(NSString *)text;

//数值转换成字符串，解决出现显示0.000...0001或者0.999...9999问题
+ (NSString *)numberStringWithDouble:(double)doubleValue;
#pragma mark - --- 清除内容 ---
- (NSString *)stringByRemoveHTML;

- (NSString *)stringByRemoveJSScript;

- (NSString *)stringByRemoveSpace;

- (NSString *)stringByRemoveEnterAndSpace;

#pragma mark - --- String与Data转换 ---
- (NSData *)toData;

+ (NSString *)toStringFromData:(NSData *)data;

@end
