//
//  UIImage+Extension.h
//  SmartHome
//
//  Created by xinbo on 16/3/10.
//  Copyright © 2016年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CircleHeading) {
    CircleHeadingLeft = 0,
    CircleHeadingRight,
    CircleHeadingTop,
    CircleHeadingBottom,
};

@interface UIImage (XB_Extension)

/**
 截屏
 */
+ (instancetype)snapshotCurrentScreen;

#pragma mark - --- 获取图片 ---
/**
 根据颜色生成纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 根据颜色生成纯色圆角图片
 */
+ (UIImage *)imageWithCornerRadiusSize:(CGSize)size Color:(UIColor *)color;

/**
 获得灰度图
 */
- (UIImage *)convertToGrayImage;

/** UIView转化为UIImage */
+ (UIImage *)imageFromView:(UIView *)view;

/** 加上蒙版图片 */
- (UIImage *)imageWithMask:(UIImage *)maskImage;

//带有阴影效果的图片
- (UIImage *)imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur;
#pragma mark - --- 图片处理 ---
/**
 图片模糊效果
 默认透明度为0.1，半径3，饱和因子为1
 */
- (UIImage *)blur;

/**
 图片模糊效果
 */
- (UIImage *)imageWithAlpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor;

/**
 图片部分模糊效果
 */
- (UIImage *)imageWithFrane:(CGRect)frame Alpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor;

/**
 图片按照一个半径裁剪左右圆角
 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

/**
 图片裁剪成圆形
 */
+ (UIImage *)circleWithImage:(UIImage *)image;


#pragma mark - --- 图片操作 ---
/**
 重新设定图片大小
 */
+ (UIImage *)resizableImage:(NSString *)imageName top:(CGFloat)top bottom:(CGFloat)bottom left:(CGFloat)left right:(CGFloat)right;
/**
 缩放图片
 */
+ (UIImage *)resizedImage:(NSString *)name scale:(CGFloat)scale;

/**
 缩放图片: 更低层的ImageIO接口
 */
+ (UIImage *)scaledImageWithData:(NSData *)data withSize:(CGSize)size scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;

/**
 压缩图片:最大字节大小为maxLength
 */
- (NSData *)compressWithMaxLength:(NSInteger)maxLength;

/**
 压缩图片至指定尺寸
 */
- (UIImage *)rescaleImageToSize:(CGSize)size;

/**
 压缩图片至指定像素
 */
- (UIImage *)rescaleImageToPX:(CGFloat )toPX;

/**
 按给定的方向旋转图片
 */
- (UIImage*)rotate:(UIImageOrientation)orient;

/**
 垂直翻转
 */
- (UIImage *)flipVertical;

/**
 水平翻转
 */
- (UIImage *)flipHorizontal;

/**
 将图片旋转radians弧度
 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

/**
 将图片旋转degrees角度
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
#pragma mark - **************** 二维码生成

/**
 二维码生成（无logo）
 
 @param string 写入二维码的字符串
 @param imageSide 图片大小
 @return 二维码图片
 */
+ (UIImage *)qrImageForString:(NSString *)string ImageSide:(CGFloat)imageSide;


/**
 二维码中间添加logo图片
 
 @param qrImage 二维码图片
 @param logoImage logo图片
 @param logoSide logo大小
 @return 生成的新二维码图片
 */
+ (UIImage *)qrImage:(UIImage *)qrImage WithAddLogoImage:(UIImage *)logoImage LogoImageSide:(CGFloat)logoSide;

#pragma mark - **************** 
/**
 *  此点区域的色值
 *
 *  @param point CGPoint
 *
 *  @return 色值
 */
- (UIColor *)colorAtPoint:(CGPoint)point;


/**
 图片圆角的朝向

 @param heading 朝向位置：上下左右
 @param rect 尺寸大小
 @param fillColor 填充颜色
 */
+ (UIImage *)imageForCircleHeading:(CircleHeading)heading Rect:(CGRect)rect color:(UIColor *)fillColor;
@end
