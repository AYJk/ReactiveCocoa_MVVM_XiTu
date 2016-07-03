//
//  AYScrollMenu.h
//  ReactiveCocoa_MVVM_XiTu
//
//  Created by Andy on 16/6/16.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MenuClickBlock)(int,BOOL);
typedef void(^CurrentSelectedBlock)(int);
@interface AYScrollMenu : UIScrollView

@property (nonatomic, strong) NSArray<NSString *> *menuArray;
@property (nonatomic, copy) MenuClickBlock clickBlock;
@property (nonatomic, copy) CurrentSelectedBlock selectedBlock;
@property (nonatomic, assign) int currentPage;
@end
