//
//  T0RecommendSSDataModel.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseModel.h"

@interface T0RecommendSSDataModel : T0BaseModel
{
    NSArray *cellObjects;
}

+ (instancetype)shareInstance;

- (void)getDataFromServer;
- (NSArray*)getCellObjects;

@end
