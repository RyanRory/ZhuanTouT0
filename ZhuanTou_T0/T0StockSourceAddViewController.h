//
//  T0StockSourceAddViewController.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/25.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0StockSourceChooseView.h"
#import "T0ChooseListView.h"
#import "T0StockDataModel.h"
#import "T0SearchEngine.h"

@interface T0StockSourceAddViewController : T0BaseViewController<UITextFieldDelegate>
{
    unsigned long lastLength;
    T0StockDataModel *dataModel;
}

@property (strong, nonatomic) IBOutlet T0StockSourceChooseView *chooseView;
@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *stockCodeTextField;
@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *stockValueTextField;
@property (strong, nonatomic) IBOutlet T0ChooseListView *chooseListView;

@end
