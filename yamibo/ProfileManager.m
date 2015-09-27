//
//  ProfileManager.m
//  yamibo
//
//  Created by 李思良 on 15/9/19.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "ProfileManager.h"

@implementation ProfileManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id instance = nil;
    
    dispatch_once(&once, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _userId = [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"];
        _userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
        _authToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"authToken"];
        _rank = [[NSUserDefaults standardUserDefaults] stringForKey:@"rank"];
        _gender = [[NSUserDefaults standardUserDefaults] stringForKey:@"gender"];
        _credit = [[NSUserDefaults standardUserDefaults] stringForKey:@"credit"];
    }
    return self;
}

- (BOOL)checkLogin {
    return _authToken.length != 0;
}
- (void)setUserId:(NSString *)userId {
    _userId = userId;
    [[NSUserDefaults standardUserDefaults] setObject:_userId forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setUserName:(NSString *)userName {
    _userName = userName;
    [[NSUserDefaults standardUserDefaults] setObject:_userName forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setAuthToken:(NSString *)authToken {
    _authToken = authToken;
    [[NSUserDefaults standardUserDefaults] setObject:_authToken forKey:@"authToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setRank:(NSString *)rank {
    _rank = rank;
    [[NSUserDefaults standardUserDefaults] setObject:_rank forKey:@"rank"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setGender:(NSString *)gender {
    _gender = gender;
    [[NSUserDefaults standardUserDefaults] setObject:_gender forKey:@"gender"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setCredit:(NSString *)credit {
    _credit = credit;
    [[NSUserDefaults standardUserDefaults] setObject:_credit forKey:@"credit"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)logOut {
    self.authToken = @"";
}
@end
