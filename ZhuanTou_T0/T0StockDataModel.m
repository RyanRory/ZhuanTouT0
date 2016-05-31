//
//  T0StockDataModel.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/25.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0StockDataModel.h"

@implementation T0StockDataModel

static T0StockDataModel *instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init] ;
    }) ;
    
    return instance ;
}

- (void)setStocksArray:(NSArray*)array
{
    stocksArray = [NSMutableArray arrayWithArray:array];
}

- (NSArray*)getStocksArray
{
    return [NSArray arrayWithArray:stocksArray];
}

- (void)setStockSourceArray:(NSArray*)array
{
    stockSourceArray = [NSMutableArray arrayWithArray:array];
}

- (NSArray*)getStockSourceArray
{
    return stockSourceArray;
}

- (void)deleteStockSourceAtIndex:(int)index
{
    if (index < stockSourceArray.count)
    {
        [stockSourceArray removeObjectAtIndex:index];
    }
}

- (void)clearData
{
    [stockSourceArray removeAllObjects];
}

@end
