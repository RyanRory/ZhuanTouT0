//
//  UITableView+EmptyData.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/6.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView(EmptyData)

- (void) tableViewDisplayWitMsg:(NSString *)message imageName:(NSString *)name ifNecessaryForRowCount:(NSUInteger) rowCount;

@end
