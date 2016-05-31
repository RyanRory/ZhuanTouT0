//
//  T0SearchEngine.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/25.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseModel.h"

@interface T0SearchEngine : T0BaseModel

+ (NSArray*)SearchForObjectsBeginWith:(NSString*)str inArray:(NSArray*)array;

@end
