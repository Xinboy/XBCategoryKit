//
//  UIColor+XBCategory.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2017/12/1.
//  Copyright © 2017年 X-Core Co,. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XB_Extension)

+ (UIColor *)colorForRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

/**
 修改颜色透明度
 */
- (UIColor *)changeAlpha:(CGFloat)alpha;
#pragma mark - --- 各种十六进制转换颜色 ---
/**
 十六进制整型与透明度组合转颜色

 @param hexNumber 十六进制，格式为0xffffff
 @param alpha 透明度
 @return 颜色
 */
+ (UIColor *)colorWithHexInt:(int)hexNumber alpha:(CGFloat)alpha;


/**
 十六进制整型转颜色，透明度默认为1.0f

 @param hexNumber 十六进制整型
 @return 颜色
 */
+ (UIColor *)colorWithHexInt:(int)hexNumber;

/**
 十六进制字符串与透明度组合转颜色

 @param hexString 字符串支持0xffffff/#ffffff/ffffff
 @param alpha 透明度
 @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;


/**
 十六进制字符串转颜色，透明度默认为1.0f

 @param hexString 十六进制字符串
 @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

#pragma mark - --- 根据颜色输出 ---

/**
 *
 *  返回颜色所分别对应的R,G,B,A值
 *
 *  @return 包含R,G,B,A值的数组
 */
- (NSArray *)rgbaArray;

/**
 *
 *  返回颜色所对应的十六进制值
 *
 *  @return 该颜色的十六进制
 */
- (NSString *)hexString;


/**
 *  返回颜色所对应的各个值
 */
- (CGFloat)red;
- (CGFloat)blue;
- (CGFloat)green;
- (CGFloat)alpha;

#pragma mark - --- 其他 ---
/**
 识别点击图片位置的颜色
 
 @param point 点击坐标
 @return 颜色
 */
+ (UIColor *)colorAtPoint:(CGPoint)point inImage:(UIImage *)image;

/**
 * 随机颜色
 */
+ (UIColor *)randomColor;

/**
 * 渐变颜色
 */
+ (UIColor *)gradientFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor withHeight:(CGFloat)height;
@end
