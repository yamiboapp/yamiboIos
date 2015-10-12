//
//  ForumModel.m
//  yamibo
//
//  Created by 李思良 on 15/9/26.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "ForumModel.h"

@implementation ForumModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"fid": @"forumId",
                                                       @"name": @"forumName",
                                                       @"todayposts": @"todayPosts",
                                                       @"description": @"content"
                                                       }];
}

@end

@implementation ForumListModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Variables.forumlist": @"forumList"
                                                       }];
}

@end