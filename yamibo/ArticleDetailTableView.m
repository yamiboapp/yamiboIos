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


@interface ArticleDetailTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *allPostArray;
@property (nonatomic, strong) NSMutableArray *opPostArray;

@end

@implementation ArticleDetailTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor cyanColor];
        self.dataSource = self;
        self.delegate = self;
        _allPostArray = [NSMutableArray array];
        _opPostArray = [NSMutableArray array];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:kArticleDetailTableViewCell];
    }
    return self;
}

- (void)refreshData {
    [self beginLoadNewData];
}

- (void)loadNewData {
    [self stopLoadNewData];
}

- (void)loadMoreData {
    NSLog(@"Load More");
}

- (BOOL)showHeaderRefresh {
    return YES;
}

- (BOOL)showFooterRefresh {
    return YES;
}


#pragma mark - UITableView Delegate and Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kArticleDetailTableViewCell forIndexPath:indexPath];
    cell.textLabel.text = @"cell";
    return cell;
}


@end
