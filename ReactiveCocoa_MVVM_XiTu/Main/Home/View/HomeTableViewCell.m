//
//  HomeTableViewCell.m
//  ReactiveCocoa_MVVM_XiTu
//
//  Created by AYJk on 16/6/6.
//  Copyright © 2016年 AYJk. All rights reserved.
//

#import "HomeTableViewCell.h"
//#import "TransparentLabel.h"
@interface HomeTableViewCell ()

@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
//    TransparentLabel *label = [[TransparentLabel alloc] initWithFrame:CGRectMake(0, 0, MainBounds.size.width, 100)];
//    label.backgroundColor = [UIColor yellowColor];
//    [self.contentView addSubview:label];
    // Initialization code
//    self.frame = self.coverImageView.frame;
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
//    CGPoint newPoint = [change[@"new"] CGPointValue];
//    CGPoint oldPoint = [change[@"old"] CGPointValue];
//    CGFloat newOrginY = newPoint.y - oldPoint.y;
//    NSLog(@"%f",newOrginY);
//    CGRect frame = self.coverImageView.frame;
//    frame.origin.y = frame.origin.y - newOrginY * .1;
//    if (frame.origin.y >= 0) {
//        frame.origin.y = 0;
//    }
//    if (frame.origin.y <= - 60) {
//        frame.origin.y = - 60;
//    }
//    self.coverImageView.frame = frame;
////    NSLog(@"%@",NSStringFromCGRect(frame));
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
