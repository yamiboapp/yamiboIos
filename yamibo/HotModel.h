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

@property   (strong, nonatomic) NSString *feedId;
@property   (strong, nonatomic) NSString *title;
@property   (strong, nonatomic) NSString *picUrl;
@property   (strong, nonatomic) NSString *authorName;
@property   (strong, nonatomic) NSString *authorId;
@property   (strong, nonatomic) NSString *replyNum;
@property   (strong, nonatomic) NSString *viewNum;
@property   (strong, nonatomic) NSString *lastPost;

@end

@interface HotModel : JSONModel

@property   (strong, nonatomic) NSArray<DataImg, ConvertOnDemand> *dataImg;
@property   (strong, nonatomic) NSArray<DataImg, ConvertOnDemand> *dataText;

@end
