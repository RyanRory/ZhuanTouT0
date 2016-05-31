//
//  T0RegisterDataModel.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/20.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0RegisterDataModel.h"

@implementation T0RegisterDataModel

static T0RegisterDataModel *instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init] ;
    }) ;
    
    return instance ;
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [T0RegisterDataModel shareInstance] ;
}

- (id)init
{
    if (self = [super init])
    {
        
    }
    
    return self;
}

- (void)setMobile:(NSString*)str
{
    mobile = str;
}

- (NSString*)getMobile
{
    return mobile;
}

- (void)setSmsCode:(NSString*)str
{
    smsCode = str;
}

- (NSString*)getSmsCode
{
    return smsCode;
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

- (void)saveAllDataToUserDefaults
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:mobile forKey:MOBILE];
    [userDefault setObject:password forKey:PASSWORD];
    [userDefault synchronize];
}

@end
