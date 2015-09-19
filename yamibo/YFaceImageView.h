//
//  YFaceImageView.h
//  yamibo
//
//  Created by 李思良 on 15/9/19.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFaceImageView : UIImageView

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *picUrl;

- (void)setUserId:(NSString *)uid pic:(NSString *)pic;

@end
