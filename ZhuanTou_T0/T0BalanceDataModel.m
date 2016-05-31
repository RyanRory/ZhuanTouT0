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
        cellObjects = [NSArray arrayWithObjects:@{@"title":@"收入佣金(元)", @"amount":@"500000", @"progress":@"处理中", @"time":@"2016-5-1 10:13"},@{@"title":@"收入佣金(元)", @"amount":@"500000", @"progress":@"处理中", @"time":@"2016-5-1 10:13"},@{@"title":@"收入佣金(元)", @"amount":@"500000", @"progress":@"处理中", @"time":@"2016-5-1 10:13"},@{@"title":@"收入佣金(元)", @"amount":@"500000", @"progress":@"处理中", @"time":@"2016-5-1 10:13"},@{@"title":@"收入佣金(元)", @"amount":@"500000", @"progress":@"处理中", @"time":@"2016-5-1 10:13"},@{@"title":@"收入佣金(元)", @"amount":@"500000", @"progress":@"处理中", @"time":@"2016-5-1 10:13"}, nil];
        balance = @"100000000";
    }
    
    return self;
}

- (void)getDataFromServer
{
    
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
