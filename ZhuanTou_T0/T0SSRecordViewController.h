//
//  T0SSRecordViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0SSRecordTableViewCell.h"
#import "T0SettleRecordDataModel.h"

#import "T0SSReportViewController.h"
#import "T0SSSettleViewController.h"
#import "T0BalanceViewController.h"

@interface T0SSRecordViewController : T0BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *cellObjects;
    T0SettleRecordDataModel *dataModel;
    BOOL isDataLoading;
}

@property (strong, nonatomic) IBOutlet UITableView *tView;
@property (strong, nonatomic) IBOutlet UIButton *BalanceButton;
@property (strong, nonatomic) IBOutlet T0ProgressHUDView *hud;

@property (readwrite, nonatomic) NSString *orderNo;
@property (readwrite, nonatomic) NSString *style;

@end
