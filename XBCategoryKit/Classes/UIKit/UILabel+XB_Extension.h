//
//  UILabel+Extension.h
//  Masonry
//
//  Created by Xinbo Hong on 2018/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (XB_Extension)

/// 添加手势单击事件
- (void)addTarget:(id)target action:(SEL)action;

/// 设置字间距
- (void)setColumnSpace:(CGFloat)columnSpace;

/// 设置行距
- (void)setRowSpace:(CGFloat)rowSpace;

/// 固定宽度，计算字符串尺寸
- (CGSize)contentSizeForWidth:(CGFloat)width;

/// 固定高度，计算字符串尺寸
- (CGSize)contentSizeForHeight:(CGFloat)height;

/// 根据当前Label的宽度，计算字符串尺寸
- (CGSize)contentSize;


/// 根据当前Label的宽度，判断字符串是否截断
- (BOOL)isTruncated;
@end

NS_ASSUME_NONNULL_END
