//
//  T0MessageDataModel.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/5.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0MessageDataModel.h"

@implementation T0MessageDataModel

static T0MessageDataModel *instance = nil;

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
        cellObjects = [[NSMutableArray alloc]init];
    }
    
    return self;
}

- (void)getDataFromServer
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/account/messages/%d?pageSize=20",pageIndex]];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@", responseObject);
        [cellObjects addObjectsFromArray:[responseObject objectForKey:@"messages"]];
        pageIndex++;
        
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

- (void)resetPageIndex
{
    [cellObjects removeAllObjects];
    pageIndex = 0;
}


@end
