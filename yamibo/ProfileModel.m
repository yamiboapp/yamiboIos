//
//  ProfileModel.m
//  yamibo
//
//  Created by shuang yang on 11/25/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "ProfileModel.h"

@implementation ProfileModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Variables.space.uid": @"userId",
                                                       @"Variables.space.username": @"userName",
                                                       @"Variables.space.credits": @"credit",
                                                       @"Variables.space.gender": @"gender",
                                                       @"Variables.space.group.grouptitle": @"rank"
                                                       }];
}
@end
