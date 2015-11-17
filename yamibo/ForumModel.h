//
//  ForumModel.h
//  yamibo
//
//  Created by 李思良 on 15/9/26.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "JSONModel.h"

@protocol ForumModel

@end

@interface ForumModel : JSONModel

@property   (strong, nonatomic) NSString *forumId;
@property   (strong, nonatomic) NSString *forumName;
@property   (strong, nonatomic) NSString<Optional> *todayPosts;
@property   (strong, nonatomic) NSString<Optional> *content;

@end


@interface ForumListModel : JSONModel

@property   (strong, nonatomic) NSArray<ForumModel> *forumList;

@end
