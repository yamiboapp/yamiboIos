//
//  MenuTableViewCell.h
//  yamibo
//
//  Created by 李思良 on 15/9/19.
//  Copyright © 2015年 lsl. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KMenuTableViewCell  @"KMenuTableViewCell"
#define KMenuTableHeadCell  @"KMenuTableHeadCell"
@interface MenuTableViewCell : UITableViewCell
- (void)loadTitle:(NSString *)title andIcon:(UIImage *)icon;
@end
