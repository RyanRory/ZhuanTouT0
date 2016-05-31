//
//  T0SettleRecordDataModel.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseModel.h"

@interface T0SettleRecordDataModel : T0BaseModel
{
    NSArray *cellObjects;
    NSDictionary *detailData;
}

+ (instancetype)shareInstance;

- (void)getDataFromServer:(NSString*)orderNo;
- (NSArray*)getCellObjects;
- (void)getDetailDataFromServer:(NSString*)orderNo from:(NSString*)startDate to:(NSString*)endDate;
- (NSDictionary*)getDetailData;

@end
