//
//  UITextView+XB_Extension.m
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/1/9.
//  Copyright © 2019年 Xinboy. All rights reserved.
//

#import "UITextView+XB_Extension.h"

@implementation UITextView (XB_Extension)

- (void)contentSizeToFitCenter {
    if (self.text.length > 0) {
        CGSize contentSize = self.contentSize;
        UIEdgeInsets offset;
        CGSize newSize = contentSize;
        if (contentSize.height <= self.frame.size.height) {
            CGFloat offsetY = (self.frame.size.height - contentSize.height) * 0.5;
            offset = UIEdgeInsetsMake(offsetY, 0, 0, 0);
        } else {
            newSize = self.frame.size;
            offset = UIEdgeInsetsZero;
            CGFloat fontSize = 18;
            //通过一个while循环，设置textView的文字大小，使内容不超过整个textView的高度（这个根据需要可以自己设置）
            while (contentSize.height > self.frame.size.height) {
                [self setFont:[UIFont fontWithName:self.font.fontName size:fontSize--]];
                contentSize = self.contentSize;
            }
            newSize = contentSize;
        }
        
        [self setContentSize:newSize];
        [self setContentInset:offset];
    }
}

@end
