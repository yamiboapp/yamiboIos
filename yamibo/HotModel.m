//
//  HotModel.m
//  yamibo
//
//  Created by 李思良 on 15/9/26.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "HotModel.h"

@implementation DataImg

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"feedId",
                                                       @"title": @"title",
                                                       @"thumbpath": @"picUrl",
                                                       @"author": @"authorName",
                                                       @"authorid": @"authorId",
                                                       @"replies": @"replyNum",
                                                       @"views": @"viewNum",
                                                       @"lastpost": @"lastPost"
                                                       }];
}

@end

@implementation HotModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Variables.data_img": @"dataImg",
                                                       @"Variables.data_txt": @"dataText"
                                                       }];
}
@end
