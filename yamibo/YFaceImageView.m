//
//  YFaceImageView.m
//  yamibo
//
//  Created by 李思良 on 15/9/19.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "YFaceImageView.h"
#import "UrlConstance.h"
@interface YFaceImageView()

@property (copy, nonatomic) NSArray *typeNames;

@end

@implementation YFaceImageView

-(instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = true;
        self.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openProfile)];
        [self addGestureRecognizer:tap];
        _typeNames = @[@"small", @"middle", @"big"];
    }
    return self;
}

- (void)setUserId:(NSString *)uid andType:(FaceType)type{
    _userId = uid;
    _faceType = type;
    int nid = [uid intValue];
    _picUrl = [NSString stringWithFormat:@"%@uc_server/data/avatar/000/%.2d/%.2d/%2.d_avatar_%@.jpg", KURL, nid / 10000, (nid / 100) % 100, nid % 100, _typeNames[_faceType]];
    
    [self sd_setImageWithURL:[NSURL URLWithString:_picUrl]];
}

- (void)openProfile {
    
}
@end
