//
//  ArticleDetailTableViewCell.h
//  yamibo
//
//  Created by ShaneWay on 15/11/1.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kArticleDetailTableViewCell @"kArticleDetailTableViewCell"

@class PostModel;

@interface ArticleDetailTableViewCell : UITableViewCell

- (void)loadData:(PostModel *)postModel;

@end
