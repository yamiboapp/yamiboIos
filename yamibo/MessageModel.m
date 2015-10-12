//
//  MessageModel.m
//  yamibo
//
//  Created by shuang yang on 9/30/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "MessageModel.h"

@implementation PrivateMessageModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"pmid": @"pmId",
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
                                                       @"Variables.list": @"msgList"
                                                       }];
}

@end

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
                                                       @"Variables.list": @"msgList"
                                                       }];
}

@end

