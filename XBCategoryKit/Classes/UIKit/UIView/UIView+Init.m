//
//  UIView+Init.m
//  Masonry
//
//  Created by Xinbo Hong on 2018/11/16.
//

#import "UIView+Init.h"

@implementation UIView (Init)

+ (UIView *)viewWithBackgroundColor:(UIColor *)color {
    UIView *temp = [[UIView alloc] init];
    temp.backgroundColor = color;
    return temp;
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)color titleFont:(UIFont *)font image:(NSString *)imageName {
    UIButton *temp = [UIButton buttonWithType:UIButtonTypeCustom];
    temp.titleLabel.font = font;
    [temp setTitle:title forState:UIControlStateNormal];
    [temp setTitleColor:color forState:UIControlStateNormal];
    [temp setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    return temp;
}

+ (UIImageView *)imageViewWithImage:(NSString *)imageName {
    UIImageView * temp = [[UIImageView alloc] init];
    temp.image = [UIImage imageNamed:imageName];
    return temp;
}

+ (UILabel *)labelWithTextFont:(UIFont *)font textColor:(UIColor *)color {
    UILabel * temp = [[UILabel alloc] init];
    temp.font = font;
    temp.textColor = color;
    return temp;
}

+ (UITextField *)textFieldWithTextFont:(UIFont *)font textColor:(UIColor *)color {
    UITextField * temp = [[UITextField alloc] init];
    temp.font = font;
    temp.textColor = color;
    return temp;
}

+ (UITextView *)textViewWithTextFont:(UIFont *)font textColor:(UIColor *)color {
    UITextView * temp = [[UITextView alloc] init];
    temp.font = font;
    temp.textColor = color;
    return temp;
}

#pragma mark - --- frame ---

+ (UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color {
    UIView *temp = [UIView viewWithBackgroundColor:color];
    temp.frame = frame;
    return temp;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color titleFont:(UIFont *)font image:(NSString *)imageName {
    UIButton *temp = [UIView buttonWithTitle:title titleColor:color titleFont:font image:imageName];
    temp.frame = frame;
    return temp;
}

+ (UILabel *)labelWithFrame:(CGRect)frame textFont:(UIFont *)font textColor:(UIColor *)color {
    UILabel *temp = [UIView labelWithTextFont:font textColor:color];
    temp.frame = frame;
    return temp;
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(NSString *)imageName {
    UIImageView *temp = [UIView imageViewWithImage:imageName];
    temp.frame = frame;
    return temp;
}

+ (UITextField *)textFieldWithFrame:(CGRect)frame textFont:(UIFont *)font textColor:(UIColor *)color {
    UITextField *temp = [UIView textFieldWithTextFont:font textColor:color];
    temp.frame = frame;
    return temp;
}

+ (UITextView *)textViewWithFrame:(CGRect)frame textFont:(UIFont *)font textColor:(UIColor *)color {
    UITextView *temp = [UIView textViewWithTextFont:font textColor:color];
    temp.frame = frame;
    return temp;
}
@end
