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

@property (strong, nonatomic) REMenu *rightMenu;
@property (strong, nonatomic) NSMutableArray *rightMenuNames;
@property (strong, nonatomic) NSMutableArray *rightMenuIds;

@end

@implementation ArticleListController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initView];
    [self initFooter];
    _subforumNames = [NSMutableArray arrayWithObject:_forumName];
    _subforumIds = [NSMutableArray arrayWithObject:_forumId];

}
- (void)configNavigation {
    [self showCustomNavigationMenuButton];
    self.title = _forumName;
    [self showCustomNavigationMoreButton];
}

- (void)initRightMenu {
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < [_rightMenuNames count]; i++) {
        [items addObject:[self menuItemAtIndex:i]];
    }
    _rightMenu = [[REMenu alloc] initWithItems:items];
    _rightMenu.itemHeight = KMENUITEMHEIGHT;
    _rightMenu.font = KFONT(12);
    _rightMenu.textColor = [UIColor whiteColor];
}
- (void)initArticleListView:(NSString *)fid andTypeId:(NSString *)tid andFilter:(NSString *)filter{
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
- (void)initView {
    [CommunicationrManager getArticleList:_forumId andPage:1 andFilter:@"" andTypeId:@"" andPerPage:@"1"
    completion:^(ArticleListModel *model, NSString *message) {
        //switch
        if ([model.subforumList count] > 0) {
            _hasSwith = YES;
            UIView *back = [[UIView alloc]init];
            back.backgroundColor = KCOLOR_YELLOW_FDF5D8;
            [self.view addSubview:back];
            [back mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(self.view);
                make.height.mas_equalTo(43);
            }];
            //subforum names
            for (int i = 0; i < [model.subforumList count]; ++i) {
                ForumModel *subforum = model.subforumList[i];
                [_subforumNames addObject:subforum.forumName];
                [_subforumIds addObject:subforum.forumId];
            }
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
        } else {
            _hasSwith = false;
        }
        //page count
        [self setPageNumber:1 andTotalPages:[model.articleNum intValue]/10];

        //article list
        [self initArticleListView:_forumId andTypeId:@"" andFilter:@""];
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
    //rightArrowBtn.bounds = CGRectMake(0, 0, 44, 45);
    
    
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
- (void)changeSeg:(HMSegmentedControl *)seg {
    long index = (long)seg.selectedSegmentIndex;
    _forumId = _subforumIds[index];
    [self initArticleListView:_forumId andTypeId:@"" andFilter:@""];
    _pageLabel.text = @"";
    [self.rightMenu close];
    self.rightMenu = nil;
}
- (void)refreshArticleList {
    [_articleListView refreshData];
}
- (void)newArticle {
    NSLog(@"create btn pressed\n");
}
- (void)previousPage {
    [_articleListView previousPage];
}
- (void)nextPage {
    [_articleListView nextPage];
}

- (REMenuItem *)menuItemAtIndex:(int)index {
    __typeof (self) __weak weakSelf = self;
    REMenuItem *item = [[REMenuItem alloc] initWithTitle:_rightMenuNames[index]
                                                subtitle:nil
                                                   image:nil
                                        highlightedImage:nil
                                                  action:^(REMenuItem *item) {
                                                      [weakSelf dealMenu:index];
                                                  }];
    return item;
}

- (void)dealMenu:(int)index {
    if (index == 0) { //全部
        [self initArticleListView:_forumId andTypeId:@"" andFilter:@""];
    } else if (index == 1) { //精华
        [self initArticleListView:_forumId andTypeId:_rightMenuIds[index] andFilter:@"digest"];
    } else {
        [self initArticleListView:_forumId andTypeId:_rightMenuIds[index] andFilter:@"typeid"];
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
- (void)loadData:(NSDictionary *)data {
    _forumId = data[@"forumId"];
    _forumName = data[@"forumName"];
}
#pragma mark ArticleListTabelViewDelegate
- (void)reloadRightMenu:(NSDictionary *)data {
    _rightMenuNames = [NSMutableArray arrayWithObjects:@"全部", @"精华", nil];
    _rightMenuIds = [NSMutableArray arrayWithObjects:@"", nil];
    [_rightMenuNames addObjectsFromArray:[data allValues]];
    [_rightMenuIds addObjectsFromArray:[data allKeys]];
    [self initRightMenu];
}
- (void)closeRightMenu {
    [self.rightMenu close];
}
- (void)setPageNumber:(NSInteger)page andTotalPages:(NSInteger)pageNum {
    _pageLabel.text = [NSString stringWithFormat:@"%ld/%ld", page, pageNum];
}
@end

