//
//  XBConstant.h
//  XBCategoryKit
//
//  Created by Xinbo Hong on 2019/1/15.
//  Copyright © 2019年 Xinboy. All rights reserved.
//

#ifndef XBConstant_h
#define XBConstant_h

#import "UIDevice+XB_Extension.h"

/**
 格式为：yyyy/MM/dd的日期字符串

 @return NSDateFormatter
 */
NS_INLINE NSDateFormatter *kDateFormatter() {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    return formatter;
    
}

NS_INLINE NSUserDefaults *kUserDef() {
    return [NSUserDefaults standardUserDefaults];
}

#pragma mark - **************** 普通以及iPhone X的导航栏和菜单栏高度
//关于Device 的判断使用了UIDevice+XB_Extension.h的方法，如果需要，需要加入

//状态栏高度
NS_INLINE CGFloat kStatusBarHeight() {
    return ([UIDevice isCanFaceID] ? 44 : 20);
}
NS_INLINE CGFloat kNavigationBarHeight() {
    return 44;
}
//底部危险区域高度
NS_INLINE CGFloat kBottomDangerArea() {
    return ([UIDevice isCanFaceID] ? 44 : 20);
}
//底部菜单高度
NS_INLINE CGFloat kTabBarHeight() {
    return 49;
}

//顶部状态栏和导航栏的高度之和
NS_INLINE CGFloat kTopBarHeight() {
    return (kStatusBarHeight() + kNavigationBarHeight());
}
//底部菜单和危险区域的高度之和
NS_INLINE CGFloat kBottomBarHeight() {
    return (kTabBarHeight() + kBottomDangerArea());
}
NS_INLINE CGFloat kScreenHeight() {
    return [UIScreen mainScreen].bounds.size.height;
}

NS_INLINE CGFloat kScreenWidth() {
    return [UIScreen mainScreen].bounds.size.width;
}

NS_INLINE CGFloat kScreenWidthScale() {
    return [UIScreen mainScreen].bounds.size.width  / 375;
}

NS_INLINE CGFloat kScreenHeightScale() {
    return [UIScreen mainScreen].bounds.size.height  / 667;
}

NS_INLINE CGFloat kScreenSideScale() {
    return (kScreenHeight() / kScreenWidth()) / 1.779;
}


NS_INLINE BOOL iOS10() {
    return [[UIDevice currentDevice].systemVersion doubleValue] >= 8.0
}

#endif /* XBConstant_h */
