//
//  UILabel+Extension.m
//  Masonry
//
//  Created by Xinbo Hong on 2018/11/20.
//

#import "UILabel+XB_Extension.h"
#import <CoreText/CoreText.h>

@implementation UILabel (XB_Extension)

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

- (CGSize)contentSizeForWidth:(CGFloat)width {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    CGRect contentFrame = [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:@{NSFontAttributeName: self.font}
                                                  context:nil];
    
    return contentFrame.size;
}

- (CGSize)contentSizeForHeight:(CGFloat)height {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    CGRect contentFrame = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:@{NSFontAttributeName: self.font}
                                                  context:nil];
    
    return contentFrame.size;
}

- (CGSize)contentSize {
    return [self contentSizeForWidth:self.bounds.size.width];
}

- (BOOL)isTruncated {
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName : self.font}
                                          context:nil].size;
    
    return (size.height > self.frame.size.height);
}


@end
