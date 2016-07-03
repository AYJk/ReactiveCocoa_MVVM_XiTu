//
//  BaseNavigationController.m
//  LuQian
//
//  Created by AYJk on 16/5/20.
//  Copyright © 2016年 AYJk. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

//- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated {
//    
//    AYLog(@"%@",self.viewControllers);
//    [super popViewControllerAnimated:animated];
//    return self.viewControllers[self.viewControllers.count - 1];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBarTintColor:UIColorFromRGB(241, 196, 15, 1)];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    
//    return UIStatusBarStyleLightContent;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
