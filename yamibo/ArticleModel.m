//
//  ArticleModel.m
//  yamibo
//
//  Created by shuang yang on 10/25/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "ArticleModel.h"


@implementation ArticleModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"tid": @"articleId",
                                                       @"readperm": @"readPermission",
                                                       @"author": @"authorName",
                                                       @"authorid": @"authorId",
                                                       @"subject": @"title",
                                                       @"lastpost": @"lastPost",
                                                       @"lastposter": @"lastPoster",
                                                       @"replies": @"replyNum",
                                                       @"views": @"viewNum",
                                                       @"typeid": @"typeId",
                                                       @"digest": @"isDigest",
                                                       @"attachment": @"attachmentNum",
                                                       @"closed": @"isClosed"
                                                       }];
}
@end

@implementation ArticleListModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Variables.forum_threadlist": @"articleList",
                                                       @"Variables.forum":@"forum",
                                                       @"Variables.sublist":@"subforumList",
                                                       @"Variables.threadtypes.types":@"articleTypes",
                                                       @"Variables.tpp":@"perPage"
                                                       }];
}
@end