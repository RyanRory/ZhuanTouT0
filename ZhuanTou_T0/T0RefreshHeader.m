//
//  T0RefreshHeader.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/3.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0RefreshHeader.h"

@implementation T0RefreshHeader

- (void)prepare
{
    [super prepare];
    self.stateLabel.textColor = [UIColor whiteColor];
    self.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    [self setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
}

@end
