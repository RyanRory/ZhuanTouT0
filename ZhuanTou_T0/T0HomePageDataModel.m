//
//  T0HomePageDataModel.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/11.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0HomePageDataModel.h"

@implementation T0HomePageDataModel

static T0HomePageDataModel *instance = nil;

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

- (void)setData:(NSArray *)array
{
    data = [NSArray arrayWithArray:array];
}

- (NSDictionary*)getData
{
    if (data.count > 0)
    {
        return data[0];
    }
    else
    {
        return nil;
    }
}

- (void)setDetailData:(NSDictionary*)temp
{
    detailData = [NSDictionary dictionaryWithDictionary:temp];
}

- (NSDictionary*)getDetailData
{
    return detailData;
}

- (void)clearData
{
    data = nil;
}


@end
