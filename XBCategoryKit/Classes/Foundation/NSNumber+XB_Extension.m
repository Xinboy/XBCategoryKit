//
//  NSNumber+Extension.m
//  Masonry
//
//  Created by Xinbo Hong on 2018/11/16.
//

#import "NSNumber+XB_Extension.h"

@implementation NSNumber (Extension)


- (NSNumber *)roundWithDigit:(NSUInteger)digit {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    [formatter setMinimumFractionDigits:digit];
    return [NSNumber numberWithDouble:[[formatter stringFromNumber:self] doubleValue]];
}

- (NSNumber *)ceilWithDigit:(NSUInteger)digit {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundCeiling];
    [formatter setMaximumFractionDigits:digit];
    return [NSNumber numberWithDouble:[[formatter stringFromNumber:self] doubleValue]];
}

- (NSNumber *)floorWithDigit:(NSUInteger)digit {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundFloor];
    [formatter setMaximumFractionDigits:digit];
    return [NSNumber numberWithDouble:[[formatter stringFromNumber:self] doubleValue]];
}

+ (CGFloat)maxNumberFromArray:(NSArray *)array {
    CGFloat max = 0;
    max = [[array valueForKeyPath:@"@max.floatValue"] floatValue];
    return max;
}

+ (CGFloat)minNumberFromArray:(NSArray *)array {
    CGFloat min = 0;
    min = [[array valueForKeyPath:@"@min.floatValue"] floatValue];
    return min;
}

+ (CGFloat)sumNumberFromArray:(NSArray *)array {
    CGFloat sum = 0;
    sum = [[array valueForKeyPath:@"@sum.floatValue"] floatValue];
    return sum;
}

+ (CGFloat)averageNumberFromArray:(NSArray *)array {
    CGFloat avg = 0;
    avg = [[array valueForKeyPath:@"@avg.floatValue"] floatValue];
    return avg;
}
@end
