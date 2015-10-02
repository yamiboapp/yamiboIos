//
//  MessageModel.h
//  yamibo
//
//  Created by shuang yang on 9/30/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "JSONModel.h"

#pragma mark 私人消息
@protocol PrivateMessageModel
@end

@interface PrivateMessageModel : JSONModel

@property   (strong, nonatomic) NSString *pmId;
@property   (strong, nonatomic) NSString *toId;
@property   (strong, nonatomic) NSString *toName;
@property   (strong, nonatomic) NSString *lastId;
@property   (strong, nonatomic) NSString *date;
@property   (strong, nonatomic) NSString *summary;

@end

@interface PrivateMessageListModel : JSONModel

@property (strong, nonatomic) NSArray<PrivateMessageModel> *msgList;

@end

#pragma mark 公共消息
@protocol PublicMessageModel
@end

@interface PublicMessageModel : JSONModel

@property   (strong, nonatomic) NSString *pmId;
@property   (strong, nonatomic) NSString *authorId;
@property   (strong, nonatomic) NSString *authorName;
@property   (strong, nonatomic) NSString *date;
@property   (strong, nonatomic) NSString *summary;

@end

@interface PublicMessageListModel : JSONModel

@property (strong, nonatomic) NSArray<PublicMessageModel> *msgList;

@end