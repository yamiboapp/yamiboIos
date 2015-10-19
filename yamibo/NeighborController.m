//
//  NeighborController.m
//  yamibo
//
//  Created by 李思良 on 15/9/20.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "NeighborController.h"
#import "REMenu.h"
#import "NeighborTableView.h"

#define KMENUITEMHEIGHT 40

@interface NeighborController()
@property (strong, nonatomic) REMenu *menu;
@property (strong, nonatomic) NSArray *menuNames;
@property (strong, nonatomic) NSArray *menuImgNames;
@end

@implementation NeighborController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigation];
    [self initTableView];
}
- (void) configNavigation {
    [self showCustomNavigationMenuButton];
    self.title = @"附近的人";
    [self showCustomNavigationMoreButton];
    [self initMenu];
}
- (void)initMenu {
    _menuNames = @[@"只看妹子", @"只看汉子", @"性别不限", @"清除位置", @"隐私设置"];
    _menuImgNames = @[@"menu-neighbor-female", @"menu-neighbor-male", @"menu-neighbor-allgender", @"menu-neighbor-clear", @"menu-neighbor-clear"];
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        [items addObject:[self menuItemAtIndex:i]];
    }
    _menu = [[REMenu alloc] initWithItems:items];
    _menu.itemHeight = KMENUITEMHEIGHT;
    _menu.font = KFONT(12);
    _menu.textColor = [UIColor whiteColor];
}
- (void)initTableView {
    NeighborTableView *tableView = [[NeighborTableView alloc] init];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [tableView refreshData];
}
- (REMenuItem *)menuItemAtIndex:(int)index {
    __typeof (self) __weak weakSelf = self;
    REMenuItem *item = [[REMenuItem alloc] initWithTitle:_menuNames[index]
                                                subtitle:nil
                                                       image:[UIImage imageNamed:_menuImgNames[index]]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          [weakSelf dealMenu:index];
                                                      }];
    return item;
}

- (void)dealMenu:(int)index {
    
}

- (void)onNavigationLeftButtonClicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:KDrawerChangeNotification object:nil];
}
- (void)onNavigationRightButtonClicked {
    if (self.menu.isOpen)
        return [self.menu close];
    
    [self.menu showFromRect:CGRectMake(self.view.right - 100, 0, 120, self.view.height) inView:self.view];
}
@end
