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
#import "ThreadFavoriteModel.h"
#import "ArticleModel.h"
#import "ArticleDetailModel.h"

#define KBaseUrl    @"http://ceshi.yamibo.com/chobits/index.php?"

@implementation CommunicationrManager

+ (void)getProfile:(void (^)(NSString *message))completion {
    NSDictionary *dic = @{@"module":@"profile"};
    [[self defaultManager] POST:KBaseUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self jsonOKForResponseObject:responseObject] && [self checkLogin:responseObject]) {
            [ProfileManager sharedInstance].rank = [responseObject[@"Variables"][@"space"][@"group"][@"grouptitle"] stringFromHTML];
            [ProfileManager sharedInstance].credit = responseObject[@"Variables"][@"space"][@"credits"];
            [ProfileManager sharedInstance].gender = responseObject[@"Variables"][@"space"][@"gender"];
            completion(nil);
        } else {
            completion(@"加载失败");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(@"加载失败");
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
#pragma mark home page
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
            // login时储存的formhash为登录前的formhash,需在此更新
            if ([self checkLogin:responseObject]) {
                [ProfileManager sharedInstance].authToken = responseObject[@"Variables"][@"formhash"];
            }
            completion([[ForumListModel alloc] initWithDictionary:responseObject error:nil], nil);
        } else {
            completion(nil, @"请求失败");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, @"请求失败");
    }];
}
#pragma mark article list
+ (void)getArticleList:(NSString *)fId andPage:(int)page andFilter:(NSString *)filter andTypeId:(NSString *)typeId andPerPage:(NSString *)perPage completion:(void (^)(ArticleListModel *model, NSString *message))completion {
    //FIXME:Why is dic not working?
    //NSDictionary *dic = @{@"module":@"forumdisplay", @"fid":fId, @"page":@(page), @"typeid":typeId, @"filter":filter, @"tpp":perPage};
    NSString *url = [NSString stringWithFormat:@"%@%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%d",KBaseUrl, @"module", @"forumdisplay", @"fid", fId, @"typeid", typeId, @"filter", filter, @"tpp", perPage, @"page", page];
    [[self defaultManager] POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self jsonOKForResponseObject:responseObject]) {
            completion([[ArticleListModel alloc] initWithDictionary:responseObject error:nil], nil);
        } else {
            completion(nil, @"请求失败");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, @"请求失败");
    }];
}
#pragma mark favorite
+ (void)getFavoriteList:(int)page completion:(void (^)(ThreadFavoriteListModel *model, NSString *message))completion {
    NSDictionary *dic = @{@"module":@"myfavthread", @"page":@(page)};
    [[self defaultManager] POST:KBaseUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self jsonOKForResponseObject:responseObject] && [self checkLogin:responseObject]) {
            completion([[ThreadFavoriteListModel alloc] initWithDictionary:responseObject error:nil], nil);
        } else {
            completion(nil, @"请重新登录");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, @"加载失败");
    }];
}

+ (void)delFavorite:(NSString *)favId completion:(void (^)(NSString *message))completion {
    NSDictionary *dic = @{@"module":@"favthread", @"op":@"delete", @"favid":favId, @"formhash": [ProfileManager sharedInstance].authToken};
    AFHTTPRequestOperationManager *manager = [self defaultManager];
    [manager POST:KBaseUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self jsonOKForResponseObject:responseObject] && [self checkLogin:responseObject]) {
            completion(nil);
        } else {
            completion(@"请先登录");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(@"请求失败");
    }];
}
#pragma mark message
+ (void)getPrivateMessageList:(int)page completion:(void (^)(PrivateMessageListModel *model, NSString *message))completion {
    NSDictionary *dic = @{@"module":@"mypm", @"page":@(page)};
    [[self defaultManager] POST:KBaseUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self jsonOKForResponseObject:responseObject] && [self checkLogin:responseObject]) {
            completion([[PrivateMessageListModel alloc] initWithDictionary:responseObject error:nil], nil);
        } else {
            completion(nil, @"请重新登录");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, @"加载消息失败");
    }];
}
+ (void)getPublicMessageList:(int)page completion:(void (^)(PublicMessageListModel *, NSString *))completion {
    NSDictionary *dic = @{@"module":@"publicpm", @"page":@(page)};
    [[self defaultManager] POST:KBaseUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self jsonOKForResponseObject:responseObject] && [self checkLogin:responseObject]) {
            completion([[PublicMessageListModel alloc] initWithDictionary:responseObject error:nil], nil);
        } else {
            completion(nil, @"请重新登录");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, @"加载消息失败");
    }];
}
+ (void)getPrivateMessageDetailList:(int)page toId:(NSInteger)toId completion:(void (^)(PrivateMessageDetailListModel *model, NSString *message))completion {
    NSDictionary *dic = @{@"module":@"mypm", @"subop":@("view"), @"touid":@(toId), @"page":@(page)};
    [[self defaultManager] POST:KBaseUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self jsonOKForResponseObject:responseObject]) {
            completion([[PrivateMessageDetailListModel alloc] initWithDictionary:responseObject error:nil], nil);
        } else {
            completion(nil, @"加载对话失败");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, @"加载对话失败");
    }];
}
+ (void)getPublicMessageDetailList:(NSInteger)pmId completion:(void (^)(PublicMessageDetailListModel *model, NSString *message))completion {
    NSDictionary *dic = @{@"module":@"publicpm", @"subop":@("viewg"), @"pmid":@(pmId)};
    [[self defaultManager] POST:KBaseUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self jsonOKForResponseObject:responseObject]) {
            completion([[PublicMessageDetailListModel alloc] initWithDictionary:responseObject error:nil], nil);
        } else {
            completion(nil, @"加载消息失败");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, @"加载消息失败");
    }];
}
+ (void)delMessage:(NSString *)pmId orConversation:(NSString *)toId ofType:(MessageViewType)type completion:(void (^)(NSString *message))completion {
    NSDictionary *dic;
    if (type == MessagePrivate) {
        if (![toId isEqualToString:@"0"]) {
            dic = @{@"module":@"sendpm", @"op":@"delete", @"touid":toId, @"formhash": [ProfileManager sharedInstance].authToken};
        } else if (![pmId isEqualToString:@"0"]) {
            dic = @{@"module":@"sendpm", @"op":@"delete", @"pmid":pmId, @"formhash": [ProfileManager sharedInstance].authToken};
        }
    } else if (type == MessagePublic) {
        dic = @{@"module":@"sendpm", @"op":@"delete", @"gpmid":pmId, @"formhash": [ProfileManager sharedInstance].authToken};
    }
    AFHTTPRequestOperationManager *manager = [self defaultManager];
    [manager POST:KBaseUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([self jsonOKForResponseObject:responseObject]) {
            completion(nil);
        } else {
            completion(@"请求失败");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(@"请求失败");
    }];
}

#pragma mark article detail
+ (void)getArticleDetailList:(int)page threadID:(NSInteger)tid postPerPage:(int)ppp authorID:(NSInteger)uid completion:(void (^)(ArticleDetailModel *, NSString *))completion {
    NSDictionary *dict = @{@"module": @"viewthread",
                           @"tid": @(tid),
                           @"page": @(page),
                           @"ppp": @(ppp),
                           @"authorid": @(uid)};
    [[self defaultManager] POST:KBaseUrl parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if ([self jsonOKForResponseObject:responseObject] && [self checkLogin:responseObject]) {
            completion([[ArticleDetailModel alloc] initWithDictionary:responseObject error:nil], nil);
        } else {
            completion(nil, @"请重新登录");
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        completion(nil, @"内容加载失败");
    }];
}

#pragma mark -
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
+ (BOOL)checkLogin:(id)responseObject {
    if (responseObject[@"Variables"][@"auth"] == [NSNull null]) {
        [[ProfileManager sharedInstance] logOut];
        return false;
    }
    return true;
}
@end
