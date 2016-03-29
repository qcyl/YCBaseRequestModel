//
//  YCHttpClient.h
//  netWork
//
//  Created by qi chao on 16/3/26.
//  Copyright © 2016年 qi chao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPSessionManager.h"

/// 请求类型
typedef NS_ENUM(NSUInteger, YCHttpRequestType) {
    YCHttpRequestTypeGET,
    YCHttpRequestTypePOST,
};

typedef void(^successBlcok)(NSURLSessionDataTask *task, id obj);
typedef void(^failureBlock)(NSURLSessionDataTask *task, NSError *error);

@interface YCHttpClient : AFHTTPSessionManager

+ (instancetype)shareHttpClient;

- (void)requestURL:(NSString *)requsetURL
       requestType:(YCHttpRequestType)requestType
        parameters:(id)parameters
           success:(successBlcok)seccess
           failure:(failureBlock)failure
           showHUD:(BOOL)showHUD;

@end
