//
//  NSObject+Utility.m
//  yamibo
//
//  Created by 李思良 on 15/4/16.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "NSObject+Utility.h"
#import <CommonCrypto/CommonDigest.h>
#import "ChineseTransform.h"
#import "AppManager.h"
#import "DTCoreText/DTCoreText.h"

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

@implementation NSString (Convert)

- (NSString *)convert {
    if ([[AppManager sharedInstance] isTradionChinese]) {
        return [[ChineseTransform sharedInstance] traditionString:self];
    }
    return self;
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


@implementation NSString (formatLastPost)
- (NSString*)formatLastPost {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeZone* localTimeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    NSDate *sourceDate = [dateFormatter dateFromString:self];
    
    NSDate *systemDate = [NSDate date];
    NSString *currentDateStr = [dateFormatter stringFromDate:systemDate];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];

    NSCalendar *c = [NSCalendar currentCalendar];
    NSDateComponents *components = [c components:(NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:sourceDate toDate:currentDate options:0];
    
    NSString *lastPostStr;
    
    NSInteger diffYear = components.year;

    if (diffYear < 1) {
        NSInteger diffDay = components.day;
        
        if (diffDay < 1) {
            NSInteger diffHour = components.hour;
            if (diffHour < 1) {
                NSInteger diffMinute = components.minute;
                if (diffMinute < 1) {
                    lastPostStr = [NSString stringWithFormat:@"刚刚"];
                } else {
                    lastPostStr = [NSString stringWithFormat:@"%ld分钟前", (long)diffMinute];
                }
            } else {
                lastPostStr = [NSString stringWithFormat:@"%ld小时前", (long)diffHour];
            }
        } else {
            components = [c components:(NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:sourceDate];
            if (diffDay == 1) {
                lastPostStr = [NSString stringWithFormat:@"昨天 %ld:%ld", (long)components.hour, (long)components.minute];
            } else {
                lastPostStr = [NSString stringWithFormat:@"%ld-%ld", (long)components.month, (long)components.day];
            }
        }
    } else {
        components = [c components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:sourceDate];
        lastPostStr = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)components.year, (long)components.month, (long)components.day];
    }
    
    return lastPostStr;
}
@end


@implementation NSString (toLocalTime)
- (NSString*)toLocalTime {
    //源时区
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:sourceTimeZone];
    NSDate *sourceDate = [dateFormatter dateFromString:self];

    //目标时区
    NSTimeZone* localTimeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    NSString *localDate = [dateFormatter stringFromDate:sourceDate];
    return localDate;
}

@end

@implementation NSString (stringFromHTML)
- (NSString*)stringFromHTML {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithHTMLData:data
                                                                            options:@{
                                                                                      DTUseiOS6Attributes:@"1",
                                                                                      }
                                                                 documentAttributes:nil];
    NSString *plainText = [attrStr string];
    //remove \n
    if ([plainText characterAtIndex:(plainText.length - 1)] == '\n') {
        return [plainText substringWithRange:NSMakeRange(0, plainText.length - 1)];
    } else {
        return plainText;
    }
}

@end