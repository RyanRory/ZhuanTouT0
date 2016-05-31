//
//  T0BaseFunction.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/18.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface T0BaseFunction : NSObject

+ (BOOL)isCurrentViewControllerVisible:(UIViewController*)viewController;
+ (NSString*)formatterNumberWithoutDecimal:(NSString*)number;
+ (NSString*)formatterNumberWithDecimal:(NSString*)number;
+ (NSString*)formatterNumberWithBrain:(NSString*)number;
+ (NSString*)md5HexDigest:(NSString*)input;
+ (NSString*)boolToString:(BOOL)flag;
+ (BOOL)isExistenceNetwork;
+ (NSString*)deleteSpacesForString:(NSString*)str;
+ (void)setColoredLabelText:(UILabel*)label Number:(NSString*)number;

@end
