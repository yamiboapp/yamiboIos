//
//  MessageModel.h
//  yamibo
//
//  Created by shuang yang on 9/30/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "JSONModel.h"

typedef NS_ENUM(NSInteger, MessageViewType) {
    MessagePrivate = 0,
    MessagePublic = 1,
};

#pragma mark private message
@protocol PrivateMessageModel
@end

@interface PrivateMessageModel : JSONModel

@property   (strong, nonatomic) NSString *toId;
@property   (strong, nonatomic) NSString *toName;
@property   (strong, nonatomic) NSString *lastId;
@property   (strong, nonatomic) NSString *date;
@property   (strong, nonatomic) NSString *summary;

@end

@interface PrivateMessageListModel : JSONModel

@property (strong, nonatomic) NSArray<PrivateMessageModel> *msgList;
@property (strong, nonatomic) NSString* perPage;

@end

#pragma mark public message
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
@property (strong, nonatomic) NSString* perPage;

@end

#pragma mark private message detail
@protocol PrivateMessageDetailModel
@end

@interface PrivateMessageDetailModel : JSONModel

@property   (strong, nonatomic) NSString *pmId;
@property   (strong, nonatomic) NSString *toId;
@property   (strong, nonatomic) NSString *fromId;
@property   (strong, nonatomic) NSString *date;
@property   (strong, nonatomic) NSString *message;

@end

@interface PrivateMessageDetailListModel : JSONModel

@property (strong, nonatomic) NSArray<PrivateMessageDetailModel> *msgList;
@property (strong, nonatomic) NSString* count;
@property (strong, nonatomic) NSString* perPage;

@end

#pragma mark public message detail
@protocol PublicMessageDetailModel
@end

@interface PublicMessageDetailModel : JSONModel

@property   (strong, nonatomic) NSString *pmId;
@property   (strong, nonatomic) NSString *toId;
@property   (strong, nonatomic) NSString *toName;
@property   (strong, nonatomic) NSString *lastId;
@property   (strong, nonatomic) NSString *date;
@property   (strong, nonatomic) NSString *summary;

@end

@interface PublicMessageDetailListModel : JSONModel

@property (strong, nonatomic) NSArray<PublicMessageDetailModel> *msgList;

@end

