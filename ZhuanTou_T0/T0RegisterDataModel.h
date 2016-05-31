//
//  T0RegisterDataModel.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/20.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseModel.h"

@interface T0RegisterDataModel : T0BaseModel
{
    NSString *mobile, *smsCode, *password, *vCode;
}

+ (instancetype)shareInstance;

- (void)setMobile:(NSString*)str;
- (NSString*)getMobile;
- (void)setSmsCode:(NSString*)str;
- (NSString*)getSmsCode;
- (void)setPassword:(NSString*)str;
- (NSString*)getPassword;
- (void)setVCode:(NSString*)str;
- (NSString*)getVCode;

- (void)saveAllDataToUserDefaults;

@end
