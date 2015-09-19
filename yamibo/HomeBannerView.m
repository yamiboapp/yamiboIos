


//
//  HomeBannerView.m
//  yamibo
//
//  Created by 李思良 on 15/9/18.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "HomeBannerView.h"
#import "SDCycleScrollView.h"
@interface HomeBannerView()<SDCycleScrollViewDelegate>
@property (strong, nonatomic) SDCycleScrollView *scroll;
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

- (void)layoutSubviews {
    [super layoutSubviews];
    _scroll.frame = CGRectMake(0, 0, self.width, self.height);
    _scroll.titlesGroup = @[@"南ことり", @"南ことり"];
    _scroll.imageURLsGroup = @[[NSURL URLWithString:@"http://m.qqzhi.com/upload/img_2_1833688483D123127279_23.jpg"], [NSURL URLWithString:@"http://i0.hdslb.com/video/31/3195c77f00c38ccefd8fba16e49a151c.jpg"]];
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}
@end
