//
//  T0HomePageDataModel.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/11.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseModel.h"

@interface T0HomePageDataModel : T0BaseModel
{
    NSArray *data;
    NSDictionary *detailData;
}

+ (instancetype)shareInstance;

- (void)setData:(NSArray *)array;
- (NSDictionary*)getData;

- (void)setDetailData:(NSDictionary*)temp;
- (NSDictionary*)getDetailData;

- (void)clearData;

@end
