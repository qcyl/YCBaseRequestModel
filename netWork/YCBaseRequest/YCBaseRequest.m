//
//  YCBaseRequest.m
//  netWork
//
//  Created by qi chao on 16/3/26.
//  Copyright © 2016年 qi chao. All rights reserved.
//

#import "YCBaseRequest.h"
#import "NSString+MD5Addition.h"

@implementation YCBaseRequest

#pragma mark 缓存相关
- (BOOL)isNeedCache {
    return NO;
}
- (YCCacheType)cacheType {
    return YCCacheTypeOfFile;
}

- (NSTimeInterval)cacheTimeInSeconds {
    return -1;
}

#pragma mark 请求相关
- (YCHttpRequestType)requestType {
    return YCHttpRequestTypeGET;
}
- (NSString *)requestURL {
    return nil;
}
- (id)requestParameters {
    return nil;
}

#pragma mark - 公共方法
- (void)startWithoutCacheCompletionCallBack:(YCCompletionCallBack)callBack {
    [self startWithCallBack:callBack];
}
- (void)startWithCompletionCallBack:(YCCompletionCallBack)callBack {
    if ([self isNeedCache] && [self cacheData]) {
        if (callBack) {
            callBack([self cacheData], nil);
        }
    } else {
        [self startWithCallBack:callBack];
    }
}

#pragma mark - 私有方法
- (void)startWithCallBack:(YCCompletionCallBack)callBack {
    [[YCHttpClient shareHttpClient] requestURL:[self requestURL] requestType:[self requestType] parameters:[self requestParameters] success:^(NSURLSessionDataTask *task, id obj) {
        if (callBack){
            callBack(obj, nil);
        }
        [self saveCache:obj];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (callBack){
            callBack(nil, error);
        }
    }];
}
// 保存缓存
- (void)saveCache:(id)obj {
    if ([self isNeedCache]) {
        if (![NSKeyedArchiver archiveRootObject:obj toFile:[self cachePath]]) {
            NSLog(@"save cache is error %@ %@", NSStringFromClass([self class]), [self requestParameters]);
        }
    }
}

// 获得本地缓存
- (id)cacheData {
    id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:[self cachePath]];
    if (obj && [self cacheIsValid]) {
        return obj;
    }
    return nil;
}

// 判断缓存是否有效
- (BOOL)cacheIsValid {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *attributesRetrievalError = nil;
    NSDictionary *attributes = [fileManager attributesOfItemAtPath:[self cachePath]
                                                             error:&attributesRetrievalError];
    if (!attributes) {
        NSLog(@"Error get attributes for file at %@(%@): %@", [self cachePath], NSStringFromClass([self class]), attributesRetrievalError);
        return NO;
    }
    
    NSTimeInterval seconds = -[[attributes fileModificationDate] timeIntervalSinceNow];
    if (seconds > [self cacheTimeInSeconds]) {
        return NO;
    }
    return YES;
}

// 缓存路径
- (NSString *)cachePath {
    NSString *requestPath = [NSString stringWithFormat:@"%@%@", [self requestURL], [self requestParameters]];
    NSString *MD5 = [requestPath stringFromMD5];
    return [[self basePath] stringByAppendingPathComponent:MD5];
}
- (NSString *)basePath {
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *basePath = [cache stringByAppendingPathComponent:@"youcheCache"];
    [self checkDirectory:basePath];
    return basePath;
}

// 创建缓存根文件夹
- (void)checkDirectory:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self createBaseDirectoryAtPath:path];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
}
- (void)createBaseDirectoryAtPath:(NSString *)path {
    __autoreleasing NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                               attributes:nil error:&error];
    if (error) {
        NSLog(@"create cache directory failed, error = %@", error);
    }
}

// 清除全部缓存
+ (void)cleanCache {
    YCBaseRequest *base = [[self alloc] init];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:[base basePath]];
    NSString *fileName;
    while (fileName= [dirEnum nextObject]) {
        [[NSFileManager defaultManager] removeItemAtPath:[[base basePath] stringByAppendingPathComponent:fileName] error:nil];
    }
}


@end
