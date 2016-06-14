//
//  T0StockSourceViewController.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/26.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0StockSourceChooseView.h"
#import "T0StockDataModel.h"
#import "T0StockSourceButtonTableViewCell.h"
#import "T0StockSourceTableViewCell.h"

#import "T0StockSourceAddViewController.h"
#import "T0StockSourceCompleteViewController.h"

@interface T0StockSourceViewController : T0BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    T0StockDataModel *dataModel;
}

@property (strong, nonatomic) IBOutlet T0StockSourceChooseView *chooseView;
@property (strong, nonatomic) IBOutlet UITableView *tView;
@property (strong, nonatomic) IBOutlet T0ProgressHUDView *hud;

@end
