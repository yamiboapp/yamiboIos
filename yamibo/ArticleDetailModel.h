//
//  ArticleDetailModel.h
//  yamibo
//
//  Created by ShaneWay on 15/11/1.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ArticleModel.h"

@protocol PostModel <NSObject>
@end
@interface PostModel : JSONModel

@property (nonatomic, copy) NSString *postID;
@property (nonatomic, copy) NSString *articleID;
@property (nonatomic, copy) NSString *floorNum;
@property (nonatomic, copy) NSString *authorName;
@property (nonatomic, copy) NSString *authorID;
@property (nonatomic, copy) NSString *postTime;
@property (nonatomic, copy) NSString *postContent;

@end


@interface ArticleDetailModel : JSONModel

@property (nonatomic, strong) ArticleModel *articleInfo;
@property (nonatomic, strong) NSArray<PostModel> *postList;

@end
