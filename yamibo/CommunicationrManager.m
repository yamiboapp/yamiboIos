//
//  CommunicationrManager.m
//  yamibo
//
//  Created by 李思良 on 15/9/21.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "CommunicationrManager.h"
#import "AFNetworking.h"
#import "HotModel.h"
#import "ForumModel.h"
#import "ProfileManager.h"

#define KBaseUrl    @"http://ceshi.yamibo.com/chobits/index.php?"

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
    NSDictionary *dic;
    if ([questionId isEqualToString:@"0"]) {
        dic = @{@"module":@"login", @"username":userName, @"password":pwd};
    } else {
        dic = @{@"module":@"login", @"username":userName, @"password":pwd, @"questionid":questionId, @"answer":answer};
    }
    [[self defaultManager] POST:KBaseUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self jsonOKForResponseObject:responseObject]) {
            if ([responseObject[@"Message"][@"messageval"] isEqualToString:@"login_succeed"]) {
                [ProfileManager sharedInstance].userId = responseObject[@"Variables"][@"member_uid"];
                [ProfileManager sharedInstance].userName = responseObject[@"Variables"][@"member_username"];
                [ProfileManager sharedInstance].authToken = responseObject[@"Variables"][@"formhash"];
                completion(nil);
            } else {
                completion(responseObject[@"Message"][@"messagestr"]);
            }
        } else {
            completion(@"登陆失败");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil);
    }];
}

+ (void)getHot:(void (^)(HotModel *model, NSString *message))completion {
    NSDictionary *dic = @{@"module":@"hot"};
    [[self defaultManager] POST:KBaseUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self jsonOKForResponseObject:responseObject]) {
            completion([[HotModel alloc] initWithDictionary:responseObject error:nil], nil);
        } else {
            completion(nil, @"请求失败");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, @"请求失败");
    }];
}

+ (void)getForumList:(void (^)(ForumListModel *model, NSString *message))completion {
    NSDictionary *dic = @{@"module":@"forumindex"};
    [[self defaultManager] POST:KBaseUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self jsonOKForResponseObject:responseObject]) {
            completion([[ForumListModel alloc] initWithDictionary:responseObject error:nil], nil);
        } else {
            completion(nil, @"请求失败");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, @"请求失败");
    }];
}

+ (AFHTTPRequestOperationManager *)defaultManager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.HTTPShouldHandleCookies = true;
    return manager;
}

+ (BOOL)jsonOKForResponseObject:(id)responseObject
{
    return responseObject && ([responseObject isKindOfClass:[NSDictionary class]] ||
                              [responseObject isKindOfClass:[NSArray class]]);
}

@end
