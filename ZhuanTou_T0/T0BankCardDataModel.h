//
//  T0BankCardDataModel.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/2.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseModel.h"

@interface T0BankCardDataModel : T0BaseModel
{
    NSArray *cellObjects;
    NSDictionary *data;
}

+ (instancetype)shareInstance;
- (NSArray*)getCellObjects;
- (void)getDataFromServer;
- (NSDictionary*)getData;

@end
