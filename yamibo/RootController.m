//
//  RootController.m
//  yamibo
//
//  Created by 李思良 on 15/7/11.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "RootController.h"
#import "MenuController.h"
#import "HomeController.h"
@interface RootController () {
    MenuController *leftDrawer;
}

@end

@implementation RootController

- (id)init {
    self = [super init];
    if (self) {
        [self initController];
    }
    return self;
}
- (void)initController {
    self.view.backgroundColor = [UIColor whiteColor];
    leftDrawer = [[MenuController alloc] init];
    self.centerViewController = [[UINavigationController alloc] initWithRootViewController:[[HomeController alloc] init]];

    self.leftDrawerViewController = leftDrawer;
    self.shouldStretchDrawer = NO;
    self.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningNavigationBar;
    self.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
//    self.showsShadow = false;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openCloseDrawer) name:KDrawerChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCenterViewController:) name:KChangeCenterViewNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEnable:) name:KDrawerEnableSwipeNotification object:nil];
}

- (void)openCloseDrawer
{
    if (self.openSide == MMDrawerSideLeft) {
        [self closeDrawerAnimated:true completion:nil];
    }
    else {
        [self openDrawerSide:MMDrawerSideLeft animated:true completion:nil];
    }
}
- (void)changeCenterViewController:(NSNotification*)notification
{
    CenterControllerIndex index = [notification.userInfo[kLeftDrawerSelectionIndexKey] intValue];
    switch (index) {
        case CenterControllerHome:
            self.centerViewController = [[UINavigationController alloc] initWithRootViewController:[[HomeController alloc] init]];
            self.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningNavigationBar;
            break;
        default:
            break;
    }
    [self closeDrawerAnimated:true completion:nil];
}
- (void)changeEnable:(NSNotification*)notification
{
    NSString* res = notification.userInfo[@"enable"];
    if ([res isEqualToString:@"N"]) {
        self.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    }
    else {
        self.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
