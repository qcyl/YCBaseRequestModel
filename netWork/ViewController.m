//
//  ViewController.m
//  netWork
//
//  Created by qi chao on 16/3/26.
//  Copyright © 2016年 qi chao. All rights reserved.
//

#import "ViewController.h"
#import "YCRequestModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", NSHomeDirectory());
    YCRequestModel *model = [[YCRequestModel alloc] init];
    model.modelID = @"100100102100";
    model.regTime = @"2015-01-01 00:00:00";
    model.distance = @1;
    model.city = @"北京";
    
    [model startWithCompletionCallBack:^(id obj, NSError *error) {
        NSLog(@"%@", obj);
    }];
    
}

@end
