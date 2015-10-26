//
//  HotModel.h
//  yamibo
//
//  Created by 李思良 on 15/9/26.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "JSONModel.h"

@protocol DataImg
@end

@interface DataImg : JSONModel

@property   (strong, nonatomic) NSString<Optional> *feedId;
@property   (strong, nonatomic) NSString<Optional> *title;
@property   (strong, nonatomic) NSString *picUrl;
@property   (strong, nonatomic) NSString<Optional> *authorName;
@property   (strong, nonatomic) NSString<Optional> *authorId;
@property   (strong, nonatomic) NSString<Optional> *replyNum;
@property   (strong, nonatomic) NSString<Optional> *viewNum;
@property   (strong, nonatomic) NSString *lastPost;

@end

@interface HotModel : JSONModel

@property   (strong, nonatomic) NSArray<DataImg> *dataImg;
@property   (strong, nonatomic) NSArray<DataImg> *dataText;

@end
