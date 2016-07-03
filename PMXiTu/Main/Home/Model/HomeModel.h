//
//  HomeModel.h
//  PMXiTu
//
//  Created by AYJk on 16/6/5.
//  Copyright © 2016年 AYJk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject<YYModel>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *tagsTitleArray;
//@property (nonatomic, strong) NSDictionary *updatedAt;
@property (nonatomic, strong) NSDate *updatedAt;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger collectionCount;
@property (nonatomic, assign) NSInteger commentsCount;
@property (nonatomic, assign) NSInteger objectId;
@property (nonatomic, copy) NSString *originalUrl;
//@property (nonatomic, copy) NSString *
//@property (nonatomic, copy) NSString *
//@property (nonatomic, copy) NSString *
//@property (nonatomic, copy) NSString *
//@property (nonatomic, copy) NSString *

@end
