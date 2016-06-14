//
//  T0StatisticsDataModel.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/8.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0StatisticsDataModel.h"

@implementation T0StatisticsDataModel

static T0StatisticsDataModel *instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init] ;
    }) ;
    
    return instance ;
}

- (instancetype)init
{
    if (self = [super init])
    {
    }
    
    return self;
}

- (void)getDataFromServer
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL = [BASEURL stringByAppendingString:@"api/account/accountStat"];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@", responseObject);
        
        data = responseObject;
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Refresh" object:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HTTPFail" object:nil];
    }];
}

- (NSDictionary*)getData
{
    return data;
}

@end
