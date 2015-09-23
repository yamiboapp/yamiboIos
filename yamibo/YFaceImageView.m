//
//  YFaceImageView.m
//  yamibo
//
//  Created by 李思良 on 15/9/19.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "YFaceImageView.h"

@interface YFaceImageView()

@end

@implementation YFaceImageView

-(instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openProfile)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setUserId:(NSString *)uid pic:(NSString *)pic {
    _userId = uid;
    _picUrl = pic;
    [self sd_setImageWithURL:[NSURL URLWithString:pic]];
}

- (void)openProfile {
    
}
@end
