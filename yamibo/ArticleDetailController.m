//
//  ArticleDetailController.m
//  yamibo
//
//  Created by ShaneWay on 15/10/15.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "ArticleDetailController.h"

#import "AFNetworking.h"
#import "YPostContentView.h"

@interface ArticleDetailController ()<YPostContentViewDelegate>
{
    YPostContentView *_contentView;
    NSString *_message1;
}
@end

@implementation ArticleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configNavigation];
    [self loadThreadDetail];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Layout
- (void)configNavigation {
    [self showCustomNavigationBackButton];
}

- (void)loadThreadDetail {
//    NSDictionary *paraDict = @{@"module": @"viewthread",
//                               @"tid": @229825,
//                               @"page": @1,
//                               @"ppp": @10,
//                               @"authorid": @163436};
//    [[AFHTTPRequestOperationManager manager] POST:@"http://ceshi.yamibo.com/chobits/index.php?" parameters:paraDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        NSLog(@"error = %@", error);
//    }];
    
    // 解析[attach]xxx[/attach] 查找attachlist 找到替换
    _message1 = @"<i class=\"pstatus\"> 本帖最后由 彼世此世 于 2015-8-5 20:45 编辑 </i><br />\n<br />\nHappyYellowRabbit 陽、河合朗、雪子三人組的原創同人百合本<br />\r\n這次是關於食物的本子www<br />\r\n<br />\r\n<a href=\"http://www.toranoana.jp/mailorder/article/04/0030/30/42/040030304210.html\" target=\"_blank\"><font color=\"Red\">&gt;&gt;买买买&lt;&lt;</font></a><br />\r\n<br />\r\n<a href=\"http://www.yamibo.com/misc.php?mod=tag&amp;id=14250\" target=\"_blank\"><font color=\"RoyalBlue\">&gt;&gt;食百合相關內容&lt;&lt;</font></a><br />\r\n<br />\r\n内容是三位老师的短篇外加一个短文和一个短篇<br />\r\n先做了第一篇，中间的彩图和剩下的内容之后会慢慢放上来的，接下来请食用吧<img src=\"static/image/smiley/gexing/019.gif\" smilieid=\"344\" border=\"0\" alt=\"\" /><br />\r\n<br />\r\n改圖僅供試看，請勿用於其他用途，喜歡作者的作品，請購買正版！<br />\r\n-------------------------------------------轉載請保留以下文字資訊-------------------------------------------<br />\r\n圖源：biiiiiii<br />\r\n翻譯：Nexuse<br />\r\n校對：好の貓<br />\r\n修圖：atj<br />\r\n改圖：彼世此世<br />\r\n製作：百合會<br />\r\n<a href=\"http://www.yamibo.com/www.yamibo.com\" target=\"_blank\">www.yamibo.com</a><br />\r\n-------------------------------------------------------------------------------------------------------------<br />\r\n[attach]523181[/attach]<br />\r\n<br />\r\n[attach]523182[/attach]<br />\r\n<br />\r\n[attach]523191[/attach]<br />\r\n<br />\r\n[attach]523183[/attach]<br />\r\n<br />\r\n[attach]523184[/attach]<br />\r\n<br />\r\n[attach]523185[/attach]<br />\r\n<br />\r\n[attach]523186[/attach]<br />\r\n<br />\r\n[attach]523187[/attach]<br />\r\n<br />\r\n[attach]523188[/attach]<br />\r\n<br />\r\n[attach]523189[/attach]<br />\r\n<br />\r\n[attach]523190[/attach]<br />\r\n<br />\r\n[attach]523174[/attach]<br />\r\n<br />\r\n[attach]523175[/attach]<br />\r\n<br />\r\n[attach]523176[/attach]<br />\r\n<br />\r\n[attach]523177[/attach]<br />\r\n<br />\r\n[attach]523178[/attach]<br />\r\n<br />\r\n[attach]523179[/attach]<br />\r\n<br />\r\n[attach]523180[/attach]<br />\r\n-------------------------------------------------------------------------------------------------------------<br />\r\n个人还是蛮喜欢这作者的画风的，可惜目前还没百合连载<img src=\"static/image/smiley/gexing/025.gif\" smilieid=\"351\" border=\"0\" alt=\"\" /><br />\r\n<br />\r\n<h1>My Custom Objects</h1><br /><object src=\"data/attachment/forum/201507/31/134629jc6ctpvn6t311c8n.jpg\"></object>";
    
    NSString *message2 = @"<h1>Image Handling</h1>\n<p>Some basic <b>image</b> handling has been implemented</p>\n<h2>Inline</h2>\n<p>So far <img src=\"icon_smile.gif\"> images work inline, sitting on the line's baseline. There is a workaround in place that if an image is more than twice as high as the surrounding text it will be treated as it's own block.</p>\n<h2>Block</h2>\n<p>There is a known issue with images as blocks, outside of p tags.</p>\n<img class=\"Bla\" style=\"width:150px; height:150px\" src=\"Oliver.jpg\">\n<p>An Image outside of P is treated as a paragraph</p>\n<p><img style=\"float:right;\" width=\"100\" height=\"100\" src=\"Oliver.jpg\">The previous image has float style. As a <span style=\"background-color:yellow;\">Workaround</span> a newline is added after it until we can support floating in the layouting. This is done if the inline image is more than 5 times as large as the current font pixel size. This should allow small inline images, like smileys to stay in line, while most float images would probably be larger than this.</p>\n<h2>Supported Attributes</h2>\n<ul>\n<li><b>width</b>, <b>height</b> in pixels</li>\n<li><b>src</b> with a local file path relative to the app bundle</li>\n</ul>\n<h2>Supported Image Formats</h2>\n<p>According to <a href=\"http://developer.apple.com/library/ios/#documentation/2DDrawing/Conceptual/DrawingPrintingiOS/Images/Images.html\">Apple</a> the following image formats are supported for use with UIImage:</p>\n<ul>\n<li>png</li>\n<li>tif, tiff</li>\n<li>jpeg, jpg</li>\n<li>gif</li>\n<li>bmp, bmpf</li>\n<li>ico</li>\n<li>cur</li>\n<li>xbm</li>\n</ul>\n<h2>Vertical Alignment</h2>\n<p>Limited support for the CSS vertical-align tag exists</p>\n<p style=\"font-size:20px\">Baseline: <img style=\"vertical-align:baseline;\" height=40 width=40 src=\"icon_smile.gif\"></p>\n<p style=\"font-size:20px\">text-top: <img style=\"vertical-align:text-top;\" height=40 width=40 src=\"icon_smile.gif\"></p>\n<p style=\"font-size:20px\">text-bottom: <img style=\"vertical-align:text-bottom;\" height=40 width=40 src=\"icon_smile.gif\"></p>\n<p style=\"font-size:20px\">middle: <img style=\"vertical-align:middle;\" height=40 width=40 src=\"icon_smile.gif\"></p>\n<h2>Data Source</h2>\n<p>Base64 encoded data SRC is supported, for example this red dot: <img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==\" alt=\"Red dot\" /></p>\n<p>Another example:</p><img src=\"data:image/gif;base64,R0lGODlhDwAPAKECAAAAzMzM/////wAAACwAAAAADwAPAAACIISPeQHsrZ5ModrLlN48CXF8m2iQ3YmmKqVlRtW4MLwWACH+H09wdGltaXplZCBieSBVbGVhZCBTbWFydFNhdmVyIQAAOw==\"alt=\"Base64 encoded image\" width=\"100\" height=\"100\"/>\n\n<h2>Remote Images</h2>\n<p>Images can also be loaded from remote URLs, even without specifying a size in the HTML. The code demonstrates how to update the DTTextAttachment's display size after download and triggering a re-layout.</p>\n<img src=\"https://si0.twimg.com/profile_images/1401231905/Cocoanetics_Square_reasonably_small.jpg\">";
    
    NSString *message3 = @"<br />\r\n<h2>Custom Objects</h2>\n<p>This demonstrates usage of the &lt;object&gt; tag for embedding your own views</p>\n<p><object style=\"display:inline;margin-bottom:1em;\" someColorParameter=\"red\" width=100 height=20></object>\nor <object style=\"display:inline;margin-bottom:1em;\" someColorParameter=\"green\" width=100 height=20></object></p>\n<p>These views are writting in HTML like this:</p>\n<pre>&lt;object style=\"display:inline;margin-bottom:1em;\" someColorParameter=\"red\" width=100 height=20&gt;&lt;/object&gt;</pre>\n<p>You provide your own custom view in the <b>-attributedTextContentView:viewForAttachment:frame:</b> method.</p>\n<pre>if (attachment isKindOfClass:[DTTextAttachmentObject class])\n{\n// somecolorparameter has a HTML color\nUIColor *someColor = [UIColor colorWithHTMLName:[attachment.attributes objectForKey:@\"somecolorparameter\"]];\n\nUIView *someView = [[UIView alloc] initWithFrame:frame];\nsomeView.backgroundColor = someColor;\nsomeView.layer.borderWidth = 1;\nsomeView.layer.borderColor = [UIColor blackColor].CGColor;\n\nreturn someView;\n}</pre>\n\n<p>Object tags can access their childNodes</p>\n<pre>\n&lt;object height=100 width=100&gt;\n&lt;special stuff=\"bla\" /&gt;\n&lt;/object&gt;\n</pre>\n\n<object height=100 width=100>\n<special stuff=\"bla\" />\n</object>\n\n<p>When creating the custom view for this object you access the text attachment childNodes to get special information you have put there in addition to the attributes</p>";
    
    _contentView = [[YPostContentView alloc] init];
    _contentView.postContentViewDelegate = self;
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(10);
        make.trailing.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(-10);
//        make.height.mas_equalTo(_contentView.attributedTextContentView.frame.size.height);
    }];
    [_contentView setContentHtml:_message1];
    CGFloat height = _contentView.displayHeight;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}


//- (void)postContentView:(YPostContentView *)postContentView changeSize:(CGSize)size {
//    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(size.height);
//    }];
//}

@end
