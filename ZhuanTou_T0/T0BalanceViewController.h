//
//  T0BalanceViewController.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/28.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0BalanceDataModel.h"
#import "T0BalanceTableViewCell.h"

@interface T0BalanceViewController : T0BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    T0BalanceDataModel *dataModel;
}

@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;
@property (strong, nonatomic) IBOutlet UITableView *tView;
@property (strong, nonatomic) IBOutlet UIButton *toChargeButton;

@end
