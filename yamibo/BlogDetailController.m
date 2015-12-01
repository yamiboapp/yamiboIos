//
//  BlogDetailControllerViewController.m
//  yamibo
//
//  Created by shuang yang on 11/30/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "BlogDetailController.h"
#import "CommunicationrManager.h"
#import "BlogModel.h"
#import "YTableView.h"

@interface BlogDetailController ()
@property (strong, nonatomic) NSString *blogId;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@end

@implementation BlogDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self configNavigation];
    [self initView];
}
- (void)configNavigation {
    [self showCustomNavigationBackButton];
}
- (void)initView {
    [self.view addSubview:_titleLabel];
    _titleLabel.font = KFONT(15);
    _titleLabel.textColor = KCOLOR_RED_6D2C1D;
    _titleLabel.numberOfLines = 0;

    UIScrollView *contentView = [[UIScrollView alloc] init];
    [self.view addSubview:contentView];
    
    UIView *contentBackView = [[UIView alloc] init];
    [contentView addSubview:contentBackView];
    contentBackView.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    
    _contentLabel = [[UILabel alloc] init];
    [contentView addSubview:_contentLabel];
    _contentLabel.font = KFONT(15);
    _contentLabel.textColor = KCOLOR_RED_6D2C1D;
    _contentLabel.numberOfLines = 0;
    _contentLabel.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    
    _timeLabel = [[UILabel alloc] init];
    [contentView addSubview:_timeLabel];
    _timeLabel.textColor = KCOLOR_GRAY;
    _timeLabel.font = KFONT(13);
    _timeLabel.backgroundColor = KCOLOR_YELLOW_FDF5D8;

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(23);
        make.right.mas_offset(-23);
        make.top.mas_offset(17);
        make.bottom.equalTo(contentView.mas_top).mas_offset(-17);
    }];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
    }];
    [contentBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.bottom.equalTo(contentView);
    }];
    
    [Utility showTitle:@"正在加载日志..."];
    [CommunicationrManager getBlogDetailWithBlogId:_blogId completion:^(BlogDetailModel *model, NSString *message) {
        if (message != nil) {
            [Utility showTitle:message];
        } else {
            //_contentLabel.text = model.blog.message;
            _contentLabel.text = [model.blog.message stringByReplacingOccurrencesOfString: @"        &nbsp;    " withString:@"\n"];
            _contentLabel.text = [_contentLabel.text stringByReplacingOccurrencesOfString: @"&nbsp;" withString:@"\n"];
            _contentLabel.text = [_contentLabel.text stringByReplacingOccurrencesOfString: @"    " withString:@"\n"];
            _contentLabel.text = [_contentLabel.text stringByReplacingOccurrencesOfString: @"  " withString:@""];

            _timeLabel.text = model.blog.date;
        }
        [Utility hiddenProgressHUD];

        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_titleLabel);
            make.top.equalTo(contentView).offset(20);
        }];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_titleLabel);
            make.top.equalTo(_contentLabel.mas_bottom).offset(20);
            make.bottom.equalTo(contentBackView).offset(-20);
        }];
    }];


}

- (void)loadDate:(NSDictionary *)data {
    _blogId = data[@"blogId"];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = [data[@"title"] stringFromHTML];
}
@end
