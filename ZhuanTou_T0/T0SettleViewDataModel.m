//
//  T0SettleViewDataModel.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/6.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0SettleViewDataModel.h"

@implementation T0SettleViewDataModel

static T0SettleViewDataModel *instance = nil;

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
    NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"/api/intraday/withdrawDetail/%@",orderNo]];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@", responseObject);
        cellObjects = [NSArray arrayWithObjects:
                       [NSString stringWithFormat:@"当期总T0收益为%@元，约定分成比例为%@，因此您将获得%@元。", [T0BaseFunction formatterNumberWithDecimal:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"totalExtraProfit"]]], [responseObject objectForKey:@"shareRatio"], [T0BaseFunction formatterNumberWithDecimal:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"earningAmount"]]]],
                       [NSString stringWithFormat: @"请于%@前将%@元银证转账至您的银行卡账户，并将其中的%@元转至本公司指定账户。", [responseObject objectForKey:@"confirmDate"], [T0BaseFunction formatterNumberWithDecimal:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"totalExtraProfit"]]],[T0BaseFunction formatterNumberWithDecimal:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"withdrawableAmount"]]]],
                       [NSString stringWithFormat:@"公司账户信息如下\n账户名：%@\n账户号：%@\n开户支行：%@", [responseObject objectForKey:@"accountName"], [responseObject objectForKey:@"accountNumber"], [responseObject objectForKey:@"bankName"]],
                       @"当您完成转账后，请点击页面下方“我已完成转账”按钮，递交处理申请。", nil];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Refresh" object:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HTTPFail" object:nil];
    }];
}

- (NSArray*)getCellObjects
{
    return cellObjects;
}
@end
