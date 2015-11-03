//
//  ArticleDetailTableView.h
//  yamibo
//
//  Created by ShaneWay on 15/11/1.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "YTableView.h"

@interface ArticleDetailTableView : YTableView

- (instancetype)initWithParaData:(NSDictionary *)paraDict;
- (void)refreshData;

@end
