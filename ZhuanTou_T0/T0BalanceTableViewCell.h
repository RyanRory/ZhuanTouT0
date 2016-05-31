//
//  T0BalanceTableViewCell.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/28.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T0BalanceTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *progressLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountLabel;

@end
