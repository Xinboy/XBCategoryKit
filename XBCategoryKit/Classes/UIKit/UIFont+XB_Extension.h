

#import <UIKit/UIKit.h>

@interface UIFont (XB_Extension)

/// 标准字体自适应
/// @param size 初始字体尺寸
+ (__kindof UIFont *)systemFontOfAutoSize:(CGFloat)fontSize;

/// 粗体自适应
/// @param size 初始字体尺寸
+ (__kindof UIFont *)boldFontOfAutoSize:(CGFloat)fontSize;

/// 字体自适应
/// @param fontName 字体名字
/// @param size 初始字体尺寸
+ (__kindof UIFont *)fontWithName:(NSString *)fontName autoSize:(CGFloat)size;


/// 字体大小根据机型调整数值(±2)
/// @param fontSize 初始字体尺寸
+ (CGFloat)fontSizeWithSize:(CGFloat)fontSize;

@end
