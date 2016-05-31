//
//  T0RecommendSSDataModel.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0RecommendSSDataModel.h"

@implementation T0RecommendSSDataModel

static T0RecommendSSDataModel *instance = nil;

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
    NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/intraday/recommended"]];
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
