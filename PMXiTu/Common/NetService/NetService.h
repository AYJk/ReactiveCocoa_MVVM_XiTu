//
//  NetService.h
//  PMXiTu
//
//  Created by AYJk on 16/6/5.
//  Copyright © 2016年 AYJk. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NetService : NSObject

+ (instancetype)sharedInstance;
//- (void)fetchEntry:(NSString *)className orderByDescending:(NSString *)descending category:(NSString *)category limitNum:(NSInteger)limit skipNum:(NSInteger)skip;
- (void)fetchEntry:(NSString *)className orderByDescending:(NSString *)descending category:(NSString *)category limitNum:(NSInteger)limit skipNum:(NSInteger)skip successBlcok:(void(^)(NSArray *responseArray))successBlock errorBlock:(void(^)(NSDictionary *errorDic))errorBlock;
@end
