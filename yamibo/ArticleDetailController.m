//
//  ArticleDetailController.m
//  yamibo
//
//  Created by ShaneWay on 15/10/15.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "ArticleDetailController.h"

#import "ArticleDetailTableView.h"

#import "YPostContentView.h"

#import "ArticleDetailWebView.h"


@interface ArticleDetailController ()<YPostContentViewDelegate>
{
    YPostContentView *_contentView;
    NSString *_message1;
}
@property (nonatomic, strong) ArticleDetailTableView *postList;
@property (nonatomic, strong) NSDictionary *paraDict;

@end

@implementation ArticleDetailController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configNavigation];
    [self initView];
    [self test];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToPreviousController:) name:kNotification_NeedToPop object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - configure
- (void)loadData:(NSDictionary *)data {
    _paraDict = data;
}

#pragma mark - Layout
- (void)configNavigation {
    [self showCustomNavigationBackButton];
    [self showCustomNavigationCollectButton];
    [self initSwitch];
}

- (void)initSwitch {
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"查看全部", @"只看楼主"]];
    segment.tintColor = KCOLOR_YELLOW_FDF5D8;
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(changeSegment:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
}

- (void)initView {
    _postList = [[ArticleDetailTableView alloc] initWithParaData:_paraDict];
    [self.view addSubview:_postList];
    [_postList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
//    [_postList refreshData];
}

- (void)test {
    ArticleDetailWebView *wb = [[ArticleDetailWebView alloc] init];
    [self.view addSubview:wb];
    [wb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loadThreadDetail {
    
    // 解析[attach]xxx[/attach] 查找attachlist 找到替换
    
    
    
    _contentView = [[YPostContentView alloc] init];
    _contentView.postContentViewDelegate = self;
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(10);
        make.trailing.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(-10);
//        make.height.mas_equalTo(_contentView.attributedTextContentView.frame.size.height);
    }];
    [_contentView setContentHtml:_message1];
    CGFloat height = _contentView.displayHeight;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}


//- (void)postContentView:(YPostContentView *)postContentView changeSize:(CGSize)size {
//    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(size.height);
//    }];
//}


#pragma mark - Click Events

- (void)changeSegment:(UISegmentedControl *)seg {
    NSLog(@"seg change index");
}


#pragma mark - Override Methods

- (void)onNavigationRightButtonClicked {
    NSLog(@"Fav Button Click");
}

#pragma mark - Observer
- (void)popToPreviousController:(NSNotification *)notification {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
