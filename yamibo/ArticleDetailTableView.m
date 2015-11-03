//
//  ArticleDetailTableView.m
//  yamibo
//
//  Created by ShaneWay on 15/11/1.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "ArticleDetailTableView.h"

#import "ArticleDetailTableViewCell.h"
#import "CommunicationrManager.h"
#import "ArticleDetailModel.h"


@interface ArticleDetailTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger threadID;
@property (nonatomic, assign) NSInteger authorID;

@property (nonatomic, assign) BOOL isHeaderDisplay;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ArticleDetailTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithParaData:(NSDictionary *)paraDict {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        _threadID = [[paraDict objectForKey:@"threadID"] integerValue];
        _authorID = [[paraDict objectForKey:@"authorID"] integerValue];
        _isHeaderDisplay = NO;
        [self registerClass:[ArticleDetailTableViewCell class] forCellReuseIdentifier:kArticleDetailTableViewCell];
        [self configureTableHeaderView];
    }
    return self;
}

- (void)configureTableHeaderView {
    UIView *headerView = [UIView new];
    headerView.height = 65;
    
    _titleLabel = [UILabel new];
    [headerView addSubview:_titleLabel];
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _titleLabel.font = KFONT(15);
    _titleLabel.textColor = KCOLOR_RED_6D2C1D;
    
    self.tableHeaderView = headerView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // masonry设置tableHeaderView会有警告
    _titleLabel.frame = CGRectMake(SCALE_NUM(45)/2, 0, self.tableHeaderView.frame.size.width-SCALE_NUM(45), self.tableHeaderView.frame.size.height);
}

- (void)refreshData {
    [self beginLoadNewData];
}

- (void)loadNewData {
    [CommunicationrManager getArticleDetailList:1 threadID:_threadID postPerPage:10 authorID:_authorID completion:^(ArticleDetailModel *model, NSString *message) {
        [self stopLoadNewData];
        if (message != nil) {
            [Utility showTitle:message];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_NeedToPop object:nil];
        } else {
            _dataArray = [NSMutableArray arrayWithArray:model.postList];
            _titleLabel.text = model.articleInfo.title;
        }
        if (model.postList.count < 10) {
            [self hiddenFooter:YES];
        } else {
            [self hiddenFooter:NO];
        }
        [self reloadData];
    }];
}

- (void)loadMoreData {
    NSLog(@"+++++");
    [_dataArray addObjectsFromArray:_dataArray];
    [self reloadData];
}

- (BOOL)showHeaderRefresh {
    return YES;
}

- (BOOL)showFooterRefresh {
    return YES;
}


#pragma mark - UITableView Delegate and Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostModel *postModel = _dataArray[indexPath.row];
    ArticleDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kArticleDetailTableViewCell forIndexPath:indexPath];
    cell.textLabel.text = postModel.postContent;
    return cell;
}


@end
