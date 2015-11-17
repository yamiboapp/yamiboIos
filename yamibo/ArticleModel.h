//
//  ArticleModel.h
//  yamibo
//
//  Created by shuang yang on 10/25/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "JSONModel.h"
#import "ForumModel.h"

@protocol ArticleModel
@end

@interface ArticleModel : JSONModel

@property   (strong, nonatomic) NSString *articleId;
@property   (strong, nonatomic) NSString *readPermission;
@property   (strong, nonatomic) NSString *authorName;
@property   (strong, nonatomic) NSString *authorId;
@property   (strong, nonatomic) NSString *title;
@property   (strong, nonatomic) NSString *lastPost;
@property   (strong, nonatomic) NSString *lastPoster;
@property   (strong, nonatomic) NSString *replyNum;
@property   (strong, nonatomic) NSString *viewNum;
@property   (strong, nonatomic) NSString *typeId;
@property   (strong, nonatomic) NSString *isDigest;
@property   (strong, nonatomic) NSString *attachmentNum;
@property   (strong, nonatomic) NSString<Optional> *isClosed;

@end


@interface ArticleListModel : JSONModel

@property   (strong, nonatomic) NSArray<ArticleModel> *articleList;
@property   (strong, nonatomic) ForumModel *forum;
@property   (strong, nonatomic) NSArray<ForumModel> *subforumList;
@property   (strong, nonatomic) NSDictionary<Optional> *articleTypes;
@property   (strong, nonatomic) NSString *perPage;

@end
