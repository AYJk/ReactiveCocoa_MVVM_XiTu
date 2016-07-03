//
//  TabBarController.m
//  ReactiveCocoa_MVVM_XiTu
//
//  Created by Andy on 15/9/2.
//  Copyright (c) 2015年 Andy. All rights reserved.
//

#import "AYTabBarController.h"
#import "AYTabBarButton.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "MessageViewController.h"
#import "UserCenterViewController.h"
#import "BaseNavigationController.h"
//  删除原生的UITabbarButton
#define AYPopTabBarNotification @"AYPopTabBarNotification"
@interface AYTabBarController ()

@property (nonatomic, weak) AYTabBarButton *lastBtn;
@property (nonatomic, weak) UILabel *lastLabel;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) NSMutableArray *labelArray;
@end

@implementation AYTabBarController

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AYPopTabBarNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubViewController];
    [self creatTabBarItems];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTabBarButton) name:AYPopTabBarNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self removeTabBarButton];
}

- (void)removeTabBarButton {
    for (id view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }
}

- (void)creatTabBarItems {
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainBounds.size.width, 49)];
    bgImageView.image = [UIImage imageNamed:@"xzzm_Tabbar_tabBg"];
    [self.tabBar addSubview:bgImageView];

    NSArray *normalImgNames = @[@"home_26x26_",@"explore_26x26_",@"newsfeed_26x26_",@"profile_26x26_"];
    NSArray *highLightImhNames = @[@"homePress_26x26_",@"explorePress_26x26_",@"newsfeedPress_26x26_",@"profilePress_26x26_"];
    NSArray *tabbarLabelNames = @[@"首页",@"发现",@"消息",@"个人中心"];
//    CGFloat tabbarEachWidth = MainBounds.size.width / normalImgNames.count;
    CGFloat buttonWidth = MainBounds.size.width / normalImgNames.count;
    CGFloat buttonHeight = 49;
    _btnArray = [NSMutableArray array];
    _labelArray = [NSMutableArray array];
    for (int index = 0; index < normalImgNames.count; index ++) {
        AYTabBarButton *tabbarBtn = [[AYTabBarButton alloc] initWithFrame:CGRectMake(index * buttonWidth, 3, buttonWidth, buttonHeight)];
        [tabbarBtn setImageEdgeInsets:UIEdgeInsetsMake(-10, (buttonWidth - 32) * .5, 10, (buttonWidth - 32) * .5)];
        [tabbarBtn setImage:[UIImage imageNamed:normalImgNames[index]] forState:UIControlStateNormal];
        [tabbarBtn setImage:[UIImage imageNamed:highLightImhNames[index]] forState:UIControlStateSelected];
        [tabbarBtn setImage:[UIImage imageNamed:highLightImhNames[index]] forState:UIControlStateHighlighted];
        tabbarBtn.tag = index + 100;
        [tabbarBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [tabbarBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *tabbarLabel = [[UILabel alloc] initWithFrame:CGRectMake(index * buttonWidth, 35, buttonWidth, 12)];
        tabbarLabel.text = tabbarLabelNames[index];
        tabbarLabel.textColor = UIColorFromRGB(110, 110, 110, 1);
        tabbarLabel.textAlignment = NSTextAlignmentCenter;
        tabbarLabel.font = [UIFont systemFontOfSize:12.0];
        [self.tabBar addSubview:tabbarLabel];
        [self.tabBar addSubview:tabbarBtn];
        [_btnArray addObject:tabbarBtn];
        [_labelArray addObject:tabbarLabel];
        if (index == 0) {
            _lastBtn = tabbarBtn;
            _lastLabel = tabbarLabel;
            tabbarBtn.selected = YES;
            tabbarLabel.textColor = UIColorFromRGB(1, 118, 255, 1);
        }
    }
}

- (void)creatSubViewController {
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    DiscoverViewController *disscoverVC = [[DiscoverViewController alloc] init];
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    UserCenterViewController *userCenterVC = [[UserCenterViewController alloc] init];
    NSArray *subViewCtrllerArray = @[homeVC,disscoverVC,messageVC,userCenterVC];
    NSMutableArray *vcMutableArray = [NSMutableArray array];
    for (int index = 0; index < subViewCtrllerArray.count; index ++) {
        BaseNavigationController *naviCtrl = [[BaseNavigationController alloc] initWithRootViewController:subViewCtrllerArray[index]];
        [vcMutableArray addObject:naviCtrl];
    }
    self.viewControllers = vcMutableArray;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    AYTabBarButton *btn = _btnArray[selectedIndex];
    UILabel *label = _labelArray[selectedIndex];
    if (btn != _lastBtn) {
        btn.selected = YES;
        _lastBtn.selected = NO;
        label.textColor = UIColorFromRGB(1, 118, 255, 1);
        _lastLabel.textColor = UIColorFromRGB(110, 110, 110, 1);
    }
    _lastBtn = btn;
    _lastLabel = label;
}

- (void)btnAction:(UIButton *)btn {
    self.selectedIndex = btn.tag - 100;
}

@end
