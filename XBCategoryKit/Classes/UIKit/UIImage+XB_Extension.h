//
//  UIImage+Extension.h
//  SmartHome
//
//  Created by xinbo on 16/3/10.
//  Copyright © 2016年 xigu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef NS_ENUM(NSInteger, CircleHeading) {
    CircleHeadingLeft = 0,
    CircleHeadingRight,
    CircleHeadingTop,
    CircleHeadingBottom,
};

@interface UIImage (XB_Extension)
/// 截屏
+ (instancetype)snapshotCurrentScreen;

#pragma mark - --- 获取图片 ---
/// 根据颜色生成纯色图片
/// @param color 颜色
+ (UIImage *)imageWithColor:(UIColor *)color;


/// 根据颜色生成纯色圆角图片
/// @param size 圆角尺寸
/// @param color 颜色
+ (UIImage *)imageWithCornerRadiusSize:(CGSize)size Color:(UIColor *)color;


/// 获得灰度图
- (UIImage *)convertToGrayImage;

/// UIView转化为UIImage
/// @param view 代转视图
+ (UIImage *)imageFromView:(UIView *)view;

/// 为图片加上蒙版图片
/// @param maskImage 蒙版图片
- (UIImage *)imageWithMask:(UIImage *)maskImage;



/// 带有阴影效果的图片
/// @param color 阴影颜色
/// @param offset 阴影偏移
/// @param blur 阴影模糊效果
- (UIImage *)imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur;


- (void)configureAsset:(PHAsset *)asset doAction:(void(^)(NSString *url))actionBlock;

///
+ (UIImage *)takeScreenshot;

+ (UIImage *)screenshot;
#pragma mark - --- 图片处理 ---

/// 图片模糊效果：默认透明度为0.1，半径3，饱和因子为1
- (UIImage *)blur;


/// 图片模糊效果
/// @param alpha 透明度
/// @param radius 圆角尺寸
/// @param colorSaturationFactor 饱和因子
- (UIImage *)imageWithAlpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor;

/// 图片部分模糊效果
/// @param frame 模糊区域
/// @param alpha 透明度
/// @param radius 圆角尺寸
/// @param colorSaturationFactor 饱和因子
- (UIImage *)imageWithFrane:(CGRect)frame Alpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor;


/// 根据圆角半径裁剪圆角
/// @param radius 圆角半径
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;


/// 图片裁剪成圆形
/// @param image 待裁剪图片
+ (UIImage *)circleWithImage:(UIImage *)image;


#pragma mark - --- 图片操作 ---
///  重新设定图片大小
/// @param imageName  图片名字
/// @param top 顶部
/// @param bottom 底部
/// @param left 左侧
/// @param right 右侧
+ (UIImage *)resizableImage:(NSString *)imageName top:(CGFloat)top bottom:(CGFloat)bottom left:(CGFloat)left right:(CGFloat)right;

/// 缩放图片
/// @param name 图片名字
/// @param scale 图片比例
+ (UIImage *)resizedImage:(NSString *)name scale:(CGFloat)scale;


/// 缩放图片: 更低层的ImageIO接口
/// @param data 图片数据
/// @param size 图片尺寸
/// @param scale 图片比例
/// @param orientation 图片方向
+ (UIImage *)scaledImageWithData:(NSData *)data withSize:(CGSize)size scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;


/// 压缩图片至最大字节
/// @param maxLength 最大字节大小
- (NSData *)compressWithMaxLength:(NSInteger)maxLength;

/// 压缩图片至指定尺寸
/// @param size 指定尺寸
- (UIImage *)rescaleImageToSize:(CGSize)size;


/// 压缩图片至指定像素
/// @param toPX 指定像素
- (UIImage *)rescaleImageToPX:(CGFloat )toPX;


///  按给定的方向旋转图
/// @param orient g方向
- (UIImage*)rotate:(UIImageOrientation)orient;


/// 垂直翻转
- (UIImage *)flipVertical;

/// 水平翻转
- (UIImage *)flipHorizontal;


/// 按radians弧度旋转图片
/// @param radians 弧度
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

/// 按degrees角度旋转图片
/// @param degrees 角度
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
#pragma mark - **************** 二维码生成

/// 二维码生成（无logo）
/// @param string 写入二维码的字符串
/// @param imageSide 图片大小
+ (UIImage *)qrImageForString:(NSString *)string ImageSide:(CGFloat)imageSide;


/// 二维码中间添加logo图片
/// @param qrImage  二维码图片
/// @param logoImage logo图片
/// @param logoSide logo大小
+ (UIImage *)qrImage:(UIImage *)qrImage WithAddLogoImage:(UIImage *)logoImage LogoImageSide:(CGFloat)logoSide;

#pragma mark - ****************

/// 获取图片上此点的色值
/// @param point 点位置
- (UIColor *)colorAtPoint:(CGPoint)point;


/// 图片圆角的朝向
/// @param heading 朝向位置：上下左右
/// @param rect 尺寸大小
/// @param fillColor 填充颜色
+ (UIImage *)imageForCircleHeading:(CircleHeading)heading Rect:(CGRect)rect color:(UIColor *)fillColor;
@end
