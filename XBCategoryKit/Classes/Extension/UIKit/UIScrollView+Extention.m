//
//  UIScrollView+Extention.m
//  Masonry
//
//  Created by Xinbo Hong on 2018/11/16.
//

#import "UIScrollView+Extention.h"

@implementation UIScrollView (Extention)


- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, -self.contentOffset.y);
    [self.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)scrollToTop {
    [self scrollToTopAnimated:YES];
}


- (void)scrollToBottom {
    [self scrollToBottomAnimated:YES];
}


- (void)scrollToLeft {
    [self scrollToLeftAnimated:YES];
}


- (void)scrollToRight {
    [self scrollToRightAnimated:YES];
}


- (void)scrollToTopAnimated:(BOOL)animated {
    CGPoint offset = self.contentOffset;
    offset.y = 0 - self.contentInset.top;
    [self setContentOffset:offset animated:animated];
}

- (void)scrollToBottomAnimated:(BOOL)animated {
    CGPoint offset = self.contentOffset;
    offset.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:offset animated:animated];
}


- (void)scrollToLeftAnimated:(BOOL)animated {
    CGPoint offset = self.contentOffset;
    offset.x = 0 - self.contentInset.left;
    [self setContentOffset:offset animated:animated];
}


- (void)scrollToRightAnimated:(BOOL)animated {
    CGPoint offset = self.contentOffset;
    offset.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:offset animated:animated];
}
@end
