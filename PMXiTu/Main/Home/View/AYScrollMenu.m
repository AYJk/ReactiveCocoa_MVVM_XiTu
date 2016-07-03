//
//  AYScrollMenu.m
//  PMXiTu
//
//  Created by Andy on 16/6/16.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AYScrollMenu.h"
#define buttonWidth 65
#define buttonTag 100
@interface AYScrollMenu ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIButton *lastButton;
@end

@implementation AYScrollMenu

- (void)setCurrentPage:(int)currentPage {
    if (_currentPage != currentPage) {
        _currentPage = currentPage;
        UIButton *btn = [self viewWithTag:currentPage + buttonTag];
        [self buttonAction:btn];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self blockAction];
    }
    return self;
}

- (void)setMenuArray:(NSArray *)menuArray {
    if (_menuArray != menuArray) {
        _menuArray = menuArray;
        [self configButtons];
    }
}

- (void)configButtons {
    for (int index = 0; index < self.menuArray.count; index ++) {
        UIButton *selectedButton = ({
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(index * buttonWidth, 0, buttonWidth, self.bounds.size.height)];
            button.tag = index + buttonTag;
            [button setTitle:self.menuArray[index] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            button;
        });
        if (index == 0) {
            selectedButton.selected = YES;
            selectedButton.titleLabel.font = [UIFont systemFontOfSize:15.5];
            _lastButton = selectedButton;
        }
    }
    self.contentSize = CGSizeMake(buttonWidth * self.menuArray.count, 0);
}

- (void)buttonAction:(UIButton *)button {
    if (_lastButton != button) {
        _lastButton.selected = NO;
        _lastButton.titleLabel.font = [UIFont systemFontOfSize:13.5];
        button.selected = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:15.5];
        _lastButton = button;
    }
    if (self.clickBlock) {
        self.clickBlock((int)(button.tag - buttonTag),_lastButton.selected);
    }
    CGPoint point = CGPointMake((int)(((self.contentSize.width + 8) - MainBounds.size.width) / self.menuArray.count * (button.tag - buttonTag)), 0);
    [self setContentOffset:point animated:YES];
}

- (void)blockAction{
    __weak typeof(self) weakSelf = self;
    self.selectedBlock = ^(int index) {
        UIButton *selectedButton = [weakSelf viewWithTag:index + buttonTag];
        [weakSelf buttonAction:selectedButton];
    };
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
    if (scrollView.contentOffset.y > 0) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
}

@end
