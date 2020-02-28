//
//  CALayer+XB_Extension.m
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/12/24.
//  Copyright © 2019 Xinboy. All rights reserved.
//

#import "CALayer+XB_Extension.h"


@implementation CALayer (XB_Extension)

- (void)setShadow:(UIColor *)shadowColor
            alpha:(CGFloat)shadowAlpha
           offset:(CGSize)shadowOffset
             blur:(CGFloat)shadowBlur spread:(CGFloat)shadowSpread {
    
    //设置初始值
    self.shadowColor = UIColor.blackColor.CGColor;
    self.shadowOpacity = 0.5;
    self.shadowOffset = CGSizeMake(2, 0);
    self.shadowRadius = 2;
    
    
    
    if (self.shadowColor != shadowColor.CGColor) {
        self.shadowColor = shadowColor.CGColor;
    }
    if (self.shadowOpacity != shadowAlpha) {
        self.shadowOpacity = shadowAlpha;
    }
    if (!CGSizeEqualToSize(self.shadowOffset, shadowOffset)) {
        self.shadowOffset = shadowOffset;
    }
    
    if (self.shadowRadius != shadowBlur * 0.5) {
        self.shadowRadius = shadowBlur * 0.5;
    }
    
    CGRect rect = CGRectInset(self.bounds, -shadowSpread, -shadowSpread);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];
    self.shadowPath = path.CGPath;
}

@end
