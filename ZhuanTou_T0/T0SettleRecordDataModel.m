//
//  T0SettleRecordDataModel.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0SettleRecordDataModel.h"

@implementation T0SettleRecordDataModel

static T0SettleRecordDataModel *instance = nil;

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

- (void)getDataFromServer:(NSString*)orderNo
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"/api/intraday/withdraws/%@",orderNo]];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSArray *responseObject) {
        NSLog(@"%@", responseObject);
        cellObjects = [NSArray arrayWithArray:responseObject];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Refresh" object:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowError" object:nil];
    }];
}

- (void)getDetailDataFromServer:(NSString*)orderNo from:(NSString*)startDate to:(NSString*)endDate
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"/api/intraday/perfReports/%@?startDate=%@&endDate=%@",orderNo,startDate,endDate]];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@", responseObject);
        detailData = [NSDictionary dictionaryWithDictionary:responseObject];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"GoToDetail" object:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowError" object:nil];
    }];
}

- (NSDictionary*)getDetailData
{
    return detailData;
}

- (NSArray*)getCellObjects
{
    return cellObjects;
}

@end
