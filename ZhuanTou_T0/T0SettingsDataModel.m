//
//  T0SettingsDataModel.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/6.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0SettingsDataModel.h"

@implementation T0SettingsDataModel

static T0SettingsDataModel *instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init] ;
    }) ;
    
    return instance ;
}

- (id)init
{
    if (self = [super init])
    {
        realName = @"";
        isRealNameSet = false;
    }
    
    return self;
}

- (void)setIsRealNameSet:(BOOL)flag
{
    isRealNameSet = flag;
}

- (BOOL)getIsRealNameSet
{
    return isRealNameSet;
}

- (void)setRealName:(NSString*)str
{
    realName = str;
}

- (NSString*)getRealName
{
    return realName;
}

- (void)setMobile:(NSString*)str
{
    mobile = [str stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}

- (NSString*)getMobile
{
    return  mobile;
}

@end
