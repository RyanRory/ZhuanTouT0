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

#import "T0MyBankCardViewController.h"

@interface T0BalanceViewController : T0BaseViewController<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    T0BalanceDataModel *dataModel;
    CGRect bgImageViewOriginFrame;
}

@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;
@property (strong, nonatomic) IBOutlet UITableView *tView;
@property (strong, nonatomic) IBOutlet UIButton *toChargeButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewConstraint;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutlet T0ProgressHUDView *hud;

@end
