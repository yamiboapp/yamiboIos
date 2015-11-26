//
//  ProfileModel.h
//  yamibo
//
//  Created by shuang yang on 11/25/15.
//  Copyright © 2015 lsl. All rights reserved.
//

#import "JSONModel.h"

@interface ProfileModel : JSONModel

@property   (strong, nonatomic) NSString *userId;
@property   (strong, nonatomic) NSString *userName;
@property   (strong, nonatomic) NSString *credit;
@property   (strong, nonatomic) NSString *gender;
@property   (strong, nonatomic) NSString *rank;

@end
