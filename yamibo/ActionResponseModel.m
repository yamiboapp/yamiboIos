//
//  ErrorMessage.m
//  yamibo
//
//  Created by shuang yang on 8/28/16.
//  Copyright © 2016 lsl. All rights reserved.
//

#import "ActionResponseModel.h"

@implementation ActionResponseModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Message.messagestr": @"response"
                                                       }];
}
@end
