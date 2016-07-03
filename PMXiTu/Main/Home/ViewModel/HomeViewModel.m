//
//  HomeViewModel.m
//  PMXiTu
//
//  Created by AYJk on 16/6/5.
//  Copyright © 2016年 AYJk. All rights reserved.
//

#import "HomeViewModel.h"
#import "NetService.h"
#import "HomeModel.h"
@interface HomeViewModel ()
@property (nonatomic, strong) NSArray *tagCategory;
@property (nonatomic, strong) NSArray *tagCategoryRequest;
@property (nonatomic, strong) NSMutableArray *homeModelArray;
@end

@implementation HomeViewModel

- (NSMutableArray *)homeModelArray {
    if (_homeModelArray == nil) {
        _homeModelArray = [NSMutableArray array];
    }
    return _homeModelArray;
}

-(NSArray *)tagCategory {
    if (_tagCategory == nil) {
        _tagCategory = @[@"全部", @"Android", @"设计", @"前端", @"iOS", @"后端", @"产品", @"工具资源", @"阅读"];
    }
    return _tagCategory;
}

- (NSArray *)tagCategoryRequest {
    if (_tagCategory == nil) {
        _tagCategoryRequest = @[@"", @"android", @"design", @"frontend", @"ios", @"backend", @"product", @"freebie", @"article"];
    }
    return _tagCategoryRequest;
}

- (void)fetchEntryData {
    [[NetService sharedInstance] fetchEntry:kEntry orderByDescending:kRankIndex category:@"design" limitNum:5 skipNum:0 successBlcok:^(NSArray *responseArray) {
        for (NSDictionary *dataDic in responseArray) {
            HomeModel *homeModel = [[HomeModel alloc] init];
            [homeModel yy_modelSetWithDictionary:dataDic];
            [self.homeModelArray addObject:homeModel];
        }
        NSLog(@"%@",self.homeModelArray);
    } errorBlock:^(NSDictionary *errorDic) {
        
    } ];
}

@end
