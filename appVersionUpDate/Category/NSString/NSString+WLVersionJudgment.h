//
//  NSString+WLVersionJudgment.h
//  appVersionUpDate
//
//  Created by 适途科技二 on 2019/4/29.
//  Copyright © 2019 WangLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/** 正常回掉 */
typedef void(^normalBlock)(NSString *version);
/** 热更新 */
typedef void(^hotBlock)(NSString *version);
/** 提示更新回掉 */
typedef void(^promptBlock)(NSString *version);
/** 强制更新回掉 */
typedef void(^mandatoryBlock)(NSString *version);


@interface NSString (WLVersionJudgment)

/**
 版本对比
 
 @return 需要对比的版本结果。YES 大于本地版本。NO 小于本地版本
 */
-(BOOL)contrastVersion;

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
   mandatoryBlock:(mandatoryBlock)mandatoryBlock;

@end

NS_ASSUME_NONNULL_END
