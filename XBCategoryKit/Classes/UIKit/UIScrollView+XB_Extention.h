//
//  UIScrollView+Extention.h
//  Masonry
//
//  Created by Xinbo Hong on 2018/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (XB_Extention)

//截屏
- (UIImage *)snapshotImage;

- (void)scrollToTop;


- (void)scrollToBottom;


- (void)scrollToLeft;


- (void)scrollToRight;


- (void)scrollToTopAnimated:(BOOL)animated;


- (void)scrollToBottomAnimated:(BOOL)animated;


- (void)scrollToLeftAnimated:(BOOL)animated;


- (void)scrollToRightAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
