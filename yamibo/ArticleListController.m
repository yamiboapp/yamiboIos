//
//  ArticleListController.m
//  yamibo
//
//  Created by shuang yang on 10/25/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "ArticleListController.h"
#import "HMSegmentedControl.h"

@interface ArticleListController()

@property (strong, nonatomic) UIView *forumId;
@property (strong, nonatomic) UIView *forumName;

@end

@implementation ArticleListController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigation];
    [self initSwitch];
    [self initView];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToDetailController:) name:KNotification_ToArticleDetail object:nil];
}
- (void)configNavigation {
    [self showCustomNavigationMenuButton];
    [self showCustomNavigationNewButton];
    self.title = @"";
}
- (void)initView {
    
}
- (void)initSwitch {
    UIView *back = [[UIView alloc]init];
    back.backgroundColor = KCOLOR_YELLOW_FDF5D8;
    [self.view addSubview:back];
    
    HMSegmentedControl *segment = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"", @""]];
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
    segment.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    segment.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, -20, 0, -40);
    segment.selectedSegmentIndex = 0;
    
    [back addSubview:segment];
    
    // constrains
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(43);
    }];
    
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(back).insets(UIEdgeInsetsMake(0, 50, 0, 50));
    }];
    
    [segment addTarget:self action:@selector(changeSeg:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)changeSeg:(HMSegmentedControl *)seg {
    long index = (long)seg.selectedSegmentIndex;
    
    
}
- (void)onNavigationLeftButtonClicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:KDrawerChangeNotification object:nil];
}
- (void)loadData:(NSDictionary *)data {
    _forumId = data[@"forumID"];
    _forumName = data[@"forumName"];
}

@end

