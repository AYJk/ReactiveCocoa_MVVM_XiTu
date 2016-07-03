//
//  HomeViewController.m
//  PMXiTu
//
//  Created by AYJk on 16/6/5.
//  Copyright © 2016年 AYJk. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HomeViewModel.h"
#import "AYScrollMenu.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#import <AFNetworking/AFNetworking.h>
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

#import <Masonry/Masonry.h>
#define kNavigatinBarHeight 64
#define kScrollMenuHeight 35
#define kTabBarHeight 49
@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) HomeViewModel *homeViewModel;
@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic, strong) AYScrollMenu *scrollMenu;
@end
static NSString *homeCellID = @"homeCellID";
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.menuArray = @[@"全部", @"Android", @"设计", @"前端", @"iOS", @"后端", @"产品", @"工具资源", @"阅读"];
    self.homeViewModel = [[HomeViewModel alloc] init];
    [self configurationSubViews];
//    [self.homeViewModel fetchEntryData];
//    AYLog(@"%@",[HomeViewController getIPAddresses]);
    [self urlRequestOperation];
}

-(void)urlRequestOperation{
//    NSString *URLTmp = @"http://ip.taobao.com/service/getIpInfo.php?ip=myip";
    NSString *URLTmp = @"http://www.weather.com.cn/data/sk/101110101.html";
//    NSString *URLTmp1 = [URLTmp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manger GET:URLTmp parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
        for (NSHTTPCookie *tempCookie in cookies) {
            NSLog(@"%@",tempCookie);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)configurationSubViews {
    UIScrollView *homeScrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(kNavigatinBarHeight, 0, 0, 0));
        }];
        for (int index = 0; index < self.menuArray.count; index ++) {
            [scrollView addSubview:({
                UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(index * MainBounds.size.width, 0, MainBounds.size.width, MainBounds.size.height - kNavigatinBarHeight - kTabBarHeight) style:UITableViewStyleGrouped];
                tableView.backgroundColor = UIColorFromRGB(224, 224, 224, 1);
                tableView.delegate = self;
                tableView.dataSource = self;
                [tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:homeCellID];
                tableView;
            })];
        }
        scrollView.pagingEnabled = YES;
        scrollView.contentSize = CGSizeMake(MainBounds.size.width * self.menuArray.count, 0);
        scrollView;
    });
    self.scrollMenu = ({
        AYScrollMenu *scrollMenu = [[AYScrollMenu alloc] init];
        [self.view addSubview:scrollMenu];
        [scrollMenu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(kNavigatinBarHeight);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.height.mas_equalTo(kScrollMenuHeight);
        }];
        scrollMenu.menuArray = self.menuArray;
        scrollMenu;
    });
    
//    UITableView *homeTableView = ({
//        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScrollMenuHeight + kNavigatinBarHeight, MainBounds.size.width, MainBounds.size.height - kNavigatinBarHeight - kScrollMenuHeight - kTabBarHeight) style:UITableViewStyleGrouped];
//        [self.view addSubview:tableView];
//        tableView.backgroundColor = UIColorFromRGB(224, 224, 224, 1);
//        tableView.delegate = self;
//        tableView.dataSource = self;
//        [tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:homeCellID];
//        tableView;
//    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 228.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section != 9) {
        return 10;
    } else {
        return .01;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeTableViewCell *homeTableViewCell = ({
        HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCellID forIndexPath:indexPath];
        cell;
    });
    return homeTableViewCell;
}

//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView removeObserver:cell forKeyPath:@"contentOffset"];
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView addObserver:cell forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
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
