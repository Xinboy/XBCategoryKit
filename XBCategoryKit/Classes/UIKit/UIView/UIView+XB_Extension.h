//
//  UIView+Extension.h
//  Masonry
//
//  Created by Xinbo Hong on 2018/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XB_Extension)



/// UIView 创建圆角ImageView并插入到视图层级的底部
/// @param radius 圆角尺寸
/// @param borderWidth 圆角宽度
/// @param borderColor 圆角颜色
/// @param bgColor 底部颜色
- (void)setViewCornerWithRoundedCorner:(CGFloat)radius
                           borderWidth:(CGFloat)borderWidth
                           borderColor:(UIColor *)borderColor
                       backGroundColor:(UIColor *)bgColor;

/**
 截取成图片
 */
- (UIImage *)snapshotImage;

/**
 找到指定类名的subView
 */
- (UIView *)subViewWithClass:(Class)subClass;
- (UIView *)subViewWithClass:(Class)subClass ofTag:(NSInteger)tag;

- (NSArray *)subViewsWithClass:(Class)subClass;


/**
 找到指定类名的superView对象
 */
- (UIView *)superViewWithClass:(Class)superClass;



/**
 找到view上的第一响应者
 */
- (UIView *)firstResponder;

/**
 找到当前view所在的viewcontroler
 */
- (UIViewController *)findViewController;

/**
 所有子视图
 */
- (NSArray *)allSubviews;

/**
 执行指定持续时间的交叉淡入淡出过渡
 */
- (void)crossfadeWithDuration:(NSTimeInterval)duration;
- (void)crossfadeWithDuration:(NSTimeInterval)duration completion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
