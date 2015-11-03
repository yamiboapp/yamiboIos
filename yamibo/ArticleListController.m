//
//  ArticleListController.m
//  yamibo
//
//  Created by shuang yang on 10/25/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "ArticleListController.h"
#import "HMSegmentedControl.h"
#import "CommunicationrManager.h"
#import "ArticleModel.h"
#import "ArticleListTableView.h"
#import "REMenu.h"

#define KMENUITEMHEIGHT 40

@interface ArticleListController()

@property (strong, nonatomic) NSString *forumId;
@property (strong, nonatomic) NSString *forumName;
@property (strong, nonatomic) NSMutableArray *subforumNames;
@property (strong, nonatomic) NSMutableArray *subforumIds;
@property (strong, nonatomic) ArticleListTableView *articleListView;
@property (assign, nonatomic) BOOL hasSwith;

@property (strong, nonatomic) REMenu *rightMenu;
@property (strong, nonatomic) NSArray *rightMenuNames;
@property (strong, nonatomic) NSArray *rightMenuIds;

@end

@implementation ArticleListController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initView];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToDetailController:) name:KNotification_ToArticleDetail object:nil];
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
- (void)initArticleListView:(NSString *)fid andTypeId:(NSString *)tid{
    if (_articleListView) {
        [_articleListView removeFromSuperview];
    }
    _articleListView = [[ArticleListTableView alloc] initWithForumId:fid andTypeId:tid];
    [self.view addSubview:_articleListView];
    if (_hasSwith) {
        [_articleListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.mas_equalTo(44);
        }];
    } else {
        [_articleListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
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
        
        //right menu
        _rightMenuNames = [model.articleTypes allValues];
        _rightMenuIds = [model.articleTypes allKeys];
        [self initRightMenu];
        
        [self initArticleListView:_forumId andTypeId:@""];
    }];
}

- (void)changeSeg:(HMSegmentedControl *)seg {
    long index = (long)seg.selectedSegmentIndex;
    [self initArticleListView:_subforumIds[index] andTypeId:@""];
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
    [self initArticleListView:_forumId andTypeId:_rightMenuIds[index]];
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
    _forumId = data[@"forumID"];
    _forumName = data[@"forumName"];
}

@end

