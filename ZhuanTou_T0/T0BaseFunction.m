//
//  T0BaseFunction.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/18.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseFunction.h"

@implementation T0BaseFunction

+ (BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
}

+ (NSString*)formatterNumberWithoutDecimal:(NSString*)number
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setPositiveFormat:@"###,##0"];
    return [formatter stringFromNumber:[NSNumber numberWithDouble:number.doubleValue]];
}

+ (NSString*)formatterNumberWithDecimal:(NSString*)number
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setPositiveFormat:@"###,##0.00"];
    return [formatter stringFromNumber:[NSNumber numberWithDouble:number.doubleValue]];
}

+ (NSString*)formatterNumberWithBrain:(NSString*)number
{
    if ([number rangeOfString:@"."].location == NSNotFound)
    {
        return [self formatterNumberWithoutDecimal:number];
    }
    else
    {
        return [self formatterNumberWithDecimal:number];
    }
}

+ (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

+ (NSString*)boolToString:(BOOL)flag
{
    if (flag)
    {
        return @"true";
    }
    else
    {
        return @"false";
    }
}

+ (BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork;
    Reachability *reachability = [Reachability reachabilityWithHostName:BASEURL];  // 测试服务器状态
    
    switch([reachability currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = FALSE;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = TRUE;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = TRUE;
            break;
    }
    return  isExistenceNetwork;
}

+ (NSString*)deleteSpacesForString:(NSString*)str
{
    NSString *temp = str;
    while ([temp rangeOfString:@" "].location != NSNotFound)
    {
        temp = [temp stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return temp;
}

+ (void)setColoredLabelText:(UILabel*)label Number:(NSString*)number
{
    if (number.doubleValue > 0)
    {
        label.textColor = MYSSRED;
        label.text = [NSString stringWithFormat:@"+%@",[self formatterNumberWithBrain:number]];
    }
    else if (number.doubleValue < 0)
    {
        label.textColor = MYSSGREEN;
        label.text = [self formatterNumberWithBrain:number];
    }
    else
    {
        label.textColor = [UIColor whiteColor];
        label.text = @"0";
    }
}

+ (NSString*)addSpacesForString:(NSString*)str
{
    NSMutableString *tempStr = [NSMutableString stringWithString:str];
    for (long i = str.length-1; i > 0; i--)
    {
        [tempStr insertString:@" " atIndex:i];
    }
    return tempStr;
}

+ (BOOL)isChinese:(NSString *)str
{
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

+ (NSString*)formatterBankCardNum:(NSString *)str
{
    NSMutableString *tempStr = [NSMutableString stringWithString:str];
    for (long i = str.length-str.length%4; i>0; i-=4)
    {
        [tempStr insertString:@" " atIndex:i];
    }
    return tempStr;
}

@end
