//
//  UILabel+Extension.h
//  Masonry
//
//  Created by Xinbo Hong on 2018/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extension)

/**
 *  设置字间距
 */
- (void)setColumnSpace:(CGFloat)columnSpace;

/**
 *  设置行距
 */
- (void)setRowSpace:(CGFloat)rowSpace;


- (CGSize)contentSizeForWidth:(CGFloat)width;

- (CGSize)contentSizeForHeight:(CGFloat)height;

- (CGSize)contentSize;

- (BOOL)isTruncated;
@end

NS_ASSUME_NONNULL_END
