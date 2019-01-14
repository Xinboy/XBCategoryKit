//
//  UITableViewCell+XB_Extension.m
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2018/12/26.
//  Copyright © 2018年 Xinboy. All rights reserved.
//

#import "UITableViewCell+XB_Extension.h"

@implementation UITableViewCell (XB_Extension)

- (void)hiddenBottomLine {
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 500);
    [self setEdgeInsets:insets];
}

- (void)showWholeBottomLine {
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self setEdgeInsets:insets];
}

- (void)showBottomLineWithEqualSpace:(CGFloat)space {
    UIEdgeInsets insets = UIEdgeInsetsMake(0, space, 0, space);
    [self setEdgeInsets:insets];
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInset {
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:edgeInset];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:edgeInset];
    }
}
@end
