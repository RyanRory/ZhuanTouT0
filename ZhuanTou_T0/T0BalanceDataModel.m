//
//  T0BalanceDataModel.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/28.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BalanceDataModel.h"

@implementation T0BalanceDataModel

static T0BalanceDataModel *instance = nil;

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
        balance = @"";
    }
    
    return self;
}

- (void)getDataFromServer
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/account/accountRecords"]];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@", responseObject);
        balance = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"fundsAvailable"]];
        cellObjects = [NSArray arrayWithArray:[responseObject objectForKey:@"accountRecords"]];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Refresh" object:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HHTPFail" object:nil];
    }];
}

- (void)setBalance:(NSString*)str
{
    balance = str;
}

- (NSString*)getBalance
{
    return balance;
}

- (NSArray*)getCellObjects
{
    return cellObjects;
}

@end
