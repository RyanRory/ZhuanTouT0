//
//  T0LoginDataModel.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/26.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseModel.h"

@interface T0LoginDataModel : T0BaseModel
{
    NSString *mobile, *password, *vCode, *smsCode;
}

+ (instancetype)shareInstance;

- (void)setMobile:(NSString*)str;
- (NSString*)getMobile;
- (void)setPassword:(NSString*)str;
- (NSString*)getPassword;
- (void)setVCode:(NSString*)str;
- (NSString*)getVCode;
- (void)setSmsCode:(NSString*)str;
- (NSString*)getSmsCode;

- (void)saveAllDataToUserDefaults;

@end
