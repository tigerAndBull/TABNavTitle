//
//  CustomNavigationBar.m
//
//  Created by tigerAndBull on 2018/9/3.
//  Copyright © 2018年 tigerAndBull. All rights reserved.
//

#import "CustomNavigationBar.h"

#import "TABDefine.h"

#import "Masonry.h"

@interface CustomNavigationBar ()

@property (nonatomic, assign) BOOL showBackButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIView *statusView;
@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UIView *sepView;

@end

@implementation CustomNavigationBar

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.statusView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        
        CGFloat statusHeight;
        if (isIPhoneFill) {
            statusHeight = 44;
        }else {
            statusHeight = 20;
        }
        make.height.mas_equalTo(statusHeight);
        // 由于present了一个隐藏statusBar的vc，此方法可能得到一个空值。
        // make.height.mas_equalTo([UIApplication sharedApplication].statusBarFrame.size.height);
    }];
    
    [self.navigationView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self.statusView.mas_bottom);
    }];
    
    if (self.showBackButton) {
        
        [self.backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(44);
            make.centerY.mas_equalTo(self.navigationView);
            make.left.mas_equalTo(0);
        }];
        
        [self.customSearchBar mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.backButton);
            make.left.mas_equalTo(self.backButton.mas_right).offset(0);
            make.right.mas_equalTo(self).offset(-10);
        }];
    } else {
        
        [self.customSearchBar mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.navigationView);
            make.left.mas_equalTo(self).offset(30);
            make.right.mas_equalTo(self).offset(-30);
        }];
    }
    
    [self.sepView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - Class Method

+ (CGSize)selfSize {
    CGFloat statuHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navigationHeight = 44;
    return CGSizeMake(kScreenWidth, statuHeight + navigationHeight);
}

#pragma mark - Target

- (void)backAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(customNavigationBarBackAction)]) {
        [self.delegate customNavigationBarBackAction];
    }
}

#pragma mark - Initize Method

- (instancetype)initWithFrame:(CGRect)frame
               showBackButton:(BOOL)show
                     delegate:(id<CustomNavigationBarDelegate>)delegate {
    
    CGSize size = [CustomNavigationBar selfSize];
    
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, size.width, size.height)];
    
    if (self) {
        
        self.showBackButton = show;
        self.delegate = delegate;
        
        [self addSubview:self.statusView];
        [self addSubview:self.navigationView];
        [self addSubview:self.sepView];
        
        if (show) {
            [self.navigationView addSubview:self.backButton];
        }
        [self.navigationView addSubview:self.customSearchBar];
    }
    return self;
}

#pragma mark - Lazy Method

// 代替状态栏位置的视图
- (UIView *)statusView {
    if (!_statusView) {
        _statusView = [[UIView alloc] init];
        _statusView.backgroundColor = [UIColor clearColor];
    }
    return _statusView;
}

// 导航栏显示区域
- (UIView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[UIView alloc] init];
        _navigationView.backgroundColor = [UIColor clearColor];
    }
    return _navigationView;
}

- (UISearchBar *)customSearchBar {
    if (!_customSearchBar) {
        _customSearchBar = [[UISearchBar alloc] init];
        _customSearchBar.barTintColor = [UIColor clearColor];
        _customSearchBar.backgroundImage = [[UIImage alloc] init];
    }
    return _customSearchBar;
}

- (UIView *)sepView {
    if (!_sepView) {
        _sepView = [[UIView alloc] init];
        _sepView.backgroundColor = kColor(0xF0F0F0FF);
    }
    return _sepView;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"back"];
        [_backButton setImage:image forState:UIControlStateNormal];
        [_backButton setImage:image forState:(UIControlStateHighlighted)];
        [_backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
