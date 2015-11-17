
//
//  AppManager.m
//  yamibo
//
//  Created by 李思良 on 15/7/8.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager

+ (instancetype)allocWithZone:(NSZone*)zone
{
    return [self sharedInstance];
}

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
        _isTradionChinese = [[NSUserDefaults standardUserDefaults] boolForKey:@"isTradition"];
        _isNoImgMode =[[NSUserDefaults standardUserDefaults] boolForKey:@"isNoImgMode"];
    }
    return self;
}

- (void)setIsTradionChinese:(BOOL)isTradionChinese {
    _isTradionChinese = isTradionChinese;
    [[NSUserDefaults standardUserDefaults] setBool:_isTradionChinese forKey:@"isTradition"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setIsNoImgMode:(BOOL)isNoImgMode {
    _isNoImgMode = isNoImgMode;
    [[NSUserDefaults standardUserDefaults] setBool:_isNoImgMode forKey:@"isNoImgMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setIsNightMode:(BOOL)isNightMode {
    if (isNightMode) {
        [DKNightVersionManager nightFalling];
    } else {
        [DKNightVersionManager dawnComing];
    }
    _isNightMode = isNightMode;
    [[NSUserDefaults standardUserDefaults] setBool:_isNightMode forKey:@"isNightMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
