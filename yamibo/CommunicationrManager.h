//
//  CommunicationrManager.h
//  yamibo
//
//  Created by 李思良 on 15/9/21.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunicationrManager : NSObject

+ (void)getProfile:(void (^)(NSString *message))completion;

+ (void)loginWithName:(NSString *)userName andPwd:(NSString *)pwd andQuestion:(NSString *)questionId andAnswer:(NSString *)answer completion:(void (^)(NSString *message))completion;
@end