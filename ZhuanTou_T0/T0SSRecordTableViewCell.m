//
//  T0SSRecordTableViewCell.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0SSRecordTableViewCell.h"

@implementation T0SSRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.bgView.layer setBorderWidth:1.0f];
    [self.bgView.layer setBorderColor:MYSSBORDERGRAY.CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
