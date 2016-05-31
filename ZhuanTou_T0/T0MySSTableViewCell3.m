//
//  T0MySSTableViewCell3.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/23.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0MySSTableViewCell3.h"

@implementation T0MySSTableViewCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    [_detailButton setUserInteractionEnabled:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (!selected)
    {
        [self.detailButton setBackgroundColor:MYSSBUTTONDARK];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted)
    {
        [self.detailButton setBackgroundColor:MYSSBUTTONBLUE];
    }
    else
    {
        [self.detailButton setBackgroundColor:MYSSBUTTONDARK];
    }
}

@end
