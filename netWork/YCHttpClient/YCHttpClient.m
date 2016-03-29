//
//  YCHttpClient.m
//  netWork
//
//  Created by qi chao on 16/3/26.
//  Copyright © 2016年 qi chao. All rights reserved.
//

#import "YCHttpClient.h"
#import "AFNetworking.h"

@implementation YCHttpClient

+ (instancetype)shareHttpClient {
    static YCHttpClient *_install;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _install = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://appeval.youche.com/"]];
    });
    return _install;
}

- (void)requestURL:(NSString *)requsetURL
       requestType:(YCHttpRequestType)requestType
        parameters:(id)parameters
           success:(successBlcok)success
           failure:(failureBlock)failure
           showHUD:(BOOL)showHUD {
    
    switch (requestType) {
        case YCHttpRequestTypeGET:
        {
            [self GET:requsetURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(task, responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(task, error);
                }
            }];
        }
            break;
            
        case YCHttpRequestTypePOST:
        {
            [self POST:requsetURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(nil, error);
                }
            }];
        }
            break;
    }
    
}

@end
