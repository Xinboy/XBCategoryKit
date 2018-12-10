//
//  UIImage+Extension.m
//  SmartHome
//
//  Created by xinbo on 16/3/10.
//  Copyright © 2016年 xigu. All rights reserved.
//

#import "UIImage+Extension.h"
#import <Accelerate/Accelerate.h>
#import <ImageIO/ImageIO.h>
#import <objc/runtime.h>

@implementation UIImage (Extension)

+ (instancetype)snapshotCurrentScreen {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, 0);
    [window drawViewHierarchyInRect:window.frame afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}
#pragma mark - --- 获取图片 ---
//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithCornerRadiusSize:(CGSize)size BackgroundColor:(UIColor *)color {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = color;
    
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    image = [image imageWithCornerRadius:size.height * 0.5];
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

/**
 获得灰度图
 */
- (UIImage *)convertToGrayImage {
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    
    CGColorSpaceRef colorSpace= CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, kCGImageAlphaNone);
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef contextRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:contextRef];
    CGContextRelease(context);
    CGImageRelease(contextRef);
    return grayImage;
}

/** UIView转化为UIImage */
+ (UIImage *)imageFromView:(UIView *)view {
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 加上蒙版图片 */
- (UIImage *)imageWithMask:(UIImage *)maskImage {
    UIGraphicsBeginImageContextWithOptions(maskImage.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, CGRectMake(0, 0, self.size.width, self.size.height), maskImage.CGImage);
    [self drawAtPoint:CGPointZero];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//带有阴影效果的图片
- (UIImage *)imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur {
    CGSize border = CGSizeMake(fabs(offset.width) + blur, fabs(offset.height) + blur);
    
    CGSize size = CGSizeMake(self.size.width + border.width * 2.0, self.size.height + border.height * 2.0);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShadowWithColor(context, offset, blur, color.CGColor);
    [self drawAtPoint:CGPointMake(border.width, border.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - --- 图片处理 ---
/**
 图片模糊效果
 */
- (UIImage *)blur {
    return [self imageWithAlpha:0.1 radius:3 colorSaturationFactor:1];
}

- (UIImage *)imageWithAlpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor {
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:alpha];
    return [self blurWithRadius:radius tintColor:tintColor saturationDeltaFactor:colorSaturationFactor maskImage:nil];
}

- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    CGRect rect = (CGRect){0.0f,0.0f,self.size};
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//将图片裁剪成圆形
+ (UIImage *)circleWithImage:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    //获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //设置圆形
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextAddEllipseInRect(ref, rect);
    //裁剪
    CGContextClip(ref);
    
    [image drawInRect:rect];
    
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - --- 图片操作 ---
/**
 重新设定图片大小
 */
+ (UIImage *)resizableImage:(NSString *)imageName top:(CGFloat)top bottom:(CGFloat)bottom left:(CGFloat)left right:(CGFloat)right {
    UIImage *image = [UIImage imageNamed:imageName];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    return image;
}
/**
 缩放图片
 */
+ (UIImage *)resizedImage:(NSString *)name scale:(CGFloat)scale {
    
    UIImage *image = [UIImage imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width *scale topCapHeight:image.size.height * scale];
}

/**
 缩放图片: 更低层的ImageIO接口
 */
+ (UIImage *)scaledImageWithData:(NSData *)data withSize:(CGSize)size scale:(CGFloat)scale orientation:(UIImageOrientation)orientation {
    CGFloat maxPixedSize = MAX(size.width, size.height);
    
    CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)data, nil);
    NSDictionary *options = @{(__bridge id)kCGImageSourceCreateThumbnailFromImageAlways: (__bridge id)kCFBooleanTrue, (__bridge id)kCGImageSourceThumbnailMaxPixelSize: [NSNumber numberWithFloat: maxPixedSize]};
    
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(sourceRef, 0, (__bridge CFDictionaryRef)options);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef scale:scale orientation:orientation];
    CGImageRelease(imageRef);
    CFRelease(sourceRef);
    
    return resultImage;
}

/**
 压缩图片
 */
- (NSData *)compressWithMaxLength:(NSInteger)maxLength {
    CGFloat compress = 0.9;
    NSData *data = UIImageJPEGRepresentation(self, compress);
    
    while (data.length > maxLength && compress > 0.01) {
        compress -= 0.02;
        data = UIImageJPEGRepresentation(self, compress);
    }
    return data;
}

/**
 压缩图片至指定尺寸
 */
- (UIImage *)rescaleImageToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resImage;
    
}

/**
 压缩图片至指定像素
 */
- (UIImage *)rescaleImageToPX:(CGFloat )toPX {
    CGSize size = self.size;
    if (size.width <= toPX && size.height <= toPX) {
        return self;
    }
    CGFloat scale = size.width / size.height;
    if (size.width > size.height) {
        size.width = toPX;
        size.height = size.width / scale;
    } else {
        size.height = toPX;
        size.width = size.height *scale;
    }
    return [self rescaleImageToSize:size];
}

/**
 按给定的方向旋转图片
 */
- (UIImage*)rotate:(UIImageOrientation)orient {
    CGRect bnds = CGRectZero;
    UIImage *copy = nil;
    CGContextRef context = nil;
    CGImageRef image = self.CGImage;
    CGRect rect = CGRectZero;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    rect.size.width = CGImageGetWidth(image);
    rect.size.height = CGImageGetHeight(image);
    
    bnds = rect;
    
    switch (orient) {
        case UIImageOrientationUp:
            return self;
            break;
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(rect.size.width, rect.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeft:
            bnds = [self swapWidthAndHeight:bnds];
            transform = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeftMirrored:
            bnds = [self swapWidthAndHeight:bnds];
            transform = CGAffineTransformMakeTranslation(rect.size.height, rect.size.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRight:
            bnds = [self swapWidthAndHeight:bnds];
            transform = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored:
            bnds = [self swapWidthAndHeight:bnds];
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            return self;
    }
    
    UIGraphicsBeginImageContext(bnds.size);
    context = UIGraphicsGetCurrentContext();
    
    switch (orient) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(context, -1.0, 1.0);
            CGContextTranslateCTM(context, -rect.size.height, 0.0);
            break;
        default:
            CGContextScaleCTM(context, -1.0, 1.0);
            CGContextTranslateCTM(context, 0.0, -rect.size.height);
            break;
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, image);
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}

/**
 垂直翻转
 */
- (UIImage *)flipVertical {
    return [self rotate:UIImageOrientationDownMirrored];
}

/**
 水平翻转
 */
- (UIImage *)flipHorizontal {
    return [self rotate:UIImageOrientationUpMirrored];
}

/**
 将图片旋转radians弧度
 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians {
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGAffineTransform transfrom = CGAffineTransformMakeRotation(radians);
    rotatedViewBox.transform = transfrom;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, rotatedSize.width / 2.0, rotatedSize.height / 2.0);
    CGContextRotateCTM(context, radians);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), self.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 将图片旋转degrees角度
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees {
    return [self imageRotatedByRadians:[self radianToDegrees:degrees]];
    
}


#pragma mark - **************** 二维码生成
//二维码生成
+ (UIImage *)qrImageForString:(NSString *)string ImageSide:(CGFloat)imageSide {
    
    // 1.生成二维码;
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIImage *outPutCIImage = [filter outputImage];
    
    // 2.创建bitmap;
    CGRect extent = CGRectIntegral(outPutCIImage.extent);
    CGFloat scale = MIN(imageSide / CGRectGetWidth(extent), imageSide / CGRectGetHeight(extent));
    
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //width：图片宽度像素
    //height：图片高度像素
    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    //bitmapInfo：指定的位图应该包含一个alpha通道。
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outPutCIImage fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 3.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    //原图
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    
    return outputImage;
}

+ (UIImage *)qrImage:(UIImage *)qrImage WithAddLogoImage:(UIImage *)logoImage LogoImageSide:(CGFloat)logoSide {
    if (qrImage == nil || logoImage == nil) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(qrImage.size, NO, [[UIScreen mainScreen] scale]);
    [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
    [logoImage drawInRect:CGRectMake((qrImage.size.width - logoSide) / 2, (qrImage.size.height - logoSide) / 2, logoSide, logoSide)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - **************** 
- (UIColor *)colorAtPoint:(CGPoint)point {
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        return nil;
    }
    
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
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

+ (UIImage *)imageForCircleHeading:(CircleHeading)heading Rect:(CGRect)rect color:(UIColor *)fillColor {
    CGFloat radius = 0;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    switch (heading) {
        case CircleHeadingTop:
            radius = rect.size.width * 0.5;
            CGContextMoveToPoint(ctx, 0, rect.size.height);
            CGContextAddLineToPoint(ctx, 0, radius);
            CGContextAddArc(ctx, radius, radius, radius, -M_PI_2, -(M_PI + M_PI_2), true);
            CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
            break;
        case CircleHeadingBottom:
            radius = rect.size.width * 0.5;
            CGContextMoveToPoint(ctx, 0, 0);
            CGContextAddLineToPoint(ctx, 0, rect.size.height - radius);
            CGContextAddArc(ctx, radius, rect.size.height - radius, radius, -M_PI_2, -(M_PI + M_PI_2), true);
            CGContextAddLineToPoint(ctx, rect.size.width, 0);
            break;
        case CircleHeadingLeft:
            radius = rect.size.height * 0.5;
            CGContextMoveToPoint(ctx, rect.size.width, 0);
            CGContextAddLineToPoint(ctx, radius, 0);
            CGContextAddArc(ctx, radius, radius, radius, -M_PI_2, -(M_PI + M_PI_2), true);
            CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
            break;
        case CircleHeadingRight:
            radius = rect.size.height * 0.5;
            CGContextMoveToPoint(ctx, 0, 0);
            CGContextAddLineToPoint(ctx, rect.size.width - radius, 0);
            CGContextAddArc(ctx, rect.size.width - radius, radius, radius, -M_PI_2, -(M_PI + M_PI_2), false);
            CGContextAddLineToPoint(ctx, 0, rect.size.height);
            break;
        default:
            break;
    }
    CGContextClosePath(ctx);
    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - --- 私有方法 ---

/**
 Private:图片模糊算法
 */
- (UIImage *)blurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage {
    CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.0) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            int radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s, 0.0722 - 0.0722 * s, 0.0722 - 0.0722 * s, 0,
                0.7152 - 0.7152 * s, 0.7152 + 0.2848 * s, 0.7152 - 0.7152 * s, 0,
                0.2126 - 0.2126 * s, 0.2126 - 0.2126 * s, 0.2126 + 0.7873 * s, 0,
                0, 0, 0, 1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix) / sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // 开启上下文 用于输出图像
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // 开始画底图
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // 开始画模糊效果
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // 添加颜色渲染
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // 输出成品,并关闭上下文
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
    
}

- (CGRect)swapWidthAndHeight:(CGRect)rect {
    CGFloat swap = rect.size.width;
    
    rect.size.width = rect.size.height;
    rect.size.height = swap;
    
    return rect;
}

- (CGFloat)degreesToRadian:(CGFloat)degrees {
    return (M_PI * degrees / 180.0);
}

- (CGFloat)radianToDegrees:(CGFloat)radian {
    return (radian * 180.0) / (M_PI);
}

@end
