//
//  CALayer+XB_Extension.h
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/12/24.
//  Copyright © 2019 Xinboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AppKit/AppKit.h>

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (XB_Extension)

/// 阴影设置
- (void)setShadow:(UIColor *)shadowColor
            alpha:(CGFloat)shadowAlpha
           offset:(CGSize)shadowOffset
             blur:(CGFloat)shadowBlur spread:(CGFloat)shadowSpread;
@end

NS_ASSUME_NONNULL_END
