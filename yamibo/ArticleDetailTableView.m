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

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return @"header in section";
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 100;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kArticleDetailTableViewCell forIndexPath:indexPath];
    cell.textLabel.text = @"cell";
    return cell;
}


@end
