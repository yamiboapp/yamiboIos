//
//  ArticleListTableViewCell.h
//  yamibo
//
//  Created by shuang yang on 10/30/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KArticleListTableViewCell  @"KArticleListTableViewCell"

@class ArticleModel;

@interface ArticleListTableViewCell : UITableViewCell

- (void)loadData:(ArticleModel *)data andTypeName:(NSString *)typeName;

@end
