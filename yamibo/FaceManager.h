//
//  FaceManager.h
//  yamibo
//
//  Created by shuang yang on 8/27/16.
//  Copyright © 2016 lsl. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author Shuang Yang, 16-08-27
 *
 *  @brief 论坛自定义表情管理
 */
@interface FaceManager : NSObject

@property (nonatomic, strong, readonly)NSArray * RecentlyFaces;
@property (nonatomic, strong, readonly)NSArray * AllFaces;
@property (nonatomic, strong, readonly)NSArray * BigFaces;

+ (instancetype)share;
- (void)fetchRecentlyFaces;
@end