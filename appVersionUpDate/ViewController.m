//
//  ViewController.m
//  appVersionUpDate
//
//  Created by 适途科技二 on 2019/4/29.
//  Copyright © 2019 WangLiang. All rights reserved.
//





#import "ViewController.h"
#import "NSString+WLVersionJudgment.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *min = @"2.8.0";
    NSString *tishi = @"3.00.0.3";

    if (min.contrastVersion) {
//        NSLog(@"需要更新");
    }
    
    [NSString minVersion:min promptVersion:tishi normalBlock:^(NSString * _Nonnull version) {
//        NSLog(@"不提示更新");
    } hotBlock:^(NSString * _Nonnull version) {
//        NSLog(@"re更新");
    } promptBlock:^(NSString * _Nonnull version) {
//        NSLog(@"提示更新");
    } mandatoryBlock:^(NSString * _Nonnull version) {
//        NSLog(@"强制更新");
    }];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


@end
