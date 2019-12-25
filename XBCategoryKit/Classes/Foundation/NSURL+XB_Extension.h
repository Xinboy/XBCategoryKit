//
//  NSURL+XB_Extension.h
//  XBCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/11/28.
//  Copyright © 2019 Xinboy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (XB_Extension)


/// 通过传入的URL地址打开外部浏览器
/// @param urlString URL地址
+ (void)openScheme:(NSString *)urlString;



/// 获取Document URL Path
+ (NSURL *)getDocumentURLPath;


/// 获取Library URL Path
+ (NSURL *)getLibraryURLPath;


/// 获取Caches URL Path
+ (NSURL *)getCachesURLPath;
@end

NS_ASSUME_NONNULL_END
