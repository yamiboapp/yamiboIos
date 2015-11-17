//
//  BaseViewController.m
//  yamibo
//
//  Created by 李思良 on 15/4/15.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController () {
}

@end

@implementation BaseViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = KCOLOR_YELLOW_FFEDBE;
    [self initNavigation];
}
- (void)initNavigation {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setBarTintColor:KCOLOR_RED_6D2C1D];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showCustomNavigationBackButton {
    [self showNomalNavigationLeftButton:@"" action:@selector(onNavigationLeftButtonClicked) imgName:@"back" frame:CGRectMake(0, 0, 9, 14)];
}

- (void)showCustomNavigationMenuButton {
    [self showNomalNavigationLeftButton:@"" action:@selector(onNavigationLeftButtonClicked) imgName:@"menu" frame:CGRectMake(0, 0, 15, 15)];
}

- (void)showCustomNavigationMoreButton {
    [self showNomalNavigationRightButtonWithImage:@"" action:@selector(onNavigationRightButtonClicked) imgName:@"more" frame:CGRectMake(0, 0, 18, 64)];
}

- (void)showCustomNavigationButtonWithTitle:(NSString *)title {
    [self showNomalNavigationRightButtonWithImage:title action:@selector(onNavigationRightButtonClicked) imgName:nil frame:CGRectMake(0, 0, 18, 64)];
}

- (void)showCustomNavigationCollectButton {
    [self showNomalNavigationRightButtonWithImage:@"" action:@selector(onNavigationRightButtonClicked) imgName:@"btn-fav" frame:CGRectMake(0, 0, 15, 14)];
}
   
- (void)showMessage:(NSString*)message;
{
    UILabel* tLabelTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 38)];
    tLabelTip.text = message;
    tLabelTip.font = [UIFont systemFontOfSize:15];
    tLabelTip.backgroundColor = [UIColor clearColor];
    tLabelTip.textColor = [UIColor whiteColor];
    tLabelTip.lineBreakMode = NSLineBreakByWordWrapping;
    tLabelTip.textAlignment = NSTextAlignmentCenter;
    tLabelTip.numberOfLines = 2;
    MBProgressHUD* hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.customView = tLabelTip;
    hud.mode = MBProgressHUDModeCustomView;

    CGSize SimpleTextSize = [tLabelTip contentSize];
    if (SimpleTextSize.width > 194) {
        tLabelTip.textAlignment = NSTextAlignmentLeft;
    }
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
}
- (void)showNomalNavigationLeftButton:(NSString *)title action:(SEL)selector imgName:(NSString *)imgName frame:(CGRect)frame
{
    //right barbutton view
    _navigationLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _navigationLeftButton = [[UIButton alloc] initWithFrame:frame];
    if (nil != imgName)
    {
        [_navigationLeftButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [_navigationLeftButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];
    }
    else
    {
        [_navigationLeftButton setTitle:title forState:UIControlStateNormal];
        [_navigationLeftButton setTitleColor:[UIColor hexChangeFloat:@"F4453C"] forState:UIControlStateNormal];
        [_navigationLeftButton setTitleColor:[UIColor hexChangeFloat:@"494949"] forState:UIControlStateDisabled];
        _navigationLeftButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
        [_navigationLeftButton sizeToFit];
    }
    [_navigationLeftButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnNavLeftItem = [[UIBarButtonItem alloc] initWithCustomView:_navigationLeftButton];
    self.navigationItem.leftBarButtonItem = btnNavLeftItem;
}
- (void)showNomalNavigationRightButtonWithImage:(NSString *)title action:(SEL)selector imgName:(NSString *)imgName frame:(CGRect)frame {
    //right barbutton view
    _navigationRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _navigationRightButton.frame = frame;
    if (nil != imgName)
    {
        [_navigationRightButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [_navigationRightButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];
    }
    else
    {
        [_navigationRightButton setTitle:title forState:UIControlStateNormal];
        [_navigationRightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_navigationRightButton setTitleColor:[UIColor hexChangeFloat:@"c3c9c9"] forState:UIControlStateDisabled];
        _navigationRightButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
        [_navigationRightButton sizeToFit];
    }
    
    [_navigationRightButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnNavRightItem = [[UIBarButtonItem alloc] initWithCustomView:_navigationRightButton];
    self.navigationItem.rightBarButtonItem = btnNavRightItem;
}

- (void)onNavigationLeftButtonClicked
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)onNavigationRightButtonClicked {
    
}
#pragma mark Hide/Show StatusBar
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
