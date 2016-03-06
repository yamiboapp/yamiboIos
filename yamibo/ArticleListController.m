//
//  ArticleListController.m
//  yamibo
//
//  Created by shuang yang on 10/25/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "ArticleListController.h"
#import "ArticleModel.h"
#import "ArticleListTableView.h"
#import "ArticleDetailController.h"
#import "NewPostController.h"
#import "CommunicationrManager.h"
#import "HMSegmentedControl.h"
#import "REMenu.h"

#define KMENUITEMHEIGHT 40

@interface ArticleListController()<ArticleListTabelViewDelegate>

@property (strong, nonatomic) NSString *forumId;
@property (strong, nonatomic) NSString *forumName;

@property (strong, nonatomic) NSMutableArray *subforumNames;
@property (strong, nonatomic) NSMutableArray *subforumIds;
@property (assign, nonatomic) BOOL hasSwith;
@property (strong, nonatomic) ArticleListTableView *articleListView;
@property (strong, nonatomic) UILabel *pageLabel;

@property (strong, nonatomic) REMenu *middleMenu;
@property (strong, nonatomic) NSMutableArray *middleMenuNames;
@property (strong, nonatomic) NSMutableArray *middleMenuIds;
@property (strong, nonatomic) NSMutableArray *forumNameList;
@property (strong, nonatomic) NSMutableArray *forumIdList;

@property (strong, nonatomic) REMenu *rightMenu;
@property (strong, nonatomic) NSMutableArray *rightMenuNames;
@property (strong, nonatomic) NSMutableArray *rightMenuIds;
@property (assign, nonatomic) BOOL didLoadRightMenu;

@property (strong, nonatomic) UIButton *titleBtn;


@end

@implementation ArticleListController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configure];
}
- (void)configure {
    [self configNavigation];
    [self initView];
    [self initFooter];
    [self initMiddleMenu];
    _subforumNames = [NSMutableArray arrayWithObject:_forumName];
    _subforumIds = [NSMutableArray arrayWithObject:_forumId];
}
- (void)viewWillAppear:(BOOL)animated {
    _titleBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
}
- (void)configNavigation {
    [self showCustomNavigationMenuButton];
    //self.title = _forumName;
    [self showCustomNavigationMoreButton];
    
    _titleBtn = [[UIButton alloc] init];
    [_titleBtn setTitle:[NSString stringWithFormat:@"%@ ",_forumName] forState:UIControlStateNormal];
    _titleBtn.titleLabel.tintColor =[UIColor whiteColor];
    self.navigationItem.titleView = _titleBtn;
    [_titleBtn setImage:[UIImage imageNamed:@"arrow-down-white"] forState:UIControlStateNormal];
    _titleBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    _titleBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    _titleBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);

    [_titleBtn sizeToFit];
    [_titleBtn addTarget:self action:@selector(onNavigationTitleButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initRightMenu {
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < [_rightMenuNames count]; i++) {
        [items addObject:[self menuItemAtIndex:i withMenu:@"right"]];
    }
    _rightMenu = [[REMenu alloc] initWithItems:items];
    _rightMenu.itemHeight = KMENUITEMHEIGHT;
    _rightMenu.font = KFONT(12);
    _rightMenu.textColor = [UIColor whiteColor];
}
- (void)initMiddleMenu {
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < [_middleMenuNames count]; i++) {
        [items addObject:[self menuItemAtIndex:i withMenu:@"middle"]];
    }
    _middleMenu = [[REMenu alloc] initWithItems:items];
    _middleMenu.itemHeight = KMENUITEMHEIGHT;
    _middleMenu.font = KFONT(12);
    _middleMenu.textColor = [UIColor whiteColor];
}
- (void)initArticleListViewWithFid:(NSString *)fid andTypeId:(NSString *)tid andFilter:(NSString *)filter{
    _didLoadRightMenu = NO;
    if (_articleListView) {
        [_articleListView removeFromSuperview];
    }
    _articleListView = [[ArticleListTableView alloc] initWithForumId:fid andFilter:filter andTypeId:tid];
    [self.view addSubview:_articleListView];
    [_articleListView setTableViewDelegate:self];
    
    //constraint
    if (_hasSwith) {
        [_articleListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.mas_equalTo(44);
            make.bottom.mas_equalTo(-44);
        }];
    } else {
        [_articleListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.bottom.mas_equalTo(-44);
        }];
    }
    [_articleListView refreshData];
}
- (void)initSegment {
    UIView *back = [[UIView alloc]init];
    back.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(43);
    }];
    
    HMSegmentedControl *segment = [[HMSegmentedControl alloc] initWithSectionTitles:_subforumNames];
    segment.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                   KCOLOR_GRAY, NSForegroundColorAttributeName,
                                   KFONT(15), NSFontAttributeName,
                                   nil];
    segment.selectedTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                           KCOLOR_RED_6D2C1D, NSForegroundColorAttributeName,
                                           KFONT(15), NSFontAttributeName,
                                           nil];
    segment.selectionIndicatorColor = KCOLOR_RED_6D2C1D;
    segment.backgroundColor = [UIColor clearColor];
    segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segment.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segment.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
    segment.userDraggable = YES;
    segment.segmentEdgeInset = UIEdgeInsetsMake(0, 20, 0, 20);
    segment.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 20);
    segment.selectedSegmentIndex = 0;
    
    [back addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(back).insets(UIEdgeInsetsMake(0, 20, 0, 20));
    }];
    
    [segment addTarget:self action:@selector(changeSeg:) forControlEvents:UIControlEventValueChanged];
}
- (void)initView {
    [CommunicationrManager getArticleList:_forumId andPage:1 andFilter:@"" andTypeId:@"" andPerPage:@"1"
    completion:^(ArticleListModel *model, NSString *message) {
        //switch
        if ([model.subforumList count] > 0) {
            _hasSwith = YES;

            //subforum names
            for (int i = 0; i < [model.subforumList count]; ++i) {
                ForumModel *subforum = model.subforumList[i];
                [_subforumNames addObject:subforum.forumName];
                [_subforumIds addObject:subforum.forumId];
            }
            [self initSegment];
        } else {
            _hasSwith = false;
        }
        //page count
        [self setPageNumber:1 andTotalPages:[model.articleNum intValue]/10];

        //article list
        [self initArticleListViewWithFid:_forumId andTypeId:@"" andFilter:@""];
    }];
}
- (void)initFooter {
    UIView *footerView = [[UIView alloc] init];
    [self.view addSubview:footerView];

    UIButton *refreshBtn = [[UIButton alloc] init];
    UIImage *refreshImg = [UIImage imageNamed:@"btn-refresh"];
    [refreshBtn setImage:refreshImg forState:UIControlStateNormal];
    [footerView addSubview:refreshBtn];
    [refreshBtn addTarget:self action:@selector(refreshArticleList) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *createBtn = [[UIButton alloc] init];
    UIImage *createImg = [UIImage imageNamed:@"btn-create"];
    [createBtn setImage:createImg forState:UIControlStateNormal];
    [footerView addSubview:createBtn];
    [createBtn addTarget:self action:@selector(newArticle) forControlEvents:UIControlEventTouchUpInside];

    UIButton *rightArrowBtn = [[UIButton alloc] init];
    [rightArrowBtn setImage:[UIImage imageNamed:@"arrow-right"] forState:UIControlStateNormal];
    [footerView addSubview:rightArrowBtn];
    [rightArrowBtn addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *leftArrowBtn = [[UIButton alloc] init];
    [leftArrowBtn setImage:[UIImage imageNamed:@"arrow-left"] forState:UIControlStateNormal];
    [footerView addSubview:leftArrowBtn];
    [leftArrowBtn addTarget:self action:@selector(previousPage) forControlEvents:UIControlEventTouchUpInside];

    _pageLabel = [[UILabel alloc] init];
    [footerView addSubview:_pageLabel];
    _pageLabel.font = KFONT(15);
    _pageLabel.textColor = KCOLOR_RED_6D2C1D;
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    
    //constraint
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    [refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footerView);
        make.left.equalTo(footerView).offset(13);
        make.width.height.mas_equalTo(40);
    }];
    [createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footerView);
        make.left.equalTo(refreshBtn.mas_right).offset(5);
        make.width.height.mas_equalTo(40);
    }];
    [rightArrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(footerView).offset(-8);
        make.centerY.equalTo(footerView);
        make.width.height.mas_equalTo(40);
    }];
    [_pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footerView);
        make.right.equalTo(rightArrowBtn.mas_left).offset(-5);
    }];
    [leftArrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footerView);
        make.right.equalTo(_pageLabel.mas_left).offset(-5);
        make.width.height.mas_equalTo(40);
    }];
}
- (void)loadData:(NSDictionary *)data {
    _forumId = data[@"forumId"];
    _forumName = data[@"forumName"];
    
    _forumNameList = data[@"forumNameList"];
    _middleMenuNames = [_forumNameList mutableCopy];
    [_middleMenuNames removeObject:_forumName];
    
    _forumIdList = data[@"forumIdList"];
    _middleMenuIds = [_forumIdList mutableCopy];
    [_middleMenuIds removeObject:_forumId];
}
#pragma mark segment
- (void)changeSeg:(HMSegmentedControl *)seg {
    long index = (long)seg.selectedSegmentIndex;
    _forumId = _subforumIds[index];
    [self initArticleListViewWithFid:_forumId andTypeId:@"" andFilter:@""];
    _pageLabel.text = @"";
    [self.rightMenu close];
    self.rightMenu = nil;
}
#pragma mark footer
- (void)refreshArticleList {
    [_articleListView refreshData];
}
- (void)newArticle {
    if (_didLoadRightMenu) {
        NewPostController *newPostController = [[NewPostController alloc] init];
        NSDictionary *dic = @{
                              @"forumId":_forumId,
                              @"typeNames":_rightMenuNames,
                              @"typeIds":_rightMenuIds
                              };
        [newPostController loadData:dic];
        [self.navigationController pushViewController:newPostController animated:YES];
    }
}
- (void)previousPage {
    [_articleListView previousPage];
}
- (void)nextPage {
    [_articleListView nextPage];
}
#pragma mark navigation bar
- (REMenuItem *)menuItemAtIndex:(int)index withMenu:(NSString *)menu{
    __typeof (self) __weak weakSelf = self;
    REMenuItem *item;
    if ([menu isEqualToString:@"right"]) { //right menu
        item = [[REMenuItem alloc] initWithTitle:_rightMenuNames[index]
                                        subtitle:nil
                                           image:nil
                                highlightedImage:nil
                                          action:^(REMenuItem *item) {
                                              [weakSelf dealMenu:index withMenu:@"right"];
                                          }];
    } else { //middle menu
        item = [[REMenuItem alloc] initWithTitle:_middleMenuNames[index]
                                        subtitle:nil
                                           image:nil
                                highlightedImage:nil
                                          action:^(REMenuItem *item) {
                                              [weakSelf dealMenu:index withMenu:@"middle"];
                                          }];
    }
    return item;
}

- (void)dealMenu:(int)index withMenu:(NSString *)menu {
    if ([menu isEqualToString:@"right"]) {
        if (index == 0) { //全部
            [self initArticleListViewWithFid:_forumId andTypeId:@"" andFilter:@""];
        } else if (index == 1) { //精华
            [self initArticleListViewWithFid:_forumId andTypeId:_rightMenuIds[index] andFilter:@"digest"];
        } else {
            [self initArticleListViewWithFid:_forumId andTypeId:_rightMenuIds[index] andFilter:@"typeid"];
        }
    } else {
        //ArticleListController *articleListController = [[ArticleListController alloc] init];
        NSDictionary *dic = @{
                              @"forumId":_middleMenuIds[index],
                              @"forumName":_middleMenuNames[index],
                              @"forumIdList":_forumIdList,
                              @"forumNameList":_forumNameList
                              };
        [self loadData:dic];
        for (UIView *view in self.view.subviews) {
            [view removeFromSuperview];
        }
        [self configure];
    }
}

- (void)onNavigationLeftButtonClicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:KDrawerChangeNotification object:nil];
}
- (void)onNavigationRightButtonClicked {
    if (self.rightMenu.isOpen)
        return [self.rightMenu close];
    [self.rightMenu showFromRect:CGRectMake(self.view.right - 80, 0, 80, self.view.height) inView:self.view];
}
- (void)onNavigationTitleButtonClicked {
    if (self.middleMenu.isOpen)
        return [self.middleMenu close];
    [self.middleMenu showFromRect:CGRectMake(self.view.right / 2 - 100, 0, 200, self.view.height) inView:self.view];
}
#pragma mark ArticleListTabelViewDelegate
- (void)reloadRightMenu:(NSDictionary *)data {
    _rightMenuNames = [NSMutableArray arrayWithObjects:@"全部", @"精华", nil];
    _rightMenuIds = [NSMutableArray arrayWithObjects:@"", @"", nil];
    [_rightMenuNames addObjectsFromArray:[data allValues]];
    [_rightMenuIds addObjectsFromArray:[data allKeys]];
    [self initRightMenu];
    _didLoadRightMenu = YES;
}
- (void)closeRightMenu {
    [self.rightMenu close];
}
//TODO: 选择type后无法计算页数, 需要修改api
- (void)setPageNumber:(NSInteger)page andTotalPages:(NSInteger)pageNum {
    _pageLabel.text = [NSString stringWithFormat:@"%ld/%ld", page, pageNum];
}
@end

