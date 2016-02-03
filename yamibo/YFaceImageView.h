//
//  YFaceImageView.h
//  yamibo
//
//  Created by 李思良 on 15/9/19.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FaceType) {
    FaceSmall = 0,
    FaceMiddle,
    FaceBig
};

@interface YFaceImageView : UIImageView

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *picUrl;
@property (assign, nonatomic) FaceType faceType;
@property (assign, nonatomic) BOOL clickable;

- (void)setUserId:(NSString *)uid andType:(FaceType)type;

@end
