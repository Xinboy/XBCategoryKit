//
//  NSNumber+Extension.h
//  Masonry
//
//  Created by Xinbo Hong on 2018/11/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (XB_Extension)

/*　四舍五入 */
/**
 *  @brief  四舍五入
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)roundWithDigit:(NSUInteger)digit;

/**
 *  @brief  取上整
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)ceilWithDigit:(NSUInteger)digit;

/**
 *  @brief  取下整
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)floorWithDigit:(NSUInteger)digit;

//最大,最小,和,平均
+ (CGFloat)maxNumberFromArray:(NSArray *)array;
+ (CGFloat)minNumberFromArray:(NSArray *)array;
+ (CGFloat)sumNumberFromArray:(NSArray *)array;
+ (CGFloat)averageNumberFromArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
