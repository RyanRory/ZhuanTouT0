//
//  T0SSProgressDataModel.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/28.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0SSProgressDataModel.h"

@implementation T0SSProgressDataModel

static T0SSProgressDataModel *instance = nil;

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
        cellObjects = [NSArray arrayWithObjects:@{@"title":@"需求采集", @"desc":@"具体要求", @"status":@"已完成", @"time":@"2016-4-25 15:30"},@{@"title":@"产品和风险要素协调阶段", @"desc":@"具体要求", @"status":@"已完成", @"time":@"2016-4-25 15:30"},@{@"title":@"项目过会", @"desc":@"具体要求", @"status":@"已完成", @"time":@"2016-4-25 15:30"},@{@"title":@"合同法律审核", @"desc":@"具体要求", @"status":@"已完成", @"time":@"2016-4-25 15:30"},@{@"title":@"资金募集", @"desc":@"具体要求", @"status":@"已完成", @"time":@"2016-4-25 15:30"},@{@"title":@"产品备案", @"desc":@"具体要求", @"status":@"进行中", @"time":@"2016-4-25 15:30"},@{@"title":@"开立账户", @"desc":@"具体要求", @"status":@"未开始", @"time":@"2016-4-25 15:30"}, nil];
    }
    
    return self;
}

- (void)getDataFromServer
{
    
}

- (NSArray*)getCellObjects
{
    return cellObjects;
}

@end
