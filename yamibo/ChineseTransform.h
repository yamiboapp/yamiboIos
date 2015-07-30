//
//  ChineseTransform.h
//  yamibo
//
//  Created by 李思良 on 15/7/8.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author 李思良, 15-07-08
 *
 *  @brief  中文简体转繁体.
 */
@interface ChineseTransform : NSObject
/**
 *  @author 李思良, 15-07-08
 *
 *  @brief  单字转换用的字典.
 */
@property (nonatomic, readonly, strong) NSMutableDictionary *simpleDictionary;
/**
 *  @author 李思良, 15-07-08
 *
 *  @brief  UI固定文本的句子转换字典.
 */
@property (nonatomic, readonly, strong) NSMutableDictionary *specialDictionary;

/**
 *  @author 李思良, 15-07-08
 *
 *  @brief  单例.
 *
 *  @return
 */
+ (id)sharedInstance;
/**
 *  @author 李思良, 15-07-08
 *
 *  @brief  简体转繁体
 *
 *  @param simpleString 简体string
 *
 *  @return 繁体string
 */
- (NSString *)traditionString:(NSString *)simpleString;
@end
