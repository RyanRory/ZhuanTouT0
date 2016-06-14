//
//  T0StatisticsDataModel.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/8.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseModel.h"

@interface T0StatisticsDataModel : T0BaseModel
{
    NSDictionary *data;
}

+ (instancetype)shareInstance;

- (void)getDataFromServer;
- (NSDictionary*)getData;

@end
