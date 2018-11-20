//
//  UIView+Extension.m
//  Masonry
//
//  Created by Xinbo Hong on 2018/11/20.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

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
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    return result;
    
}


- (UIView *)findSubViewWithClass:(Class)subClass {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:subClass]) {
            return subView;
        }
    }
    return nil;
}
- (NSArray *)findAllSubViewsWithClass:(Class)subClass {
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


- (UIView *)findSuperViewWithClass:(Class)superClass {
    if (self == nil) {
        return nil;
    } else if (self.superview == nil) {
        return nil;
    } else if ([self.superview isKindOfClass:superClass]) {
        return self.superview;
    } else {
        return [self.superview findSuperViewWithClass:superClass];
    }
    
}


- (UIView *)findFirstResponder {
    if (([self isKindOfClass:[UITextField class]] || [self isKindOfClass:[UITextView class]]) && self.isFirstResponder) {
        return self;
    }
    for (UIView *view in self.subviews) {
        UIView *fv = [view findFirstResponder];
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

@end
