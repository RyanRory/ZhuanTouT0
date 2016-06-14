//
//  T0MessageDataModel.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/5.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseModel.h"

@interface T0MessageDataModel : T0BaseModel
{
    NSMutableArray *cellObjects;
    int pageIndex;
}

+ (instancetype)shareInstance;

- (void)getDataFromServer;
- (NSArray*)getCellObjects;
- (void)resetPageIndex;

@end
