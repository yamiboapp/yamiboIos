//
//  YFaceKeyBoardView.m
//  yamibo
//
//  Created by shuang yang on 8/27/16.
//  Copyright © 2016 lsl. All rights reserved.
//

#import "FaceManager.h"
#import "YFaceKeyBoardView.h"

@interface YFaceKeyBoardView ()<UIScrollViewDelegate> {
    CGFloat _FKBViewH;
}

@property(nonatomic, strong) NSArray* arrFace;
@property(nonatomic, strong) UIScrollView* scFace;
@property(nonatomic, strong) FaceKeyBoardBlock block;
@property(nonatomic, strong) FaceKeyBoardDeleteBlock deleteBlock;
@property(nonatomic, strong) UIToolbar* toolBar;
@property(nonatomic, strong) UIPageControl* pageC;

@property(nonatomic, strong) FaceManager* FManager;

@end

@implementation YFaceKeyBoardView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setViewFrame];
        [self loadKeyBoardView];
    }
    return self;
}

- (void)setViewFrame {
    CGFloat marginY = (ScreenWidth - 7 * 30) / (7 + 1);
    CGFloat scViewH = 3 * (30 + marginY) + marginY * 2 + 10;
    _FKBViewH = scViewH + ToolBarHeight;
    self.frame = CGRectMake(0, ScreenHeight - _FKBViewH, ScreenWidth, _FKBViewH);
}

- (void)loadKeyBoardView {
    //初始化manager
    self.FManager = [FaceManager share];
    //获取数据
    [self fetchAllFaces];
    //设置toolBar
    [self setToolBar];
}

- (void)fetchRecentlyFaces {
    //更新manager
    [self.FManager fetchRecentlyFaces];
    self.arrFace = self.FManager.RecentlyFaces;
    [self setFaceFrame];
}

- (void)fetchAllFaces {
    self.arrFace = self.FManager.AllFaces;
    //设置表情scrollView
    [self setFaceFrame];
}

- (void)fetchBigFaces {
    self.arrFace = nil;
    [self setFaceFrame];
}

- (void)setFaceFrame {
    //列数
    NSInteger colFaces = 7;
    //行数
    NSInteger rowFaces = 3;
    //设置face按钮frame
    CGFloat FaceW = 30;
    CGFloat FaceH = 30;
    CGFloat marginX = (ScreenWidth - colFaces * FaceW) / (colFaces + 1);
    CGFloat marginY = marginX;
    NSLog(@"%lf", marginX);
    
    //表情数量
    NSInteger FaceCount = self.arrFace.count;
    //每页表情数和scrollView页数；
    NSInteger PageFaceCount = colFaces * rowFaces;
    NSInteger SCPages = FaceCount / PageFaceCount + 1;
    
    CGFloat scViewH = rowFaces * (FaceH + marginY) + marginY * 2 + 10;
    //初始化scrollView
    self.scFace = [[UIScrollView alloc]
                   initWithFrame:CGRectMake(0, 0, ScreenWidth, scViewH)];
    self.scFace.contentSize = CGSizeMake(ScreenWidth * SCPages, scViewH);
    self.scFace.pagingEnabled = YES;
    self.scFace.bounces = NO;
    self.scFace.delegate = self;
    [self addSubview:self.scFace];
    //初始化贴在sc上的view
    UIView* BtnView = [[UIView alloc] init];
    BtnView.frame = CGRectMake(0, 0, ScreenWidth * SCPages, scViewH);
    [BtnView setBackgroundColor:GrayColor];
    [self.scFace addSubview:BtnView];
    
    for (NSInteger i = 0; i < FaceCount + SCPages; i++) {
        //当前页数
        NSInteger currentPage = i / PageFaceCount;
        //当前行
        NSInteger rowIndex = i / colFaces - (currentPage * rowFaces);
        //当前列
        NSInteger colIndex = i % colFaces;
        
        // viewW * currentPage换页
        CGFloat btnX =
        marginX + colIndex * (FaceW + marginX) + ScreenWidth * currentPage;
        CGFloat btnY = rowIndex * (marginY + FaceH) + marginY;
        if ((i - (currentPage + 1) * (PageFaceCount - 1) == currentPage ||
             i == FaceCount + SCPages - 1) &&
            self.arrFace) {
            //创建删除按钮
            CGFloat btnDelteX = (currentPage + 1) * ScreenWidth - (marginX + FaceW);
            CGFloat btnDelteY = 2 * (FaceH + marginY) + marginY;
            
            UIButton* btnDelte = [UIButton buttonWithType:UIButtonTypeSystem];
            btnDelte.frame = CGRectMake(btnDelteX, btnDelteY, FaceW, FaceH);
            [btnDelte setBackgroundImage:[UIImage imageNamed:@"icon_delete-2"]
                                forState:UIControlStateNormal];
            [btnDelte setTitleColor:[UIColor blackColor]
                           forState:UIControlStateNormal];
            btnDelte.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            
            [btnDelte addTarget:self
                         action:@selector(tapDeleteBtn)
               forControlEvents:UIControlEventTouchUpInside];
            
            [BtnView addSubview:btnDelte];
        } else {
            //创建face按钮
            UIButton* btn = [[UIButton alloc] init];
            btn.frame = CGRectMake(btnX, btnY, FaceW, FaceH);
            // tga
            btn.tag = i - currentPage;
            //按钮回调；
            [btn addTarget:self
                    action:@selector(tapFaceBtnWithButton:)
          forControlEvents:UIControlEventTouchUpInside];
            NSString* strIMG = self.arrFace[i - currentPage][@"png"];
            [btn setImage:[UIImage imageNamed:strIMG] forState:UIControlStateNormal];
            [BtnView addSubview:btn];
        }
    }
    
    //创建pageController
    CGFloat pageH = 10;
    CGFloat pageW = ScreenWidth;
    CGFloat pageX = 0;
    CGFloat pageY = scViewH - pageH - marginY;
    self.pageC = [[UIPageControl alloc]
                  initWithFrame:CGRectMake(pageX, pageY, pageW, pageH)];
    self.pageC.numberOfPages = SCPages;
    self.pageC.currentPage = 0;
    self.pageC.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageC.currentPageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:self.pageC];
}

//点击表情
- (void)tapFaceBtnWithButton:(UIButton*)button {
    //将表情存储为常用表情
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* arrFaces =
    (NSMutableArray*)[defaults objectForKey:@"RecentlyFaces"];
    
    if (!arrFaces) {
        arrFaces = [NSMutableArray array];
        NSDictionary* dicFace = @{
                                  @"png" : self.arrFace[button.tag][@"png"],
                                  @"faceTag" : @(button.tag),
                                  @"chs" : self.arrFace[button.tag][@"chs"]
                                  };
        [arrFaces addObject:dicFace];
        [defaults setObject:arrFaces forKey:@"RecentlyFaces"];
        [defaults synchronize];
    }
    // NSLog(@"%p",arrFaces);
    else {
        //需要新建一个可变数组，不然修改数组会报错。
        NSMutableArray* arrM = [NSMutableArray arrayWithArray:arrFaces];
        BOOL isHaveSameFace = NO;
        for (NSDictionary* dic in arrFaces) {
            // NSLog(@"%ld--%ld",button.tag,[dic[@"faceTag"] integerValue]);
            NSString* strFace = self.arrFace[button.tag][@"chs"];
            NSString* strFaceDic = dic[@"chs"];
            if ([strFace isEqualToString:strFaceDic]) {
                [arrM removeObject:dic];
                NSLog(@"%@", dic);
                //后添加的排在前面；
                [arrM insertObject:dic atIndex:0];
                isHaveSameFace = YES;
            }
        }
        if (!isHaveSameFace) {
            NSDictionary* dicFace = @{
                                      @"png" : self.arrFace[button.tag][@"png"],
                                      @"faceTag" : @(button.tag),
                                      @"chs" : self.arrFace[button.tag][@"chs"]
                                      };
            [arrM insertObject:dicFace atIndex:0];
        }
        [defaults setObject:arrM forKey:@"RecentlyFaces"];
        [defaults synchronize];
    }
    // block传值
    self.block(self.arrFace[button.tag][@"chs"], button.tag);
}

//点击删除
- (void)tapDeleteBtn {
    self.deleteBlock();
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView*)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint*)targetContentOffset {
    self.pageC.currentPage = targetContentOffset->x / ScreenWidth;
}

#pragma mark toolBar

- (void)setToolBar {
    self.toolBar = [[UIToolbar alloc]
                    initWithFrame:CGRectMake(0, self.scFace.frame.size.height, ScreenWidth,
                                             ToolBarHeight)];
    self.toolBar.backgroundColor = GrayColor;
    
    [self addSubview:self.toolBar];
    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                  target:nil
                                  action:nil];
    UIBarButtonItem* recentlyFaceItem =
    [[UIBarButtonItem alloc] initWithTitle:@"最近表情"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(tapRecentlyFaceBtn)];
    UIBarButtonItem* normalFaceItem =
    [[UIBarButtonItem alloc] initWithTitle:@"普通"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(tapNormalFaceBtn)];
    UIBarButtonItem* bigFaceItem =
    [[UIBarButtonItem alloc] initWithTitle:@"大表情"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(tapBigFaceBtn)];
    
    [self.toolBar setItems:[NSArray arrayWithObjects:recentlyFaceItem, spaceItem,
                            normalFaceItem, spaceItem, bigFaceItem,
                            spaceItem, nil]];
}

//点击ToolBar上的按钮回调
- (void)tapRecentlyFaceBtn {
    [self fetchRecentlyFaces];
}
- (void)tapBigFaceBtn {
    [self fetchBigFaces];
}
- (void)tapNormalFaceBtn {
    [self fetchAllFaces];
}

#pragma mark block
//点击表情接口
- (void)setFaceKeyBoardBlock:(FaceKeyBoardBlock)block {
    self.block = block;
}
/*//发送接口
- (void)setFaceKeyBoardSendBlock:(FaceKeyBoardSendBlock)block {
    self.sendBlock = block;
}*/
//删除接口
- (void)setFaceKeyBoardDeleteBlock:(FaceKeyBoardDeleteBlock)block {
    self.deleteBlock = block;
}

@end