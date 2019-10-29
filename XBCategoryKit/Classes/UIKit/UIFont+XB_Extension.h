

#import <UIKit/UIKit.h>

@interface UIFont (XB_Extension)

/**
 自适应标准字体

 @param fontSize 字体大小
 @return 标准字体
 */
+ (__kindof UIFont *)systemFontOfAutoSize:(CGFloat)fontSize;


/**
 自适应粗体

 @param fontSize 字体大小
 @return 粗字体
 */
+ (__kindof UIFont *)boldFontOfAutoSize:(CGFloat)fontSize;

/**
 自适应字体
 
 @param fontName 字体名称
 @param size 字体大小
 @return 字体
 */
+ (__kindof UIFont *)fontWithName:(NSString *)fontName autoSize:(CGFloat)size;


/**
 根据机型调整数值(±2)

 @param fontSize 数值
 @return 调整后的数值
 */
+ (CGFloat)fontSizeWithSize:(CGFloat)fontSize;




/*
 方法函数: controlInLightViewController:
 方法名称: 控制灯
 方法Tag: 1001 开灯, 1002 关灯, 1003 降低亮度, 1004 增加亮度
 */
+ (__kindof UIFont *)fontWithName:(NSString *)fontName autoSize:(CGFloat)size;

@end
