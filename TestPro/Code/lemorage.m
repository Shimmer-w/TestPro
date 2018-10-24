//
//  Lemorage.m
//  lemorage
//
//  Created by 王炜光 on 2018/10/22.
//  Copyright © 2018 lemix. All rights reserved.
//

#import "lemorage.h"

@implementation lemorage
static NSString *_workspacePath;
static NSString *_tempPath;
+ (void)startUpForWorkspacePath:(NSString *)workspachePath tempPath:(NSString *)tempPath{
    _workspacePath =workspachePath;
    _tempPath = tempPath;
    [self expiredAllShortTermUrl];
    [self expiredAllLongTermUrl];
}

+ (NSString *)generateLemageUrl: (NSData *)data
                       longTerm: (BOOL)longTerm{
    NSString *fileName;
    if(longTerm){
        fileName = _workspacePath;
    }else{
        fileName = _tempPath;
    }
    NSString *key = [self randomStringWithLength:16];
    NSString *filePath = [NSString  stringWithFormat:@"%@/%@.data",fileName,key];
    if([self creatFileWithPath:filePath]){
        //写入内容
        [data writeToFile:filePath atomically:YES];
        return [NSString stringWithFormat:@"lemorage://%@/%@",longTerm?@"long":@"short",key];
    }
    return nil;
}

+ (void)loadDataByLemorageURL: (NSString *)lemorageURL complete:(void(^)(NSData *imageData))complete{
    NSString *filePath;
    if ([lemorageURL containsString:@"long/"]) {
        filePath = [NSString stringWithFormat:@"%@/%@.data",_workspacePath,[[lemorageURL componentsSeparatedByString:@"/"] lastObject]];
    }else{
        filePath = [NSString stringWithFormat:@"%@/%@.data",_tempPath,[[lemorageURL componentsSeparatedByString:@"/"] lastObject]];
    }
    if (complete) {
        complete([NSData dataWithContentsOfFile:filePath]);
    }
}

/**
 根据传入的长度随机生成等长度的UUID字符串
 
 @param len 字符串长度
 @return 返回的字符串
 */
+(NSString *)randomStringWithLength:(NSInteger)len {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

+(BOOL)creatFileWithPath:(NSString *)filePath{
    if ([[filePath substringFromIndex:filePath.length-1] isEqualToString:@"/"]) {
        filePath = [NSString stringWithFormat:@"%@place",filePath];
    }
    BOOL isSuccess = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL temp = [fileManager fileExistsAtPath:filePath];
    if (temp) {
        return YES;
    }
    NSError *error;
    //stringByDeletingLastPathComponent:删除最后一个路径节点
    NSString *dirPath = [filePath stringByDeletingLastPathComponent];
    isSuccess = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        NSLog(@"creat File Failed. errorInfo:%@",error);
    }
    if (!isSuccess) {
        return isSuccess;
    }
    isSuccess = [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    return isSuccess;
}


/**
 让所有长期的LemorageURL失效
 原理：删除所有本地长期LemorageURL对应的沙盒图片文件
 */
+ (void)expiredAllLongTermUrl {
    NSString *filePath = _workspacePath;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
}

/**
 让所有短期的LemorageURL失效
 原理：删除所有本地短期LemorageURL对应的沙盒图片文件
 */
+ (void)expiredAllShortTermUrl {
    NSString *filePath = _tempPath;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
}

+ (void)deleteDataWithTermUrl:(NSString *)lemorageURL{
    NSString *filePath;
    if ([lemorageURL containsString:@"long/"]) {
        filePath = [NSString stringWithFormat:@"%@/%@.data",_workspacePath,[[lemorageURL componentsSeparatedByString:@"/"] lastObject]];
    }else{
        filePath = [NSString stringWithFormat:@"%@/%@.data",_tempPath,[[lemorageURL componentsSeparatedByString:@"/"] lastObject]];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
}

@end
