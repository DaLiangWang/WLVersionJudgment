//
//  NSString+WLVersionJudgment.m
//  appVersionUpDate
//
//  Created by 适途科技二 on 2019/4/29.
//  Copyright © 2019 WangLiang. All rights reserved.
//

#import "NSString+WLVersionJudgment.h"
/** 获取本地版本 */
#define WLJudgementVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** 非热更新版本位数 */
#define WLHotNumber 3



@implementation NSString (WLVersionJudgment)
/**
 版本对比
 
 @return 需要对比的版本结果。YES 大于本地版本。NO 小于本地版本
 */
-(BOOL)contrastVersion{
    return [self contrastVersionNumber:0];
}


/**
 版本对比
 
 @return 需要对比的版本结果。YES 大于本地版本。NO 小于本地版本
 */
-(BOOL)contrastVersionNumber:(NSInteger)number{
    NSString *version = [self copy];
    NSString *local = WLJudgementVersion;
    NSLog(@"系统版本：%@ -- 对比版本：%@",local,version);
    /** 需要匹配的版本 */
    NSMutableArray *shopVersion = [NSMutableArray arrayWithArray:[version componentsSeparatedByString:@"."]];
    /** 获取当前版本号 */
    NSMutableArray *localVersion = [NSMutableArray arrayWithArray:[local componentsSeparatedByString:@"."]];
    
    /** 获取啷个版本好位数 以最大为准 */
    NSInteger num = shopVersion.count;
    if (num < localVersion.count) {
        num = localVersion.count;
    }
    
    /** 需要匹配版本位数补充 */
    while (shopVersion.count < num) {
        [shopVersion addObject:@"0"];
    }
    /** 当前版本位数补充 */
    while (localVersion.count < num) {
        [localVersion addObject:@"0"];
    }
    
    /** 循环对比版本号 */
    int x = 0;
    NSMutableArray *bolArr = [NSMutableArray array];
    while ( x < num) {
        /** 需要匹配版本号第x位 > 本地对应x位版本号 */
        if ([shopVersion[x] integerValue] > [localVersion[x] integerValue]) {
            [bolArr addObject:@"1"];
        }
        /** 需要匹配版本号第x位 == 本地对应x位版本号 */
        else if ([shopVersion[x] integerValue] == [localVersion[x] integerValue]) {
            [bolArr addObject:@"2"];
        }
        /** 需要匹配版本号第x位 < 本地对应x位版本号 */
        else{
            [bolArr addObject:@"0"];
        }
        x ++;
    }
    
    /** 判断本地和匹配版本 */
    BOOL newBol = NO;
    number = number ? number : bolArr.count;
    for (int c = 0; c< number ; c++) {
        NSInteger num = [bolArr[c] integerValue];
        /** 如果当前位数版本匹配 线上版本小于本地版本 终止后续位数版本判断，因为后续版本在大也不肯能比本地版本大 */
        if (num == 0) {break;}
        /** 如果当前位数版本匹配 线上版本大于本地版本 则线上版本大鱼本地版本 */
        if (num == 1) {newBol = YES;}
        /** 等于情况不做处理 */
        if (num == 2) {}
    }
    NSLog(@"%@",newBol?@"需要更新":@"不需要更新");
    return newBol;
}



/**
 版本提示更新回掉。最低兼容。提示更新 强制更新
 
 @param minVersion 最低兼容版本
 @param promptVersion 提示更新版本
 @param normalBlock 无需更新回掉
 @param promptBlock 提示更新回掉
 @param mandatoryBlock 强制更新回掉
 */
+(void)minVersion:(NSString *)minVersion
    promptVersion:(NSString *)promptVersion
      normalBlock:(normalBlock)normalBlock
         hotBlock:(hotBlock)hotBlock
      promptBlock:(promptBlock)promptBlock
   mandatoryBlock:(mandatoryBlock)mandatoryBlock{
    if (mandatoryBlock) {// 需要强制更新
        NSLog(@"------强制更新对比------");
        if ([minVersion contrastVersionNumber:WLHotNumber]) {
            mandatoryBlock(promptVersion);
            NSLog(@"------强制更新对比------");
            return;
        }
        NSLog(@"------强制更新对比------");
    }
    if (promptBlock) {//  需要提示更新
        NSLog(@"------提示更新对比------");
        if ([promptVersion contrastVersionNumber:WLHotNumber]) {
            promptBlock(promptVersion);
            NSLog(@"------提示更新对比------");
            return;
        }
        NSLog(@"------提示更新对比------");
    }
    if (promptBlock) {//  需要提示更新
        NSLog(@"------热更新对比------");
        if ([promptVersion contrastVersionNumber:0]) {
            hotBlock(promptVersion);
            NSLog(@"------热更新对比------");
            return;
        }
        NSLog(@"------热更新对比------");
    }
    NSLog(@"------不需要更新------");
    if (normalBlock) {
        normalBlock(WLJudgementVersion);
        NSLog(@"------不需要更新------");
    }
}
@end
