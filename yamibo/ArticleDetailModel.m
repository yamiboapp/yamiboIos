//
//  ArticleDetailModel.m
//  yamibo
//
//  Created by ShaneWay on 15/11/1.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "ArticleDetailModel.h"

@implementation PostModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"pid": @"postID",
                                                       @"tid": @"articleID",
                                                       @"first": @"floorNum",
                                                       @"author": @"authorName",
                                                       @"authorid": @"authorID",
                                                       @"dateline": @"postTime",
                                                       @"message": @"postContent"}];
}
@end


@implementation ArticleDetailModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"Variables.thread": @"articleInfo",
                                                       @"Variables.postlist": @"postList"}];
}

@end
