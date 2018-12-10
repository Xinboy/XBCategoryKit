//
//  UIView+placeholderView2.m
//  PlaceholderView
//
//  Created by Xinbo Hong on 2017/10/8.
//  Copyright © 2017年 Xinbo Hong. All rights reserved.
//

#import "UIView+XB_PlaceholderView.h"
#import <objc/runtime.h>

#import <Masonry/Masonry.h>

#import "UIColor+XB_Extension.h"
#import "UIFont+XB_Extension.h"
@interface UIView ()

@property (nonatomic, copy) reloadButtonAction reloadButtonAction;

//自定义的蒙版图
@property (nonatomic, strong) PlaceholderView *placeholderView;

/** 用来记录UIScrollView最初的scrollEnabled */
@property (nonatomic, assign, getter=isOriginalScrollEnabled) BOOL originalScrollEnabled;


@end


@implementation UIView (placeholderView)

#pragma mark - **************** 手动 getter/setter 加载

static void *placeholderViewKey = &placeholderViewKey;
static void *originalScrollEnabledKey = &originalScrollEnabledKey;
static void *reloadButtonActionKey = &reloadButtonActionKey;

- (UIView *)placeholderView {
    return objc_getAssociatedObject(self, &placeholderViewKey);
}

- (void)setPlaceholderView:(UIView *)placeholderView {
    objc_setAssociatedObject(self, &placeholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)originalScrollEnabled {
    return [objc_getAssociatedObject(self, &originalScrollEnabledKey) boolValue];
}

- (void)setOriginalScrollEnabled:(BOOL)originalScrollEnabled {
    objc_setAssociatedObject(self, &originalScrollEnabledKey, @(originalScrollEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (reloadButtonAction)reloadButtonAction {
    return objc_getAssociatedObject(self, &reloadButtonActionKey);
}

- (void)setReloadButtonAction:(reloadButtonAction)reloadButtonAction {
    objc_setAssociatedObject(self, &reloadButtonActionKey, reloadButtonAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - **************** 外露接口
- (void)showPlaceholderView {
    [self showPlaceholerViewWithType:PlaceholderViewTypeOther reloadBlock:nil];
}

- (void)showPlaceholerViewWithType:(PlaceholderViewType)type reloadBlock:(reloadButtonAction)reloadBlock {
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        self.originalScrollEnabled = scrollView.scrollEnabled;
    }
    
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        self.originalScrollEnabled = scrollView.scrollEnabled;
        scrollView.scrollEnabled = NO;
    }
    
    /** 占位图*/
    if (self.placeholderView) {
        [self.placeholderView removeFromSuperview];
        self.placeholderView = nil;
    }
    self.placeholderView = [[PlaceholderView alloc] init];
    self.placeholderView.backgroundColor = self.backgroundColor;
    
    [self addSubview:self.placeholderView];
    
    /*使用 frame 或 masonry 根据实际项目进行选择*/
    self.placeholderView.frame = self.bounds;
    
    if (reloadBlock) {
        self.reloadButtonAction = reloadBlock;
    }
    
    /*可以在这里根据不同的情况对placeholderView的样式进行更改*/
    //...
}


- (void)removePlaceholderView {
    if (self.placeholderView) {
        [self.placeholderView removeFromSuperview];
        self.placeholderView = nil;
    }
    // 复原UIScrollView的scrollEnabled
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        scrollView.scrollEnabled = self.originalScrollEnabled;
    }
}

@end




#pragma mark - --- PlaceholderView 视图 ---
@implementation PlaceholderView


- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:240 / 255.0 alpha:1.0f];
        [self addSubview:self.iconImageView];
        [self addSubview:self.infoLabel];
    }
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self setupMasonry];
    [self layoutIfNeeded];
}

- (void)setupMasonry {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-40);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(114);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(20);
        make.centerX.equalTo(self);
        make.width.equalTo(self);
        make.height.mas_equalTo(18);
    }];
    
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.image = [UIImage imageNamed:@"placeholder_icon_norecord"];
    }
    return _iconImageView;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        self.infoLabel = [[UILabel alloc] init];
        self.infoLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" autoSize:18];
        self.infoLabel.textColor = [UIColor colorWithHexInt:0xCCCCCC];
        self.infoLabel.textAlignment = NSTextAlignmentCenter;
        self.infoLabel.text = @"暂时没有记录哦";
    }
    return _infoLabel;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
