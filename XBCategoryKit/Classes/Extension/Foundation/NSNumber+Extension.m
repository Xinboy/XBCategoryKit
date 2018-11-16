//
//  NSNumber+Extension.m
//  Masonry
//
//  Created by Xinbo Hong on 2018/11/16.
//

#import "NSNumber+Extension.h"

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

@end
