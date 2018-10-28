//
//  CustomTabBar.m
//
//  Created by tigerAndBull on 2018/10/27.
//  Copyright © 2018年 tigerAndBull. All rights reserved.
//

#import "CustomTabBar.h"
#import "ButtonView.h"

#import "TABDefine.h"

#import "Masonry.h"

@interface CustomTabBar ()<ButtonViewDelegate>

@property (nonatomic, strong) ButtonView *buttonView;

@end

@implementation CustomTabBar

#pragma mark - Super Method

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(49);
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(self.centerView.frame, point) && !self.isHidden) {
        return self.centerView;
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - Public Method

- (void)updateBar {
    [self.buttonView reloadView];
}

#pragma mark - Private Method

- (void)didSelectButton:(UIButton *)button atIndex:(NSInteger)index title:(NSString *)title {
    [self.delegate didSelectIndex:index];
}

#pragma mark - Class Method

+ (CGSize)barSize {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 49;
    if (isIPhoneFill) {
        height = 49 + 34;
    }
    return CGSizeMake(screenWidth, height);
}

#pragma mark - Initize Method

- (instancetype)initWithImages:(NSArray <NSString *> *)images
                 selectedImage:(NSArray <NSString *> *)selectedImages
                        titles:(NSArray <NSString *> *)titles
                 selectedColor:(UIColor *)selectedColor
                      delegate:(id<CustomTabBarDelegate>)delegate {
    
    CGSize size = [CustomTabBar barSize];
    
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    if (self) {
        CGRect frame = CGRectMake(0, 0, size.width, 49);
        self.buttonView = [[ButtonView alloc] initWithFrame:frame Images:images selectedImages:selectedImages titles:titles defaultColor:[UIColor lightGrayColor] selectedColor:selectedColor delegate:self];
        [self addSubview:self.buttonView];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.buttonView = [[ButtonView alloc] init];
        self.buttonView.delegate = self;
        [self addSubview:self.buttonView];
    }
    return self;
}

#pragma mark - Getter & Setter

- (void)setImageTitleSpace:(CGFloat)imageTitleSpace {
    _imageTitleSpace = imageTitleSpace;
    self.buttonView.spacing = imageTitleSpace;
}

- (void)setSeletedImages:(NSArray *)seletedImages {
    _seletedImages = seletedImages;
    self.buttonView.seletedImages = seletedImages;
}

- (void)setImages:(NSArray *)images {
    _images = images;
    self.buttonView.images = images;
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    self.buttonView.titles = titles;
}

- (void)setCenterView:(UIView *)centerView {
    _centerView = centerView;
}

- (void)setDefaultColor:(UIColor *)defaultColor {
    _defaultColor = defaultColor;
    self.buttonView.defaultColor = defaultColor;
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    self.buttonView.selectedColor = selectedColor;
}

- (void)setSelectedIndex:(NSInteger)index {
    self.buttonView.currentIndex = index;
}

- (void)setTitleFont:(UIFont *)titleFont {
    self.buttonView.titleFont = titleFont;
    [self updateBar];
}
@end
