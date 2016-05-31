//
//  T0StockSourceButtonTableViewCell.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/26.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0StockSourceButtonTableViewCell.h"

@implementation T0StockSourceButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.button.layer setBorderWidth:1];
    [self.button.layer setBorderColor:[UIColor whiteColor].CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
