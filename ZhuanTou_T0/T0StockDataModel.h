//
//  T0StockDataModel.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/25.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseModel.h"

@interface T0StockDataModel : T0BaseModel
{
    NSMutableArray *stocksArray, *stockSourceArray;
}

+ (instancetype)shareInstance;

- (void)setStocksArray:(NSArray*)array;
- (NSArray*)getStocksArray;
- (void)setStockSourceArray:(NSArray*)array;
- (NSArray*)getStockSourceArray;
- (void)deleteStockSourceAtIndex:(int)index;
- (void)clearData;

@end
