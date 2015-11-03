//
//  ArticleDetailTableViewCell.m
//  yamibo
//
//  Created by ShaneWay on 15/11/1.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import "ArticleDetailTableViewCell.h"

@implementation ArticleDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configureCell];
    }
    return self;
}

- (void)configureCell {
    self.backgroundColor = KCOLOR_YELLOW_FDF5D8;
}

@end
