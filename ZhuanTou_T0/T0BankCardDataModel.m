//
//  T0BankCardDataModel.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/2.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BankCardDataModel.h"

@implementation T0BankCardDataModel

static T0BankCardDataModel *instance = nil;

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
    NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/account/myAccount4M"]];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@", responseObject);
        data = [NSDictionary dictionaryWithDictionary:responseObject];
        cellObjects = [NSArray arrayWithArray:[responseObject objectForKey:@"bankCards"]];
        
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

- (NSDictionary*)getData
{
    return data;
}

@end
