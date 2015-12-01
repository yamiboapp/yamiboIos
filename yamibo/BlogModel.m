//
//  BlogModel.m
//  yamibo
//
//  Created by shuang yang on 11/29/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "BlogModel.h"

@implementation BlogModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"blogid": @"blogId",
                                                       @"subject": @"title",
                                                       @"date": @"date",
                                                       @"message" :@"message"
                                                       }];
}
@end

@implementation BlogListModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Variables.bloglist": @"blogList",
                                                       }];
}
@end

@implementation BlogDetailModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Variables.bloginfo": @"blog",
                                                       }];
}
@end