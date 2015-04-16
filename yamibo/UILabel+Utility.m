//
//  UILabel+Utility.m
//  yamibo
//
//  Created by 李思良 on 15/4/15.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "UILabel+Utility.h"
#import "UIView+Utility.h"

#define MAX_LINE_NUM        3

@implementation UILabel(ContentSize)

- (CGSize)contentSize
{
    CGSize contentSize;
    if ([self.text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){

        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = self.lineBreakMode;
        paragraphStyle.alignment = self.textAlignment;
        NSDictionary * attributes = @{NSFontAttributeName : self.font,
                                      NSParagraphStyleAttributeName : paragraphStyle};
        CGSize tSize = CGSizeMake(self.width, self.font.pointSize*MAX_LINE_NUM);
        contentSize = [self.text boundingRectWithSize:tSize
                                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                           attributes:attributes
                                              context:nil].size;
    } else {
        UIFont *thefont = self.font;
        CGSize size = CGSizeMake(self.width, self.font.pointSize*MAX_LINE_NUM);
        
        contentSize = [self.text  sizeWithFont:thefont constrainedToSize:size lineBreakMode:self.lineBreakMode];
    }
    return contentSize;
}

@end
