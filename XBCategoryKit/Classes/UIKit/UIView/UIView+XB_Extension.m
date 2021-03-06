//
//  UIView+Extension.m
//  Masonry
//
//  Created by Xinbo Hong on 2018/11/20.
//

#import "UIView+XB_Extension.h"

@implementation UIView (XB_Extension)

- (void)setViewCornerWithRoundedCorner:(CGFloat)radius
                           borderWidth:(CGFloat)borderWidth
                           borderColor:(UIColor *)borderColor
                       backGroundColor:(UIColor *)bgColor {
    CGSize size = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    
    CGFloat halfBorderWidth = borderWidth * 0.5;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    CGContextMoveToPoint(context, width - halfBorderWidth, radius + halfBorderWidth);
    // 右下角角度
    CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);
    // 左下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius);
    // 左上角角度
    CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius);
    // 右上角角度
    CGContextAddArcToPoint(context, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius);
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    imageView.image = image;
    [self insertSubview:imageView atIndex:0];
    
}


- (void)setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner {
    
    [self layoutIfNeeded];//这句代码很重要，不能忘了
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(value, value)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
    
}

- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}


- (UIView *)subViewWithClass:(Class)subClass {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:subClass]) {
            return subView;
        }
    }
    return nil;
}

- (UIView *)subViewWithClass:(Class)subClass ofTag:(NSInteger)tag {
    UIView *view = [self viewWithTag:tag];
    
    if (view == nil) {
        return nil;
    }
    if ([view isKindOfClass:subClass]) {
        return view;
    } else {
        return nil;
    }
    
}

- (NSArray *)subViewsWithClass:(Class)subClass {
    NSMutableArray *array = [NSMutableArray array];
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:subClass]) {
            [array addObject:subView];
        }
    }
    if (array.count > 0) {
        return array;
    } else {
        return nil;
    }
}




- (UIView *)superViewWithClass:(Class)superClass {
    if (self == nil) {
        return nil;
    } else if (self.superview == nil) {
        return nil;
    } else if ([self.superview isKindOfClass:superClass]) {
        return self.superview;
    } else {
        return [self.superview superViewWithClass:superClass];
    }
    
}


- (UIView *)firstResponder {
    if (([self isKindOfClass:[UITextField class]] || [self isKindOfClass:[UITextView class]]) && self.isFirstResponder) {
        return self;
    }
    for (UIView *view in self.subviews) {
        UIView *fv = [view firstResponder];
        if (fv) {
            return fv;
        }
    }
    return nil;
}

- (UIViewController *)findViewController {
    UIResponder * responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    
    return nil;
}


- (NSArray *)allSubviews {
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:self.subviews];
    for (UIView *view in self.subviews) {
        [array addObjectsFromArray:[view allSubviews]];
    }
    return array;
}


- (void)crossfadeWithDuration:(NSTimeInterval)duration {
    CAAnimation *animation = [NSClassFromString(@"CATransition") animation];
    [animation setValue:@"kCATransitionFade" forKey:@"type"];
    animation.duration = duration;
    [self.layer addAnimation:animation forKey:nil];
}

- (void)crossfadeWithDuration:(NSTimeInterval)duration completion:(void (^)(void))completion {
    [self crossfadeWithDuration:duration];
    if (completion) {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}
@end
