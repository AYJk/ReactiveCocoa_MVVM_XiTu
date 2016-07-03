//
//  NetService.m
//  ReactiveCocoa_MVVM_XiTu
//
//  Created by AYJk on 16/6/5.
//  Copyright © 2016年 AYJk. All rights reserved.
//

#import "NetService.h"
#import <AVOSCloud/AVOSCloud.h>
//#import <AFNetworking/AFNetworking.h>
@implementation NetService

+ (instancetype)sharedInstance{
    static NetService* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [NetService new];
    });
    return instance;
}

- (void)fetchEntry:(NSString *)className orderByDescending:(NSString *)descending category:(NSString *)category limitNum:(NSInteger)limit skipNum:(NSInteger)skip successBlcok:(void(^)(NSArray *responseArray))successBlock errorBlock:(void(^)(NSDictionary *errorDic))errorBlock {
    AVQuery *query = [[AVQuery alloc] initWithClassName:className];
    [query orderByDescending:descending];
    [query whereKey:@"category" equalTo:category];
    query.limit = limit;
    query.skip = skip;

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            NSMutableArray *dataArray = [NSMutableArray array];
            for (AVObject *object in objects) {
                NSDictionary *dic = [object dictionaryForObject];
                [dataArray addObject:dic];
            }
            BlockSafe(successBlock,[dataArray copy]);
        }
    }];
}

@end
