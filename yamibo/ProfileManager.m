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
        _avaturl = [[NSUserDefaults standardUserDefaults] stringForKey:@"avaturl"];
    }
    return self;
}

- (BOOL)checkLogin {
    return _authToken.length != 0;
}

- (void)logOut {
    _authToken = @"";
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
