//
//  NSObject+ValidObject.m
//  yamibo
//
//  Created by 李思良 on 15/4/16.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "NSObject+ValidObject.h"

@implementation NSObject (ValidObject)

- (NSString *)validString
{
    id result = nil;

    if (self && ![self isKindOfClass:[NSNull class]]) {
        result = [NSString stringWithFormat:@"%@", self];
    }

    return result;
}

- (NSArray *)validArray
{
    id result = nil;

    if ([self isKindOfClass:[NSArray class]]) {
        result = self;
    }

    return result;
}

- (NSDictionary *)validDictionary
{
    id result = nil;

    if ([self isKindOfClass:[NSDictionary class]]) {
        result = self;
    }

    return result;
}

- (NSURL *)validURL
{
    id result = nil;

    NSString *validString = [self validString];
    if (validString) {
        result = [NSURL URLWithString:validString];
    }

    return result;
}

@end

@implementation NSDictionary (ValidObject)

- (NSNumber *)validNumberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue
{
    if (!key) {
        return defaultValue;
    }

    id object = [self objectForKey:key];
    if (![object isKindOfClass:[NSNumber class]]) {
        return defaultValue;
    }

    return object;
}

- (NSNumber *)validNumberForKey:(NSString *)key
{
	return [self validNumberForKey:key defaultValue:nil];
}

- (NSString *)validStringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
{
    if (!key) {
        return defaultValue;
    }

    id object = [self objectForKey:key];
    if (![object isKindOfClass:[NSString class]]) {
        if ([object isKindOfClass:[NSNumber class]]) {
            return [object stringValue];
        }
        return defaultValue;
    }

    return object;
}

- (NSString *)validStringForKey:(NSString *)key;
{
    return [self validStringForKey:key defaultValue:@""];
}

- (NSArray *)validArrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
{
    if (!key) {
        return defaultValue;
    }

    id array = [self objectForKey:key];
    if (![array isKindOfClass:[NSArray class]]) {
        return defaultValue;
    }

    return array;
}

- (NSArray *)validArrayForKey:(NSString *)key;
{
    return [self validArrayForKey:key defaultValue:nil];
}

- (NSDictionary *)validDictionaryForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue
{
    if (!key) {
        return defaultValue;
    }

    id object = [self objectForKey:key];
    if (![object isKindOfClass:[NSDictionary class]]) {
        return defaultValue;
    }

    return object;
}
- (NSDictionary *)validDictionaryForKey:(NSString *)key
{
    return [self validDictionaryForKey:key defaultValue:nil];
}

- (time_t)validTimeForKey:(NSString *)key defaultValue:(time_t)defaultValue
{
    NSString *stringTime = [self validStringForKey:key];
    if ((id)stringTime == [NSNull null]) {
        stringTime = @"";
    }

    struct tm created;
    time_t now;
    time(&now);

    if (stringTime) {
        if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
            strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
        }
        return mktime(&created);
    }
    return defaultValue;
}

- (time_t)validTimeForKey:(NSString *)key
{
    time_t defaultValue = [[NSDate date] timeIntervalSince1970];
    return [self validTimeForKey:key defaultValue:defaultValue];
}

- (NSDate *)validDateForKey:(NSString *)key defaultValue:(NSDate *)defaultValue
{
    if (!key) {
        return defaultValue;
    }

    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [NSDate dateWithTimeIntervalSince1970:[object intValue]];
    } else if ([object isKindOfClass:[NSString class]] && [object length] > 0) {
        return [NSDate dateWithTimeIntervalSince1970:[self validTimeForKey:key]];
    }

    return nil;
}

- (NSDate *)validDateForKey:(NSString *)key
{
    return [self validDateForKey:key defaultValue:nil];
}

@end

@implementation NSMutableDictionary (SafeObject)

- (void)setSafeObject:(id)object forKey:(id<NSCopying>)key
{
    if (object && key) {
        [self setObject:object forKey:key];
    }
}

@end

@implementation NSMutableArray (SafeObject)

- (void)addSafeObject:(id)object
{
    if (object) {
        [self addObject:object];
    }
}

@end

@implementation NSArray (SafeBlock)

- (id)safeObjectAtIndex:(NSInteger)index
{
    if (index >= 0 && index < [self count]) {
        return [self objectAtIndex:index];
    }

    return nil;
}

@end
