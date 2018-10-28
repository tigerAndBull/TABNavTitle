//
//  BaseTabbarController.m
//
//  Created by tigerAndBull on 2017/12/11.
//  Copyright © 2017年 tigerAndBull. All rights reserved.
//

#import "BaseTabbarController.h"
#import "BaseNavigationController.h"

#import "TABDefine.h"

@interface BaseTabbarController ()

@end

@implementation BaseTabbarController

#pragma mark - LifeCycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBar bringSubviewToFront:self.customBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideTabbarNotification:) name:@"hideTabbarNotification" object:nil];
    
    self.selectedIndex = 0;
    
    self.tabBar.translucent = NO;
    [self.tabBar addSubview:self.customBar];
    self.customBar.frame = self.tabBar.bounds;
    
    CGRect rect = self.customBar.frame;
    rect.origin.x -= 20;
    rect.size.width += 40;
    self.customBar.frame = rect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildViewController:(BaseViewController *)vc
                         title:(NSString *)title
                     imageName:(NSString *)imageName
             selectedImageName:(NSString *)selectedImageName
                  NavBackColor:(UIColor *)navBackColor
                 NavTitleColor:(UIColor *)navTitleColor
                  NavTitleFont:(UIFont *)navTitleFont {
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc NavBackColor:navBackColor NavTitleColor:navTitleColor NavTitleFont:navTitleFont];
    // nav.dele
    vc.title = title;
    
    NSMutableArray *titles = self.customBar.titles ? self.customBar.titles.mutableCopy : @[].mutableCopy;
    NSMutableArray *images = self.customBar.images ? self.customBar.images.mutableCopy : @[].mutableCopy;
    NSMutableArray *selectedImages = self.customBar.seletedImages ? self.customBar.seletedImages.mutableCopy : @[].mutableCopy;
    [titles addObject:title];
    [images addObject:imageName];
    [selectedImages addObject:selectedImageName];
    
    self.customBar.titles = titles;
    self.customBar.images = images;
    self.customBar.seletedImages = selectedImages;
    [self.customBar updateBar];
    
    [self addChildViewController:nav];
}

#pragma mark - Notification Method

- (void)hideTabbarNotification:(NSNotification *)notification {
    
}

#pragma mark - CustomTabBarDelegate

- (void)didSelectIndex:(NSInteger)index {
    self.selectedIndex = index;
}

#pragma mark - 屏幕旋转

// 是否自动旋转,返回YES可以自动旋转
- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}

// 返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

// 这个是返回优先方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.selectedViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.selectedViewController;
}

#pragma mark - Initize Method

- (instancetype)initWithTabbarControllerArray:(NSArray<BaseViewController *> *)controllerArray
                                   TitleArray:(NSArray<NSString *> *)titleArray
                             NormalImageArray:(NSArray<NSString *> *)normalImageArray
                             SelectImageArray:(NSArray<NSString *> *)selectImageArray
                                 DefaultColor:(UIColor *)defaultColor
                                  SelectColor:(UIColor *)selectColor
                                    TitleFont:(UIFont *)titleFont
                                 NavBackColor:(UIColor *)navBackColor
                                NavTitleColor:(UIColor *)navTitleColor
                                 NavTitleFont:(UIFont *)navTitleFont {
    
    self = [super init];
    
    if (self) {
        
        self.customBar.defaultColor = defaultColor;
        self.customBar.selectedColor = selectColor;
        self.customBar.titleFont = titleFont;
        
        for (int i = 0; i < controllerArray.count; i++) {
            BaseViewController *vc = controllerArray[i];
            NSString *title = titleArray[i];
            NSString *normalImg = normalImageArray[i];
            NSString *selectImg = selectImageArray[i];
            [self addChildViewController:vc title:title imageName:normalImg selectedImageName:selectImg NavBackColor:navBackColor NavTitleColor:navTitleColor NavTitleFont:navTitleFont];
        }
    }
    return self;
}

#pragma mark - Lazy Method

- (CustomTabBar *)customBar {
    if (!_customBar) {
        _customBar = [[CustomTabBar alloc] init];
        _customBar.imageTitleSpace = 3.f;
        _customBar.delegate = self;
        _customBar.backgroundColor = [UIColor whiteColor];
    }
    return _customBar;
}

@end
