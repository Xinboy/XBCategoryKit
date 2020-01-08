//
//  UIViewController+Extention.h
//  XBKit
//
//  Created by Xinbo Hong on 2018/10/15.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (XB_Extention)

/**
 *  获取当前显示的控制器
 *  @return 控制器
 */
+ (UIViewController *)currentViewController;

/**
 *  获取当前显示的导航控制器
 *  @return 控制器
    */
+ (UIViewController *)currentNavigatonController;



@end

NS_ASSUME_NONNULL_END
