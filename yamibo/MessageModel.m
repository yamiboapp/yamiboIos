//
//  MessageModel.m
//  yamibo
//
//  Created by shuang yang on 9/30/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "MessageModel.h"

#pragma mark private message
@implementation PrivateMessageModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"touid": @"toId",
                                                       @"tousername": @"toName",
                                                       @"lastauthorid": @"lastId",
                                                       @"lastdateline": @"date",
                                                       @"lastsummary": @"summary"
                                                       }];
}
@end

@implementation PrivateMessageListModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Variables.list": @"msgList",
                                                       @"Variables.perpage":@"perPage",
                                                       @"Variables.count":@"count"
                                                       }];
}
@end

#pragma mark public message
@implementation PublicMessageModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"pmId",
                                                       @"authorid": @"authorId",
                                                       @"author": @"authorName",
                                                       @"dateline": @"date",
                                                       @"message": @"summary"
                                                       }];
}
@end

@implementation PublicMessageListModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Variables.list": @"msgList",
                                                       @"Variables.perpage":@"perPage",
                                                       @"Variables.count":@"count",
                                                       }];
}
@end

#pragma mark private message detail
@implementation PrivateMessageDetailModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"pmid": @"pmId",
                                                       @"msgfromid": @"fromId",
                                                       @"msgtoid": @"toId",
                                                       @"dateline": @"date",
                                                       @"message": @"message"
                                                       }];
}
@end

@implementation PrivateMessageDetailListModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Variables.list": @"msgList",
                                                       @"Variables.count":@"count",
                                                       @"Variables.perpage":@"perPage"
                                                       }];
}
@end

#pragma mark public message detail
@implementation PublicMessageDetailModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"pmId",
                                                       @"authorid": @"authorId",
                                                       @"author": @"authorName",
                                                       @"dateline": @"date",                                                       
                                                       @"message": @"message"
                                                       }];
}
@end

@implementation PublicMessageDetailListModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Variables.list": @"msgList",
                                                       }];
}
@end

