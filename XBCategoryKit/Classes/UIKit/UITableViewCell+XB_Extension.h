//
//  UITableViewCell+XB_Extension.h
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2018/12/26.
//  Copyright © 2018年 Xinboy. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (XB_Extension)

- (void)hiddenBottomLine;

- (void)showWholeBottomLine;

- (void)showBottomLineWithEqualSpace:(CGFloat)space;

@end


NS_ASSUME_NONNULL_END
