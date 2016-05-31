//
//  T0SSProgressDataModel.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/28.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseModel.h"

@interface T0SSProgressDataModel : T0BaseModel
{
    NSArray *cellObjects;
}

+ (instancetype)shareInstance;

- (void)getDataFromServer;
- (NSArray*)getCellObjects;

@end
