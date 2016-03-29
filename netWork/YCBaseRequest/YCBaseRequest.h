//
//  YCBaseRequest.h
//  netWork
//
//  Created by qi chao on 16/3/26.
//  Copyright © 2016年 qi chao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCHttpClient.h"
#import "MJExtension.h"

/// 缓存类型
typedef NS_ENUM(NSUInteger, YCCacheType) {
    /// 文件
    YCCacheTypeOfFile,
    /// 数据库
//    YCCacheTypeOfDB,
    /// 内存
//    YCCacheTypeOfMemory,
};

/// 请求回调
typedef void(^YCCompletionCallBack)(id obj, NSError *error);

@interface YCBaseRequest : NSObject

#pragma mark - 需要在子类中重写的方法

#pragma mark 缓存相关
/// 是否需要缓存（不重写默认不缓存）
- (BOOL)isNeedCache;

/// 缓存类型（不重写默认文件缓存）
- (YCCacheType)cacheType;

/// 缓存时间(单位秒)（默认-1）
- (NSTimeInterval)cacheTimeInSeconds;

#pragma mark 请求相关
/// 请求类型(必须设置)
- (YCHttpRequestType)requestType;
/// 请求URL(必须设置)
- (NSString *)requestURL;
/// 请求参数(默认nil)
- (id)requestParameters;

#pragma mark - 公共方法
/// 强制更新缓存
- (void)startWithoutCacheCompletionCallBack:(YCCompletionCallBack)callBack;

/// 发送请求
- (void)startWithCompletionCallBack:(YCCompletionCallBack)callBack;

/// 清除全部缓存(用YCBaseRequest调用)
+ (void)cleanCache;

@end
