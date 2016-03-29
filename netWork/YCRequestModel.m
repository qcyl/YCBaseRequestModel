//
//  YCRequestModel.m
//  netWork
//
//  Created by qi chao on 16/3/29.
//  Copyright © 2016年 qi chao. All rights reserved.
//

#import "YCRequestModel.h"

@implementation YCRequestModel

- (BOOL)isNeedCache {
    return YES;
}
- (NSTimeInterval)cacheTimeInSeconds {
    return 3 * 3600;
}
- (YCHttpRequestType)requestType {
    return YCHttpRequestTypeGET;
}
- (NSString *)requestURL {
    return @"m/valuate/eval_with_extra_app";
}
- (id)requestParameters {
    return [self mj_keyValues];
}

@end
