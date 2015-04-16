//
//  FilePathUtility.h
//  yamibo
//
//  Created by 李思良 on 15/4/16.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilePathUtility : NSObject

+ (NSString *)cachesDirectory;

+ (NSString *)dataFilePath:(NSString *)fileName;

+ (NSString *)dataFilePathForCache:(NSString *)fileName;

+ (NSString *)dataFilePathForTmp:(NSString *)fileName;
+ (NSString *)relativePathOfPath:(NSString *)path;

+ (UInt64)fileSizeAtPath:(NSString *)filePath;

@end
