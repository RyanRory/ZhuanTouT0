//
//  T0BankCardTableViewCell.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/2.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T0BankCardTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *bankCardView;
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *cardNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *branchNameLabel;
@property (strong, nonatomic) IBOutlet UIView *chooseView;

@end
