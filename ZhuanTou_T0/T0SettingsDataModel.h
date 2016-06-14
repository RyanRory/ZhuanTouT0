//
//  T0SettingsDataModel.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/6.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseModel.h"

@interface T0SettingsDataModel : T0BaseModel
{
    BOOL isRealNameSet;
    NSString *realName;
}

+ (instancetype)shareInstance;

- (void)setIsRealNameSet:(BOOL)flag;
- (BOOL)getIsRealNameSet;
- (void)setRealName:(NSString*)str;
- (NSString*)getRealName;

@end
