//
//  ThreadFavoriteModel.m
//  yamibo
//
//  Created by 李思良 on 15/9/27.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "ThreadFavoriteModel.h"

@implementation ThreadFavoriteModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"favid": @"favId",
                                                       @"id": @"threadId",
                                                       @"title": @"title",
                                                       @"dateline": @"date",
                                                       @"replies": @"replyNum",
                                                       @"author": @"authorName"
                                                       }];
}
@end

@implementation ThreadFavoriteListModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Variables.list": @"favList"
                                                       }];
}

@end