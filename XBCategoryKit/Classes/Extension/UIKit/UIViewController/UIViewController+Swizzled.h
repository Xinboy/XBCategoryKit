//
//  UIViewController+Tracking.h
//  XBKit
//
//  Created by Xinbo Hong on 2018/11/6.
//  Copyright © 2018年 Xinbo. All rights reserved.
//
//分类黑魔法，插入断点等信息
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define SWIZZ_TRACK [UIViewController startSwizz];
#define SWIZZ_IT_WITH_TAG(tag) [UIViewController swizzWithTag:tag];

#define UN_SWIZZ_IT [UIViewController stopSwizz];

@interface UIViewController (Swizzled)

//开启黑魔法
+ (void)startSwizz;

//关闭黑魔法
+ (void)stopSwizz;

//开启黑魔法
+ (void)swizzWithTag:(NSString *)tag;



@end

NS_ASSUME_NONNULL_END
