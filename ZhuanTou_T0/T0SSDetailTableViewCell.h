//
//  T0SSDetailTableViewCell.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/30.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T0SSDetailTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *originalStockAmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *instanceStockAmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *marketValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastDayProfitLabel;
@property (strong, nonatomic) IBOutlet UILabel *allProfitLabel;
@property (strong, nonatomic) IBOutlet UILabel *sumProfitLabel;
@property (strong, nonatomic) IBOutlet UIView *bottomLine;
@property (strong, nonatomic) IBOutlet UIView *shortLine;

@end
