//
//  UIViewController+Tracking.m
//  XBKit
//
//  Created by Xinbo Hong on 2018/11/6.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "UIViewController+XB_Swizzled.h"
#import <objc/runtime.h>

@implementation UIViewController (XB_Swizzled)

static BOOL isSwizzed;
static NSString *logTag = @"";


+ (void)load {
    isSwizzed = NO;
}


+ (void)swizzInstance:(Class)class originSelector:(SEL)originSEL swizzledSelector:(SEL)swizzledSEL {
    Method originMethod = class_getInstanceMethod(class, originSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
    
    BOOL isAddMethod = class_addMethod(class, originSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (isAddMethod) {
        class_replaceMethod(class, swizzledSEL, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}

- (void)logWithLevel:(NSUInteger)level {
    NSString *paddingItems = @"";
    
    for (NSUInteger i = 0; i <= level; i++) {
        paddingItems = [paddingItems stringByAppendingString:@"---"];
    }
    NSLog(@"%02ld: %@ %@", [logTag integerValue], paddingItems, [self.class description]);
}

#pragma mark -  --- SwizzMethods ---
- (void)printPath {
    if ([self parentViewController] == nil) {
        [self logWithLevel:0];
    } else if ([[self parentViewController] isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)[self parentViewController];
        NSInteger integer = [[nav viewControllers] indexOfObject:self];
        [self logWithLevel:integer];
    } else if ([[self parentViewController] isMemberOfClass:[UITabBarController class]]) {
        [self logWithLevel:1];
    }
}

- (void)xb_viewWillAppear:(BOOL)animated {
    
    [self printPath];
    
    [self xb_viewWillAppear:animated];
}

#pragma mark - --- Public methods ---
+ (void)startSwizz {
    if (isSwizzed) {
        return;
    }
    
    [self swizzInstance:[self class] originSelector:@selector(viewDidAppear:) swizzledSelector:@selector(xb_viewWillAppear:)];
    
    isSwizzed = YES;
}

+ (void)swizzWithTag:(NSString *)tag {
    logTag = tag;
    
    [self startSwizz];
}

+ (void)stopSwizz {
    if (!isSwizzed) {
        return;
    }
    isSwizzed = NO;
    [self swizzInstance:[self class] originSelector:@selector(xb_viewWillAppear:) swizzledSelector:@selector(viewDidAppear:)];
}


@end
