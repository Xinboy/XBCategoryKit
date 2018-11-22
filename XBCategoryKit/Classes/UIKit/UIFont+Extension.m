

#import "UIFont+Extension.h"
#import <objc/message.h>

#import "UIDevice+Extension.h"

@implementation UIFont (Extension)

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
    
    if ([UIDevice isPlusSizedDevice] || [UIDevice isXSeriesSizedDevice]) {
        return fontSize + 2;
    } else if ([UIDevice isSmallSizedDevice]) {
        return fontSize - 2;
    } else {
        return fontSize;
    }
}


@end
