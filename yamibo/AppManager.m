
//
//  AppManager.m
//  yamibo
//
//  Created by 李思良 on 15/7/8.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager

+ (id)allocWithZone:(NSZone*)zone
{
    return [self sharedInstance];
}

+ (id)sharedInstance
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
        _isTradionChinese = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isTradition"] boolValue];
        _isNoImgMode = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isNoImgMode"] boolValue];
    }
    return self;
}

- (void)setIsTradionChinese:(BOOL)isTradionChinese {
    _isTradionChinese = isTradionChinese;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:_isTradionChinese] forKey:@"isTradition"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setIsNoImgMode:(BOOL)isNoImgMode {
    _isNoImgMode = isNoImgMode;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:_isTradionChinese] forKey:@"isNoImgMode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
