//
//  ArticleDetailWebView.m
//  yamibo
//
//  Created by 李思良 on 16/2/8.
//  Copyright © 2016年 lsl. All rights reserved.
//

#import "ArticleDetailWebView.h"
#import <WebKit/WebKit.h>

@interface ArticleDetailWebView() <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;


@end

@implementation ArticleDetailWebView

- (id)init {
    if (self = [super init]) {
        [self initWebView];
    }
    return self;
}


- (void)initWebView {
    _webView = [[WKWebView alloc] init];
    [self addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _webView.navigationDelegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ceshi.yamibo.com/chobits/v5/view.php?tid=239964&page=2&authorid=17804"]];
    [_webView loadRequest:request];
    
}


@end
