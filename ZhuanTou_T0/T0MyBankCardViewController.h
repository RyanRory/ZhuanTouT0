//
//  T0MyBankCardViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/23.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"

@interface T0MyBankCardViewController : T0BaseViewController

@property (strong, nonatomic) IBOutlet UIImageView *bankIconImageView;
@property (strong, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *cardNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *drawableNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *branchLabel;
@property (strong, nonatomic) IBOutlet UIButton *drawButton;

@end
