//
//  CommunicationrManager.h
//  yamibo
//
//  Created by 李思良 on 15/9/21.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"
@class HotModel;
@class ForumListModel;
@class ThreadFavoriteListModel;

@interface CommunicationrManager : NSObject

+ (void)getProfile:(void (^)(NSString *message))completion;

+ (void)loginWithName:(NSString *)userName andPwd:(NSString *)pwd andQuestion:(NSString *)questionId andAnswer:(NSString *)answer completion:(void (^)(NSString *message))completion;

+ (void)getHot:(void (^)(HotModel *model, NSString *message))completion;

+ (void)getForumList:(void (^)(ForumListModel *model, NSString *message))completion;

+ (void)getFavoriteList:(int)page completion:(void (^)(ThreadFavoriteListModel *model, NSString *message))completion;

+ (void)delFavorite:(NSString *)favId completion:(void (^)(NSString *message))completion;

+ (void)getPrivateMessageList:(int)page completion:(void (^)(PrivateMessageListModel *model, NSString *message))completion;

+ (void)getPublicMessageList:(int)page completion:(void (^)(PublicMessageListModel *model, NSString *message))completion;

+ (void)getPrivateMessageDetailList:(int)page toId:(NSInteger)toId completion:(void (^)(PrivateMessageDetailListModel *model, NSString *message))completion;

+ (void)getPublicMessageDetailList:(NSInteger)pmId completion:(void (^)(PublicMessageDetailListModel *model, NSString *message))completion;

+ (void)delMessage:(NSString *)pmId orConversation:(NSString *)toId ofType:(MessageViewType)type completion:(void (^)(NSString *message))completion;


@end
