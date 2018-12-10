//
//  UIView+Init.h
//  Masonry
//
//  Created by Xinbo Hong on 2018/11/16.
//
// 快速创建子控件实例
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XB_Init)

+ (instancetype)viewForXib;
#pragma mark - --- Masonry 创建控件 ---

+ (UIView *)viewWithBackgroundColor:(UIColor *)color;

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)color titleFont:(UIFont *)font image:(NSString *)imageName;

+ (UIImageView *)imageViewWithImage:(NSString *)imageName;

+ (UILabel *)labelWithTextFont:(UIFont *)font textColor:(UIColor *)color;

+ (UITextField *)textFieldWithTextFont:(UIFont *)font textColor:(UIColor *)color;

+ (UITextView *)textViewWithTextFont:(UIFont *)font textColor:(UIColor *)color;


#pragma mark - --- Frame 创建控件 ---

+ (UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color;

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color titleFont:(UIFont *)font image:(NSString *)imageName;

+ (UILabel *)labelWithFrame:(CGRect)frame textFont:(UIFont *)font textColor:(UIColor *)color;

+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(NSString *)imageName;

+ (UITextField *)textFieldWithFrame:(CGRect)frame textFont:(UIFont *)font textColor:(UIColor *)color;

+ (UITextView *)textViewWithFrame:(CGRect)frame textFont:(UIFont *)font textColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
