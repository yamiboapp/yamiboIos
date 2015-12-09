//
//  YPostContentView.m
//  yamibo
//
//  Created by ShaneWay on 15/10/15.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "YPostContentView.h"

#import "AppManager.h"

#define testUrl @"http://www.yamibo.com/"

@interface YPostContentView ()<DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>
{
    NSAttributedString *_attrString;
}
@end

@implementation YPostContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.scrollEnabled = NO;
        self.textDelegate = self;
    }
    return self;
}

- (CGFloat)displayHeight {
    CGSize displaySize = [_attributedTextContentView suggestedFrameSizeToFitEntireStringConstraintedToWidth:self.frame.size.width];
    return displaySize.height;
}

- (void)setContentHtml:(NSString *)html {
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSURL URLWithString:testUrl], NSBaseURLDocumentOption, nil];
    _attrString = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:nil];
    
    self.attributedString = _attrString;
    
}


//- (void)layoutSubviews {
////    [super layoutSubviews];
//    [self.attributedTextContentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    
//    [super layoutSubviews];
//}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    _viewSize = [_attributedTextContentView suggestedFrameSizeToFitEntireStringConstraintedToWidth:self.frame.size.width];
//    
//    if ([_postContentViewDelegate respondsToSelector:@selector(postContentView:changeSize:)]) {
//        [_postContentViewDelegate postContentView:self changeSize:_viewSize];
//    }
//}


#pragma mark - DTAttributedTextContentViewDelegate

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame {
    
    if ([attachment isKindOfClass:[DTImageTextAttachment class]]) {
        
        DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
        
        if ([[AppManager sharedInstance] isNoImgMode]) {
            
        } else {
            imageView.delegate = self;
            
            // url for deferred loading
            imageView.url = attachment.contentURL;
        }
        
        return imageView;
    }
    else if ([attachment isKindOfClass:[DTObjectTextAttachment class]]) {
        
        DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
        
        if ([[AppManager sharedInstance] isNoImgMode]) {
        } else {
            imageView.delegate = self;
            imageView.url = attachment.contentURL;
        }
        
        return imageView;
    }
    
    return nil;
}

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForLink:(NSURL *)url identifier:(NSString *)identifier frame:(CGRect)frame {
    
    DTLinkButton *linkButton = [[DTLinkButton alloc] initWithFrame:frame];
    linkButton.URL = url;
    linkButton.minimumHitSize = CGSizeMake(10, 10);
    linkButton.GUID = identifier;
    [linkButton addTarget:self action:@selector(linkClick:) forControlEvents:UIControlEventTouchUpInside];

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPress:)];
    [linkButton addGestureRecognizer:longPress];
    
    return linkButton;
}

#pragma mark - DTLazyImageViewDelegate

- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
    
    CGSize imageSize;
    if (size.width > self.frame.size.width) {
        imageSize = CGSizeMake(self.frame.size.width, self.frame.size.width*size.height/size.width);
    } else {
        imageSize = size;
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", lazyImageView.url];
    
    BOOL didUpdate = NO;
    
    for (DTTextAttachment *oneAttachment in [_attributedTextContentView.layoutFrame textAttachmentsWithPredicate:pred]) {
        if (CGSizeEqualToSize(oneAttachment.originalSize, CGSizeZero)) {
            oneAttachment.originalSize = imageSize;
            didUpdate = YES;
        }
    }
    
    if (didUpdate) {
        [self relayoutText];
    }
}


#pragma mark - Actions

- (void)linkClick:(DTLinkButton *)button {
    NSURL *URL = button.URL;
    if ([[UIApplication sharedApplication] canOpenURL:[URL absoluteURL]]) {
        [[UIApplication sharedApplication] openURL:[URL absoluteURL]];
    } else {
        if (![URL host] && ![URL path]) {
            NSString *fragment = [URL fragment];
            if (fragment) {
                [self scrollToAnchorNamed:fragment animated:NO];
            }
        }
    }
}

- (void)linkLongPress:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Link - Long Press");
    }
}




@end
