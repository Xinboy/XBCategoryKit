

#import "UIFont+XB_Extension.h"
#import <objc/message.h>

#import "UIDevice+XB_Extension.h"

@implementation UIFont (XB_Extension)

+ (UIFont *)boldFontOfAutoSize:(CGFloat)fontSize {
    return [UIFont boldSystemFontOfSize:[UIFont fontSizeWithSize:fontSize]];
}

+ (UIFont *)systemFontOfAutoSize:(CGFloat)fontSize {

    return [UIFont systemFontOfSize:[UIFont fontSizeWithSize:fontSize]];
}

+ (UIFont *)fontWithName:(NSString *)fontName autoSize:(CGFloat)size {
    return [UIFont fontWithName:fontName size:[UIFont fontSizeWithSize:size]];
}

+ (CGFloat)fontSizeWithSize:(CGFloat)fontSize {
    // iPhone
    if ([UIDevice isPlusSizedPhone]) return fontSize + 2;
    if ([UIDevice isSmallSizedPhone]) return fontSize - 2;
    
    // iPad
    
    // Default
    return fontSize;
}


@end
