//
//  UIColor+XBCategory.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2017/12/1.
//  Copyright © 2017年 X-Core Co,. All rights reserved.
//

#import "UIColor+XB_Extension.h"

@implementation UIColor (XB_Extension)

+ (UIColor *)colorForRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

- (UIColor *)changeAlpha:(CGFloat)alpha {
    return [self colorWithAlphaComponent:alpha];
}

#pragma mark - --- 各种16进制转换颜色 ---
+ (UIColor *)colorWithHexInt:(int)hexNumber alpha:(CGFloat)alpha {
    if (hexNumber > 0xFFFFFF) {
        return nil;
    }
    CGFloat rFloat = ((hexNumber >> 16) & 0xFF) / 255.0;
    CGFloat gFloat = ((hexNumber >> 8) & 0xFF) / 255.0;
    CGFloat bFloat = (hexNumber & 0xFF) / 255.0;
    return [UIColor colorWithRed:rFloat green:gFloat blue:bFloat alpha:alpha];
}

+ (UIColor *)colorWithHexInt:(int)hexNumber {
    return [UIColor colorWithHexInt:hexNumber alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    hexString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    UIColor *defaultColor = [UIColor clearColor];
    
    if (hexString.length < 6) {
        return defaultColor;
    }
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    if ([hexString hasPrefix:@"0X"] || [hexString hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }
    if (hexString.length != 6) {
        return defaultColor;
    }
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    unsigned int hexNumber;
    if (![scanner scanHexInt:&hexNumber]) {
        return defaultColor;
    }
    
    return [UIColor colorWithHexInt:hexNumber alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    return [UIColor colorWithHexString:hexString alpha:1.0f];
}



#pragma mark - --- 根据颜色输出 ---
- (NSArray *)rgbaArray {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    //判断是否存在getRed:green:blue:alpha:这个方法，有就通过这个方法获取RGBA的值
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        //返回数组
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    return @[@(r),@(g),@(b),@(a)];
}

- (NSString *)hexString {
    NSArray *colorArray = [self rgbaArray];
    int r = [colorArray[0] floatValue] * 255;
    int g = [colorArray[1] floatValue] * 255;
    int b = [colorArray[2] floatValue] * 255;
    NSString *red = [NSString stringWithFormat:@"%02x", r];
    NSString *green = [NSString stringWithFormat:@"%02x", g];
    NSString *blue = [NSString stringWithFormat:@"%02x", b];
    return [NSString stringWithFormat:@"#%@%@%@", red, green, blue];
}

- (CGFloat)red {
    return [[self rgbaArray][0] floatValue];
}

- (CGFloat)green {
    return [[self rgbaArray][1] floatValue];
}

- (CGFloat)blue {
    return [[self rgbaArray][2] floatValue];
}

- (CGFloat)alpha {
    return [[self rgbaArray][3] floatValue];
}
#pragma mark - --- 其他 ---
/** 此点区域的色值*/
+ (UIColor *)colorAtPoint:(CGPoint)point inImage:(UIImage *)image {
    
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0, 0, image.size.width, image.size.height), point)) {
        return nil;
    }
    
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = image.CGImage;
    NSUInteger width = image.size.width;
    NSUInteger height = image.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

/**
 * 随机颜色
 */
+ (UIColor *)randomColor {
    return [UIColor colorForRed:arc4random_uniform(256) green:arc4random_uniform(256) blue:arc4random_uniform(256) alpha:1.0];
}

/**
 * 渐变颜色
 */
+ (UIColor *)gradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor withHeight:(CGFloat)height {
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSArray *colors = [NSArray arrayWithObjects:(id)fromColor.CGColor, (id)toColor.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
    
}
@end
