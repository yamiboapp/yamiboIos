//
//  YPostContentView.h
//  yamibo
//
//  Created by ShaneWay on 15/10/15.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import <DTCoreText/DTCoreText.h>

@class YPostContentView;

@protocol YPostContentViewDelegate <NSObject>

- (void)postContentView:(YPostContentView *)postContentView changeSize:(CGSize)size;

@end

@interface YPostContentView : DTAttributedTextView

@property (nonatomic, weak) id<YPostContentViewDelegate> postContentViewDelegate;
@property (nonatomic, assign, readonly) CGFloat displayHeight;


- (void)setContentHtml:(NSString *)html;

#pragma mark - TODO
#pragma mark 适配autolayout(暂时没找到解决方法)

@end
