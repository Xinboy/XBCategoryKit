//
//  UILabel+Extension.m
//  Masonry
//
//  Created by Xinbo Hong on 2018/11/20.
//

#import "UILabel+Extension.h"
#import <CoreText/CoreText.h>

@implementation UILabel (Extension)

/**
 *  设置字间距
 */
- (void)setColumnSpace:(CGFloat)columnSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(columnSpace) range:NSMakeRange(0, attributedString.length)];
    
    self.attributedText = attributedString;
}

/**
 *  设置行距
 */
- (void)setRowSpace:(CGFloat)rowSpace {
    self.numberOfLines = 0;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
    
    self.attributedText = attributedString;
}


@end
