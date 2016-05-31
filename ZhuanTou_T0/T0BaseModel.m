//
//  T0BaseModel.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/23.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseModel.h"

@implementation T0BaseModel

+ (void)saveToPlist:(NSString*)fileName data:(id)data
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    NSString *filename=[plistPath stringByAppendingPathComponent:fileName];
    [data writeToFile:filename atomically:YES];
}

+ (id)readFromPlist:(NSString*)fileName
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    NSString *filename=[plistPath stringByAppendingPathComponent:fileName];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:filename];
    return data;
}

+ (void)saveToUserDefaults:(id)object key:(NSString*)str
{
    NSUserDefaults *userDefault =[NSUserDefaults standardUserDefaults];
    [userDefault setObject:object forKey:str];
    [userDefault synchronize];
}

+ (id)readFromUserDefaultsForKey:(NSString*)str
{
    NSUserDefaults *userDefault =[NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:str];
}

@end
