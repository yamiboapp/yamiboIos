//
//  FilePathUtility.m
//  yamibo
//
//  Created by 李思良 on 15/4/16.
//  Copyright (c) 2015年 lsl. All rights reserved.
//

#import "FilePathUtility.h"
#include "sys/stat.h"

@implementation FilePathUtility

+ (NSString *)tmpDirectory
{
    static NSString *tmpDirectory;

    if (!tmpDirectory) {
        tmpDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    }
    return tmpDirectory;
}

+ (NSString *)cachesDirectory
{
    static NSString *cachesDirectory;

    if (!cachesDirectory) {
        cachesDirectory = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"Caches"];
    }
    return cachesDirectory;
}


+ (NSString *)documentDirectory
{

    static NSString *documentDirectory;

    if (!documentDirectory) {
        documentDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    }

    return documentDirectory;
}


+ (NSString *)dataFilePath:(NSString *)fileName
{

    if (fileName.length == 0) {
        return [self documentDirectory];
    }
    return [[self documentDirectory] stringByAppendingPathComponent:fileName];
}


+ (NSString *)dataFilePathForCache:(NSString *)fileName
{
    if (fileName.length == 0) {
        return [self cachesDirectory];
    }
    return [[self cachesDirectory] stringByAppendingPathComponent:fileName];
}


+ (NSString *)dataFilePathForTmp:(NSString *)fileName
{
    if (fileName.length == 0) {
        return [self tmpDirectory];
    }
    return [[self tmpDirectory] stringByAppendingPathComponent:fileName];
}

+ (NSString *)relativePathOfPath:(NSString *)path
{
    NSString *appRootPath = NSHomeDirectory();
    if ([path hasPrefix:appRootPath]) {
        return [path substringFromIndex:appRootPath.length];
    }

    return path;
}
+ (UInt64)fileSizeAtPath:(NSString *)filePath
{
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    return 0;
}
+ (float)folderSizeAtPath:(NSString*)folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    UInt64 folderSize = 0;
    if ([manager fileExistsAtPath:folderPath]) {
        NSArray *childFiles = [manager subpathsAtPath:folderPath];
        for (NSString *fileName in childFiles) {
            NSLog(@"%@",fileName);
            NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
            NSLog(@"%llu",[FilePathUtility fileSizeAtPath:fileAbsolutePath]);
            folderSize += [FilePathUtility fileSizeAtPath:fileAbsolutePath];
        }
    };
    NSLog(@"folderSize ==== %lld",folderSize);
    return folderSize/(1024.0*1024.0);
}
+ (void)clearCacheAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}
@end
