


//
//  HomeBannerView.m
//  yamibo
//
//  Created by 李思良 on 15/9/18.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "HomeBannerView.h"
#import "SDCycleScrollView.h"
#import "HotModel.h"
#import "UrlConstance.h"

@interface HomeBannerView()<SDCycleScrollViewDelegate>
@property (strong, nonatomic) SDCycleScrollView *scroll;
@property (strong, nonatomic) NSMutableArray *bannerIds;
@end

@implementation HomeBannerView
- (id)init {
    if (self = [super init]) {
        _scroll = [[SDCycleScrollView alloc] init];
        [self addSubview:_scroll];
        _scroll.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _scroll.autoScrollTimeInterval = 5;
        _scroll.delegate = self;
    }
    return self;
}

- (void)loadData:(NSArray *)banners {
    if (banners.count == 0) {
        return;
    }
    NSMutableArray *names = [NSMutableArray array];
    NSMutableArray *pics = [NSMutableArray array];
    for (int i = 0; i < banners.count; i ++) {
        DataImg *data = banners[i];
        [names addObject:data.title];
        [pics addObject:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", KATTACHURL, data.picUrl]]];
        [_bannerIds addObject:data.feedId];
    }
    _scroll.titlesGroup = names;
    _scroll.imageURLsGroup = pics;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _scroll.frame = CGRectMake(0, 0, self.width, self.height);
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}
@end
