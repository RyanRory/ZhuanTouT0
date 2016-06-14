//
//  T0LoginDataModel.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/26.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0LoginDataModel.h"

@implementation T0LoginDataModel

static T0LoginDataModel *instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init] ;
    }) ;
    
    return instance ;
}
- (void)setMobile:(NSString*)str
{
    mobile = str;
}

- (NSString*)getMobile
{
    return mobile;
}
- (void)setPassword:(NSString*)str
{
    password = str;
}

- (NSString*)getPassword
{
    return  password;
}

- (void)setVCode:(NSString*)str
{
    vCode = str;
}

- (NSString*)getVCode
{
    return vCode;
}

- (void)setSmsCode:(NSString*)str
{
    smsCode = str;
}

- (NSString*)getSmsCode
{
    return smsCode;
}

- (void)saveAllDataToUserDefaults
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:mobile forKey:MOBILE];
    [userDefault setObject:password forKey:PASSWORD];
    [userDefault synchronize];
}

@end
