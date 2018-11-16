//
//  XBTest.h
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2018/11/14.
//  Copyright © 2018年 Xinboy. All rights reserved.
//

#import "XBSuperTest.h"

NS_ASSUME_NONNULL_BEGIN

@interface XBTest : XBSuperTest

@property (nonatomic, strong) NSString *string;

@property (nonatomic, strong) NSDictionary *dict;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, assign) NSInteger *intName;


- (void)method1;

- (void)method2;

- (void)method3;
@end

NS_ASSUME_NONNULL_END
