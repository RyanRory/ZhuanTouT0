//
//  T0StockSourceTableViewCell.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/26.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T0StockSourceTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *stockCodeNNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *marketValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *preTimeLabel;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;


@end
