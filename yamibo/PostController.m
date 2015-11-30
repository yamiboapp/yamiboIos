//
//  PostController.m
//  yamibo
//
//  Created by shuang yang on 11/28/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "PostController.h"
#import "REMenu.h"
#import "UITextView+Placeholder.h"

#define KMENUITEMHEIGHT 40

@interface PostController ()<UITextViewDelegate>
@property (strong, nonatomic) NSString *forumId;
@property (strong, nonatomic) NSMutableArray *typeNames;
@property (strong, nonatomic) NSMutableArray *typeIds;
@property (strong, nonatomic) REMenu *typeMenu;

@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) UITextView *titleTextView;
@property (strong, nonatomic) UITextView *contentTextView;

@end

@implementation PostController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initTypeMenu];
    [self initTitleView];
    [self initContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configNavigation {
    [self showCustomNavigationBackButton];
    [self showCustomNavigationButtonWithTitle:@"发表"];
    self.title = @"发表主题";
}
- (void)initTypeMenu {
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < [_typeNames count]; i++) {
        [items addObject:[self menuItemAtIndex:i]];
    }
    _typeMenu = [[REMenu alloc] initWithItems:items];
    _typeMenu.itemHeight = KMENUITEMHEIGHT;
    _typeMenu.font = KFONT(12);
    _typeMenu.textColor = [UIColor whiteColor];
}
- (void)initTitleView {
    _line = [[UIView alloc] init];
    [self.view addSubview:_line];
    
    UIView *titleView = [[UIView alloc] init];
    [self.view addSubview:titleView];
    titleView.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    
    UIButton *typeSelectionButton = [[UIButton alloc] init];
    [titleView addSubview:typeSelectionButton];
    [typeSelectionButton setImage:[UIImage imageNamed:@"arrow-down-gray"] forState:UIControlStateNormal];
    [typeSelectionButton addTarget:self action:@selector(selectArticleType) forControlEvents:UIControlEventTouchUpInside];
    
    _titleTextView = [[UITextView alloc] init];
    [titleView addSubview:_titleTextView];
    _titleTextView.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    _titleTextView.font = KFONT(16);
    _titleTextView.textColor = KCOLOR_RED_6D2C1D;
    _titleTextView.placeholder = @"标题（最多可输入40个字符）";
    _titleTextView.delegate = self;
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(23);
        make.right.mas_equalTo(-23);
        make.height.mas_equalTo(3);
        make.top.mas_equalTo(55);
    }];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(_line.mas_top);
    }];
    [typeSelectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_line).offset(-12);
        make.width.height.mas_equalTo(40);
        make.bottom.equalTo(_line.mas_top);
    }];
    [_titleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(typeSelectionButton.mas_right).offset(-8);
        make.right.equalTo(_line);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(typeSelectionButton);
    }];

}
- (void)initContentView {
    UIView *contentView = [[UIView alloc] init];
    [self.view addSubview:contentView];
    contentView.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    
    _contentTextView = [[UITextView alloc] init];
    [contentView addSubview:_contentTextView];
    _contentTextView.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    _contentTextView.font = KFONT(15);
    _contentTextView.textColor = KCOLOR_RED_6D2C1D;
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(408);
    }];
    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(_line);
        make.top.bottom.equalTo(contentView);
    }];
}
- (void)initAttachemntListView {
    
}
- (void)initFooter {
    
}
- (void)loadData:(NSDictionary *)data {
    _forumId = data[@"forumId"];
    _typeNames = data[@"typeNames"];
    [_typeNames removeObjectAtIndex:0];
    _typeNames[0] = @"选择分类";
    _typeIds = data[@"typeIds"];
    [_typeIds removeObjectAtIndex:0];

}

- (REMenuItem *)menuItemAtIndex:(int)index {
    __typeof (self) __weak weakSelf = self;
    REMenuItem *item = [[REMenuItem alloc] initWithTitle:_typeNames[index]
                                               subtitle:nil
                                                  image:nil
                                       highlightedImage:nil
                                                 action:^(REMenuItem *item) {
                                                     [weakSelf dealMenu:index];
                                                 }];
    
    return item;
}
- (void)dealMenu:(int)index {
}

- (void)selectArticleType {
    if (self.typeMenu.isOpen)
        return [self.typeMenu close];
    [self.typeMenu showFromRect:CGRectMake(_line.left, _line.bottom, 80, self.view.height) inView:self.view];
}

- (void)onNavigationRightButtonClicked {
    NSLog(@"post button pressed");
}

#pragma mark UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return textView.text.length + (text.length - range.length) <= 40;
}
@end
