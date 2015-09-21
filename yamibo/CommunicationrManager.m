//
//  CommunicationrManager.m
//  yamibo
//
//  Created by 李思良 on 15/9/21.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "CommunicationrManager.h"
#import "AFNetworking.h"

#define KBaseUrl    @"http://ceshi.yamibo.com/chobits/test.php"

@implementation CommunicationrManager

+ (void)getProfile:(void (^)(NSString *message))completion {
    NSDictionary *dic = @{@"module":@"profile"};
    [[self defaultManager] POST:KBaseUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self jsonOKForResponseObject:responseObject]) {
            completion(nil);
        } else {
            completion(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil);
    }];
}

+ (void)loginWithName:(NSString *)userName andPwd:(NSString *)pwd andQuestion:(NSString *)questionId andAnswer:(NSString *)answer completion:(void (^)(NSString *message))completion {
    NSDictionary *dic = @{@"module":@"login", @"username":userName, @"password":pwd};
    [[self defaultManager] GET:KBaseUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self jsonOKForResponseObject:responseObject]) {
            completion(nil);
        } else {
            completion(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil);
    }];
}


+ (AFHTTPRequestOperationManager *)defaultManager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json; charset=utf-8"
                     forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.HTTPShouldHandleCookies = true;
    return manager;
}

+ (BOOL)jsonOKForResponseObject:(id)responseObject
{
    return responseObject && ([responseObject isKindOfClass:[NSDictionary class]] ||
                              [responseObject isKindOfClass:[NSArray class]]);
}

@end
