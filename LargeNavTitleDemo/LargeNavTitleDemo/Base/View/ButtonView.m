//
//  ButtonView.m
//
//  Created by tigerAndBull on 2017/12/11.
//  Copyright © 2017年 tigerAndBull. All rights reserved.
//

#import "ButtonView.h"

#import "Masonry.h"

#import "UIView+Frame.h"

@interface ButtonView ()

/** 下划线 */
@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, assign) BOOL animation;

@end

@implementation ButtonView

- (instancetype)initWithType:(ContentType)type {
    self = [super init];
    if (self) {
        self.type = type;
        _lockEnable = YES;
        _spacing = 8.f;
        _titleFont = [UIFont systemFontOfSize:12];
        _currentIndex = 0;
        _defaultColor = [UIColor blackColor];
        _showPageLine = NO;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.type = UnknowType;
        _spacing = 8.f;
        _lockEnable = YES;
        _titleFont = [UIFont systemFontOfSize:12];
        _currentIndex = 0;
        _defaultColor = [UIColor blackColor];
        _showPageLine = NO;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.type = UnknowType;
        _spacing = 8.f;
        _lockEnable = YES;
        _titleFont = [UIFont systemFontOfSize:12];
        _currentIndex = 0;
        _defaultColor = [UIColor blackColor];
        _showPageLine = NO;
    }
    return self;
}

/** 以图片为主 */
- (instancetype)initWithFrame:(CGRect)frame
                       Images:(NSArray <NSString *> *)images
                       titles:(NSArray <NSString *> *)titles
                     delegate:(id<ButtonViewDelegate>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        _currentIndex = 0;
        _spacing = 8.f;
        _showPageLine = NO;
        _lockEnable = YES;
        _titleFont = [UIFont systemFontOfSize:12];
        _defaultColor = [UIColor blackColor];
        self.images = images;
        self.titles = titles;
        if (images.count > 0) {
            if (titles.count > 0) {
                self.type = NormalTypeImageTitles;
            } else {
                self.type = NormalTypeImagesOnly;
            }
        } else {
            if (titles.count > 0) {
                self.type = NormalTypeTitlesOnly;
            } else {
                self.type = UnknowType;
            }
        }
        self.delegate = delegate;
        [self reloadView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                       Images:(NSArray<NSString *> *)images
               selectedImages:(NSArray<NSString *> *)selectedImages
                       titles:(NSArray<NSString *> *)titles
                 defaultColor:(UIColor *)defaultColor
                selectedColor:(UIColor *)selectedColor
                     delegate:(id<ButtonViewDelegate>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        _currentIndex = 0;
        _showPageLine = NO;
        _spacing = 8.f;
        _lockEnable = YES;
        _titleFont = [UIFont systemFontOfSize:12];
        self.images = images;
        self.seletedImages = selectedImages;
        self.titles = titles;
        self.defaultColor = defaultColor;
        self.selectedColor = selectedColor;
        self.delegate = delegate;
        self.type = [self checkType];
        [self reloadView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat screenWidth = self.frame.size.width > 0?self.frame.size.width:[UIScreen mainScreen].bounds.size.width;
    CGFloat width = CGSizeEqualToSize(self.buttonSize, CGSizeZero) ? 44 : self.buttonSize.width;
    CGFloat height = CGSizeEqualToSize(self.buttonSize, CGSizeZero) ? 44 : self.buttonSize.height;
    NSInteger buttonCount = self.buttonArray.count;
    CGFloat distance = (screenWidth - width*buttonCount) / (buttonCount + 1.0);
    
    for (int i = 0; i < buttonCount; i++) {
        UIButton *button = self.buttonArray[i];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(height);
            make.width.mas_equalTo(width);
            make.left.mas_equalTo(self).offset(i*width+distance*(i+1));
        }];
    }
    
    if (self.sliderView.superview) {
        [self.sliderView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(2);
            UIButton *button = self.buttonArray[self.currentIndex];
            make.centerX.mas_equalTo(button);
        }];
    }
}

- (void)reloadView {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.buttonArray removeAllObjects];
    
    if (self.type == UnknowType) {
        self.type = [self checkType];
    }
    
    switch (self.type) {
        case NormalTypeImagesOnly:
            [self addNormalImagesSubviews];
            break;
        case NormalTypeTitlesOnly:
            [self addNormalTitleSubviews];
            break;
        case NormalTypeImageTitles:
            [self addNormalSubviews];
            break;
        case ChangeTypeTitlesOnly:
            [self addStateChangeTitleSubviews];
            break;
        case ChangeTypeImagesOnly:
            [self addStateChangeImagesSubviews];
            break;
        case ChangeTypeImageTitles:
            [self addStateChangeSubviews];
            break;
        case UnknowType:
            return;
    }
    
    if ([self canShowPageLine]) {
        [self addPageLine];
    } else {
        [self removePageLine];
    }
    [self setNeedsLayout];
}

/** 只有文字没有图片的按钮视图 没有状态变化的视图类型 */
- (void)addNormalTitleSubviews {
    
    CGFloat screenWidth = self.frame.size.width > 0?self.frame.size.width:[UIScreen mainScreen].bounds.size.width;
    CGFloat width = CGSizeEqualToSize(self.buttonSize, CGSizeZero) ? 44 : self.buttonSize.width;
    CGFloat height = CGSizeEqualToSize(self.buttonSize, CGSizeZero) ? 44 : self.buttonSize.height;
    NSInteger buttonCount = self.titles.count;
    CGFloat distance = (screenWidth - width*buttonCount) / (buttonCount + 1.0);
    
    for (int i = 0; i < self.titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(width * i + distance *(i + 1), 0, width, height);
        [button setTitle:self.titles[i] forState:(UIControlStateNormal)];
        [button setTitleColor:self.defaultColor forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = 100 + i;
        if (self.titleFont) {
            button.titleLabel.font = self.titleFont;
        }
        [self.buttonArray addObject:button];
        [self addSubview:button];
    }
}
/** 没有状态变化 只有图片的视图 */
- (void)addNormalImagesSubviews {
    
    CGFloat screenWidth = self.frame.size.width > 0?self.frame.size.width:[UIScreen mainScreen].bounds.size.width;
    CGFloat width = CGSizeEqualToSize(self.buttonSize, CGSizeZero) ? 44 : self.buttonSize.width;
    CGFloat height = CGSizeEqualToSize(self.buttonSize, CGSizeZero) ? 44 : self.buttonSize.height;
    NSInteger buttonCount = self.images.count;
    CGFloat distance = (screenWidth - width*buttonCount) / (buttonCount + 1.0);
    
    for (int i = 0; i < self.images.count; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(width * i + distance *(i + 1), 0, width, height);
        [button setImage:[UIImage imageNamed:self.images[i]] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = 100 + i;
        [self.buttonArray addObject:button];
        
        [self addSubview:button];
    }
}

/** 没有状态变化的图文视图类型 */
- (void)addNormalSubviews {
    
    CGFloat screenWidth = self.frame.size.width > 0?self.frame.size.width:[UIScreen mainScreen].bounds.size.width;
    CGFloat width = CGSizeEqualToSize(self.buttonSize, CGSizeZero) ? 44 : self.buttonSize.width;
    CGFloat height = CGSizeEqualToSize(self.buttonSize, CGSizeZero) ? 44 : self.buttonSize.height;
    NSInteger count = MIN(self.images.count, self.titles.count);
    NSInteger buttonCount = count;
    CGFloat distance = (screenWidth - width*buttonCount) / (buttonCount + 1.0);
    
    for (int i = 0; i < count; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(width * i + distance *(i + 1), 0, width, height);
        [button setImage:[UIImage imageNamed:self.images[i]] forState:(UIControlStateNormal)];
        [button setTitle:self.titles[i] forState:(UIControlStateNormal)];
        [button setTitleColor:self.defaultColor forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = 100 + i;
        if (self.titleFont) {
            button.titleLabel.font = self.titleFont;
        }
        [self.buttonArray addObject:button];

        [self addSubview:button];
    }
    [self adjustTitleLabelAndImageView];
}

/** 带有状态变化的纯文字类型 */
- (void)addStateChangeTitleSubviews {
    
    CGFloat screenWidth = self.frame.size.width > 0?self.frame.size.width:[UIScreen mainScreen].bounds.size.width;
    CGFloat width = CGSizeEqualToSize(self.buttonSize, CGSizeZero) ? 44 : self.buttonSize.width;
    CGFloat height = CGSizeEqualToSize(self.buttonSize, CGSizeZero) ? 44 : self.buttonSize.height;
    NSInteger buttonCount = self.titles.count;
    CGFloat distance = (screenWidth - width*buttonCount) / (buttonCount + 1.0);
    
    for (int i = 0; i < self.titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(width * i + distance *(i + 1), 0, width, height);
        [button setTitle:self.titles[i] forState:(UIControlStateNormal)];
        [button setTitleColor:self.defaultColor forState:(UIControlStateNormal)];
        [button setTitleColor:self.selectedColor forState:(UIControlStateSelected)];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = 100 + i;
        if (self.titleFont) {
            button.titleLabel.font = self.titleFont;
        }
        [self.buttonArray addObject:button];
        [self addSubview:button];
        if (self.currentIndex == i) {
            button.selected = YES;
            self.currentIndex = i;
        }
    }
}

/** 带有状态变化 只有图片没有文字的类型 */
- (void)addStateChangeImagesSubviews {
    // 防止崩溃
    NSInteger imageCount = MIN(self.images.count, self.seletedImages.count);
    CGFloat screenWidth = self.frame.size.width > 0?self.frame.size.width:[UIScreen mainScreen].bounds.size.width;
    CGFloat width = CGSizeEqualToSize(self.buttonSize, CGSizeZero) ? 44 : self.buttonSize.width;
    CGFloat height = CGSizeEqualToSize(self.buttonSize, CGSizeZero) ? 44 : self.buttonSize.height;
    NSInteger buttonCount = imageCount;
    CGFloat distance = (screenWidth - width*buttonCount) / (buttonCount + 1.0);
    for (int i = 0; i < imageCount; i++) {
        // 根据button的选中状态来控制button的外观
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(width * i + distance *(i + 1), 0, width, height);
        [button setImage:[UIImage imageNamed:self.images[i]] forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:self.seletedImages[i]] forState:(UIControlStateSelected)];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = 100 + i;
//        button.backgroundColor = [UIColor redColor];
        [self.buttonArray addObject:button];
        [self addSubview:button];
        if (self.currentIndex == i) {
            button.selected = YES;
            self.currentIndex = i;
        }
    }
}

/** 带有状态变化的视图类型 */
- (void)addStateChangeSubviews {
    // 防止崩溃
    NSInteger imageCount = MIN(self.images.count, self.seletedImages.count);
    NSInteger minCount = MIN(imageCount, self.titles.count);
    CGFloat screenWidth = self.frame.size.width > 0?self.frame.size.width:[UIScreen mainScreen].bounds.size.width;
    CGFloat width = CGSizeEqualToSize(self.buttonSize, CGSizeZero) ? 44 : self.buttonSize.width;
    CGFloat height = CGSizeEqualToSize(self.buttonSize, CGSizeZero) ? 44 : self.buttonSize.height;
    NSInteger buttonCount = minCount;
    CGFloat distance = (screenWidth - width*buttonCount) / (buttonCount + 1.0);
    for (int i = 0; i < minCount; i++) {
        // 根据button的选中状态来控制button的外观
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(width * i + distance *(i + 1), 0, width, height);
        [button setImage:[UIImage imageNamed:self.images[i]] forState:(UIControlStateNormal)];
        [button setTitle:self.titles[i] forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:self.seletedImages[i]] forState:(UIControlStateSelected)];
        [button setTitleColor:self.defaultColor forState:(UIControlStateNormal)];
        [button setTitleColor:self.selectedColor forState:(UIControlStateSelected)];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = 100 + i;
//        button.backgroundColor = [UIColor redColor];
        [self.buttonArray addObject:button];
        [self addSubview:button];
        if (self.currentIndex == i) {
            button.selected = YES;
            self.currentIndex = i;
        }
    }
    [self adjustTitleLabelAndImageView];
}
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont  = titleFont;
    [self adjustTitleLabelAndImageView];
}

- (void)setSpacing:(CGFloat)spacing {
    _spacing = spacing;
    [self adjustTitleLabelAndImageView];
}

- (void)setSeletedImages:(NSArray *)seletedImages {
    _seletedImages = seletedImages;
}

- (void)adjustTitleLabelAndImageView {
    if (self.images.count < 1) {
        return;
    }
    if (self.titles.count < 1) {
        return;
    }
    for (int i = 0; i < self.buttonArray.count; i++) {
        UIButton *button = self.buttonArray[i];
        button.titleLabel.font = _titleFont;
        CGFloat spacing = _spacing;
        CGSize imageSize = button.imageView.frame.size;
        CGSize titleSize = button.titleLabel.frame.size;
        CGSize textSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}];
        CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
        if (titleSize.width + 0.5 < frameSize.width) {
            titleSize.width = frameSize.width;
        }
        CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
        button.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    }
}

- (void)clickAction:(UIButton *)button {
    if (self.animation) {
        return;
    }
    NSInteger index = button.tag - 100;
    NSString *title = self.titles.count > index ? ([self.titles objectAtIndex:index]) : nil;
    [self.delegate didSelectButton:button atIndex:index title:title];
    self.currentIndex = index;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    if (currentIndex >= self.buttonArray.count) {
        return;
    }
    if (_currentIndex == currentIndex && !self.sizeChangeEnable) {
        return;
    }
    UIButton *button = self.buttonArray[_currentIndex];
    if (self.lockEnable) {
        button.userInteractionEnabled = YES;
    }
    if (self.type >= ChangeTypeTitlesOnly) {
        button.selected = NO;
    }
    if (self.sizeChangeEnable && self.scale > 0) {
        button.transform = CGAffineTransformIdentity;
    }
    _currentIndex = currentIndex;
    button = self.buttonArray[_currentIndex];
    if (self.lockEnable) {
        button.userInteractionEnabled = NO;
    }
    if (self.type >= ChangeTypeTitlesOnly) {
        button.selected = YES;
    }
    if (self.sizeChangeEnable && self.scale > 0) {
        button.transform = CGAffineTransformMakeScale(self.scale, self.scale);
    }
    if ([self canShowPageLine]) {
        [self.lock lock];
        [UIView animateWithDuration:0.2 animations:^{
            self.animation = YES;
            self.sliderView.centerX = button.centerX;
        } completion:^(BOOL finished) {
            self.animation = NO;
            self.sliderView.centerX = button.centerX;
        }];
        [self.lock unlock];
    }
}

- (void)setShowPageLine:(BOOL)showPageLine {
    _showPageLine = showPageLine;
    if (showPageLine) {
        [self addPageLine];
    } else {
        [self removePageLine];
    }
}

- (void)addPageLine {
    if (self.sliderView.hidden) {
        self.sliderView.hidden = NO;
    }
    if (self.type <= NormalTypeImageTitles) {
        self.sliderView.backgroundColor = self.lineColor ? : self.defaultColor;
    } else {
        self.sliderView.backgroundColor = self.lineColor ? : self.selectedColor;
    }
    if (self.sliderView.superview) {
        return;
    }
    if (self.currentIndex < self.buttonArray.count) {
        self.sliderView.frame = CGRectMake(0, self.bottom-2, 50, 2);
        UIButton *button = self.buttonArray[_currentIndex];
        self.sliderView.width = 30;
        self.sliderView.height = 2;
        self.sliderView.bottom = self.bottom;
        self.sliderView.centerX = button.centerX;
        [self addSubview:self.sliderView];
        [self setNeedsLayout];
    }
}

- (void)removePageLine {
    if (!self.sliderView.hidden) {
        self.sliderView.hidden = YES;
    }
    if (!self.sliderView.superview) {
        return;
    }
    [self.sliderView removeFromSuperview];
}

- (void)setDefaultColor:(UIColor *)defaultColor {
    _defaultColor = defaultColor;
    if (self.buttonArray.count > 0) {
        for (UIButton *button in self.buttonArray) {
            [button setTitleColor:defaultColor forState:(UIControlStateNormal)];
        }
    }
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    if (self.buttonArray.count > 0) {
        for (UIButton *button in self.buttonArray) {
            [button setTitleColor:selectedColor forState:(UIControlStateSelected)];
        }
    }
}

- (ContentType)checkType {
    ContentType type = UnknowType;
    if (self.images.count > 0) {
        if (self.seletedImages.count > 0) {
            if (self.titles.count > 0) {
                type = ChangeTypeImageTitles;
            } else {
                type = ChangeTypeImagesOnly;
            }
        } else {
            if (self.titles.count > 0) {
                type = NormalTypeImageTitles;
            } else {
                type = NormalTypeImagesOnly;
            }
        }
    } else {
        
        if (self.titles.count > 0) {
            if (self.colorChangeEnable) {
                type = ChangeTypeTitlesOnly;
            } else {
                type = NormalTypeTitlesOnly;
            }
        } else {
            type = UnknowType;
        }
    }
    return type;
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}

- (UIView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[UIView alloc] init];
    }
    return _sliderView;
}

- (NSLock *)lock {
    if (!_lock) {
        _lock = [[NSLock alloc] init];
    }
    return _lock;
}

@end
