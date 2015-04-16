//
//  NSObject+ValidObject.h
//  yamibo
//
//  Created by 李思良 on 15/4/16.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ValidObject)

- (NSString *)validString;
- (NSArray *)validArray;
- (NSDictionary *)validDictionary;
- (NSURL *)validURL;

@end

@interface NSDictionary (ValidObject)

- (NSNumber *)validNumberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue;
- (NSNumber *)validNumberForKey:(NSString *)key;

- (NSString *)validStringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSString *)validStringForKey:(NSString *)key;

- (NSArray *)validArrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSArray *)validArrayForKey:(NSString *)key;

- (NSDictionary *)validDictionaryForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;
- (NSDictionary *)validDictionaryForKey:(NSString *)key;

- (NSDate *)validDateForKey:(NSString *)key defaultValue:(NSDate *)defaultValue;
- (NSDate *)validDateForKey:(NSString *)key;

@end

@interface NSMutableDictionary (SafeObject)

- (void)setSafeObject:(id)object forKey:(id<NSCopying>)key;

@end

@interface NSMutableArray (SafeObject)

- (void)addSafeObject:(id)object;

@end

@interface NSArray (SafeObject)

- (id)safeObjectAtIndex:(NSInteger)index;

@end
