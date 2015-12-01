//
//  BlogModel.h
//  yamibo
//
//  Created by shuang yang on 11/29/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "JSONModel.h"

@protocol BlogModel
@end

@interface BlogModel : JSONModel
@property   (strong, nonatomic) NSString *blogId;
@property   (strong, nonatomic) NSString *title;
@property   (strong, nonatomic) NSString *date;
@property   (strong, nonatomic) NSString<Optional> *message;

@end

@interface BlogListModel : JSONModel
@property   (strong, nonatomic) NSArray<BlogModel> *blogList;
@end

@interface BlogDetailModel : JSONModel
@property   (strong, nonatomic) BlogModel *blog;
@end
