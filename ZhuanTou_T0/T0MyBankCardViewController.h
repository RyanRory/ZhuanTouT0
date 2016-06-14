//
//  T0MyBankCardViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/23.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0BankCardDataModel.h"
#import "T0BankCardTableViewCell.h"
#import "T0SettingsDataModel.h"

#import "T0AddBankCardViewController.h"
#import "T0DrawViewController.h"
#import "T0RealNameViewController.h"

@interface T0MyBankCardViewController : T0BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *cellObjects;
    T0BankCardDataModel *dataModel;
    BOOL editing;
    NSMutableArray *deleteIndex, *deleteIds, *deleteBankCards;
    T0SettingsDataModel *settingsDataModel;
}

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITableView *tView;
@property (strong, nonatomic) IBOutlet UIButton *functionButton;
@property (strong, nonatomic) IBOutlet UILabel *drawContentLabel;
@property (strong, nonatomic) IBOutlet T0ProgressHUDView *hud;

@property (readwrite, nonatomic) NSString *style;

@end
