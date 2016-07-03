//
//  BaseViewController.m
//  ReactiveCocoa_MVVM_XiTu
//
//  Created by AYJk on 16/5/20.
//  Copyright © 2016年 AYJk. All rights reserved.
//

#import "BaseViewController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(244, 244, 244, 1);
//    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    if (self.class != NSClassFromString(@"UserCenterViewController")) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"条状"] forBarMetrics:UIBarMetricsDefault];
    } else {
        self.fd_prefersNavigationBarHidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [backButton setImageEdgeInsets:UIEdgeInsetsMake(11, 5, 7, 22)];
        [backButton setImage:[UIImage imageNamed:@"返回a"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"返回b"] forState:UIControlStateHighlighted];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -6;
        UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItems = @[negativeSpacer,backBarItem];
    }
}

- (void)backButtonAction:(UIButton *)backButton {
    [self.navigationController popViewControllerAnimated:YES];
//    AYLog(@"%@",NSStringFromClass(vc.class));
//    if (vc.class == NSClassFromString(@"UserCenterViewController")) {
//        
//    }
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    NSDictionary *titleAttributtes = @{
                                       NSFontAttributeName:[UIFont systemFontOfSize:20.0],
                                       NSForegroundColorAttributeName:UIColorFromRGB(53, 53, 53, 1)
                                       };
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttributtes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
