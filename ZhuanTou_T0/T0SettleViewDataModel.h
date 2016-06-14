//
//  T0SettleViewDataModel.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/6.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseModel.h"

@interface T0SettleViewDataModel : T0BaseModel
{
    NSArray *cellObjects;
}

+ (instancetype)shareInstance;

- (void)getDataFromServer:(NSString*)orderNo;
- (NSArray*)getCellObjects;

@end
