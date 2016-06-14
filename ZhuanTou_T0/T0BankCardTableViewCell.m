//
//  T0BankCardTableViewCell.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/2.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BankCardTableViewCell.h"

@implementation T0BankCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.chooseView.layer setCornerRadius:10];
    [self.chooseView.layer setBorderWidth:1];
    [self.chooseView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.chooseView setBackgroundColor:[UIColor clearColor]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted)
    {
        self.bankCardView.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    }
    else
    {
        self.bankCardView.backgroundColor = [UIColor whiteColor];
    }
}

@end
