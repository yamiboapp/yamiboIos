//
//  NSObject+Utility.h
//  yamibo
//
//  Created by 李思良 on 15/4/16.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

- (NSString *)md5sum;

@end

@interface NSString (NotNull)

- (NSString *)notNullString;

@end

@interface NSString (Localize)

- (NSString *)localize;

@end

@interface NSData (MD5)

- (NSString *)md5;

@end
