//
//  ViewController.m
//  ReactiveCocoa_MVVM_XiTu
//
//  Created by AYJk on 16/6/4.
//  Copyright © 2016年 AYJk. All rights reserved.
//
//  RAC学习博客 http://www.cnblogs.com/ludashi/p/4925042.html
//  http://www.jianshu.com/p/bae2eeba118d

#import "ViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
//    [self uppercaseString];
//    [self signalSwitch];
//    [self conbiningLast];
    [self mergeSingnal];
}

- (void)uppercaseString {
    RACSequence *sequence = [@[@"AYJk",@"AYJKDev",@"ayjkong"] rac_sequence];
    RACSignal *signal = sequence.signal;
    RACSignal *captializedSignal = [signal map:^id(id value) {
        return [value capitalizedString];
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"signal ---- %@",x);
    }];
    [captializedSignal subscribeNext:^(id x) {
        NSLog(@"captializedSignal ---- %@",x);
    }];
}

- (void)signalSwitch {
//    创建三个自定义信号
    RACSubject *baidu = [RACSubject subject];
    RACSubject *google = [RACSubject subject];
    RACSubject *signalOfSignal = [RACSubject subject];
//    创建一个开关信号
    RACSignal *switchSignal = [signalOfSignal switchToLatest];
    [[switchSignal map:^id(id value) {
        return [@"http://www." stringByAppendingString:value];
    }] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
//    通过开关打开baidu
    [signalOfSignal sendNext:baidu];
    [google sendNext:@"google.com"];
    [baidu sendNext:@"baidu.com"];
//    通过开关打开google
    [signalOfSignal sendNext:google];
    [google sendNext:@"google.com"];
    [baidu sendNext:@"baidu.com"];
}

- (void)conbiningLast {
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    [[RACSignal combineLatest:@[letters,numbers] reduce:^(NSString *letter, NSString *number){
        return [letter stringByAppendingString:number];
    }] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];
}

- (void)mergeSingnal {
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSubject *chinese = [RACSubject subject];
    [[RACSignal merge:@[letters,numbers,chinese]] subscribeNext:^(id x) {
        NSLog(@"%@",x);
}];
    [letters sendNext:@"AAA"];
    [numbers sendNext:@"222"];
    [chinese sendNext:@"你好"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
