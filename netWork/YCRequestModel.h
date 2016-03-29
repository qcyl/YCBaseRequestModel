//
//  YCRequestModel.h
//  netWork
//
//  Created by qi chao on 16/3/29.
//  Copyright © 2016年 qi chao. All rights reserved.
//

#import "YCBaseRequest.h"

@interface YCRequestModel : YCBaseRequest

@property (nonatomic, copy) NSString *brand;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *regTime;

@property (nonatomic, strong) NSArray *brandArray;
@property (nonatomic, copy) NSString *modelID;
@property (nonatomic, copy) NSString *seriesID;
@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic, strong) NSNumber *price;

@property (nonatomic, copy) NSString *deviceID;
@property (nonatomic, copy) NSString *phone;

@end
