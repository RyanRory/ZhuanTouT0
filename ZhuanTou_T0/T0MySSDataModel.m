//
//  T0MySSDataModel.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/28.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0MySSDataModel.h"

@implementation T0MySSDataModel

static T0MySSDataModel *instance = nil;

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
    NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/intraday/mine"]];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSArray *responseObject) {
        NSLog(@"%@", responseObject);
        cellObjects = [NSArray arrayWithArray:responseObject];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Refresh" object:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowError" object:nil];
    }];
}

- (NSArray*)getCellObjects
{
    return cellObjects;
}

@end
