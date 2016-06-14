//
//  T0SettingsTableViewCell.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/6.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0SettingsTableViewCell.h"

@implementation T0SettingsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:YES];
    if (highlighted)
    {
        self.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:48.0/255.0 blue:51.0/255.0 alpha:0.4];
    }
    else
    {
        self.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:48.0/255.0 blue:51.0/255.0 alpha:0.6];
    }
}

@end
