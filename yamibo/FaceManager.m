//
//  FaceManager.m
//  yamibo
//
//  Created by shuang yang on 8/27/16.
//  Copyright © 2016 lsl. All rights reserved.
//

#import "FaceManager.h"

@implementation FaceManager

+(instancetype)share {
    static FaceManager * m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[FaceManager alloc] init];
    });
    return m ;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self fetchAllFaces];
        [self fetchBigFaces];
    }
    return self;
}

- (void)fetchAllFaces {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"emotion_list" ofType:@"plist"];
    NSArray * arrFace = [NSArray arrayWithContentsOfFile:path];
    _AllFaces = arrFace;
}

- (void)fetchRecentlyFaces {
    NSUserDefaults * defauls = [NSUserDefaults standardUserDefaults];
    NSArray * arrFace = [defauls objectForKey:@"RecentlyFaces"];
    _RecentlyFaces = arrFace;
}

- (void)fetchBigFaces {
    
}

@end
