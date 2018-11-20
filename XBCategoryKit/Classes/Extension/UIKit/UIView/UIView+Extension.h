//
//  UIView+Extension.h
//  Masonry
//
//  Created by Xinbo Hong on 2018/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)


/**
 给view设置圆角
 
 @param value 圆角大小
 @param rectCorner 圆角位置
 */
- (void)setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner;


/**
 截取成图片
 */
- (UIImage *)snapshotImage;

/**
 找到指定类名的subView
 */
- (UIView *)findSubViewWithClass:(Class)subClass;
- (NSArray *)findAllSubViewsWithClass:(Class)subClass;

/**
 找到指定类名的superView对象
 */
- (UIView *)findSuperViewWithClass:(Class)superClass;

/**
 找到view上的第一响应者
 */
- (UIView *)findFirstResponder;

/**
 找到当前view所在的viewcontroler
 */
- (UIViewController *)findViewController;

/**
 所有子视图
 */
- (NSArray *)allSubviews;


@end

NS_ASSUME_NONNULL_END
