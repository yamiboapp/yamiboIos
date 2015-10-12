//
//  ThreadFavoriteModel.h
//  yamibo
//
//  Created by 李思良 on 15/9/27.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "JSONModel.h"

@protocol ThreadFavoriteModel
@end

@interface ThreadFavoriteModel : JSONModel

@property   (strong, nonatomic) NSString *favId;
@property   (strong, nonatomic) NSString *threadId;
@property   (strong, nonatomic) NSString *title;
@property   (strong, nonatomic) NSString *authorName;
@property   (strong, nonatomic) NSString *replyNum;
@property   (strong, nonatomic) NSString *date;

@end

@interface ThreadFavoriteListModel : JSONModel

@property (strong, nonatomic) NSArray<ThreadFavoriteModel> *favList;

@end