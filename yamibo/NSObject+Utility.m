//
//  NSObject+Utility.m
//  yamibo
//
//  Created by 李思良 on 15/4/16.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "NSObject+Utility.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

- (NSString*)md5sum
{
    const char* cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (unsigned int)strlen(cstr), result);

    NSString* md5 = [NSString stringWithFormat:
                                  @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                              result[0], result[1], result[2], result[3],
                              result[4], result[5], result[6], result[7],
                              result[8], result[9], result[10], result[11],
                              result[12], result[13], result[14], result[15]];
    return [md5 lowercaseString];
}

@end

@implementation NSString (Localize)

- (NSString*)localize
{
    return NSLocalizedString(self, @"");
}

@end

@implementation NSData (MD5)

- (NSString*)md5
{
    unsigned char result[16];
    CC_MD5(self.bytes, (unsigned int)self.length, result); // This is the md5 call
    return [NSString stringWithFormat:
                         @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                     result[0], result[1], result[2], result[3],
                     result[4], result[5], result[6], result[7],
                     result[8], result[9], result[10], result[11],
                     result[12], result[13], result[14], result[15]];
}

@end