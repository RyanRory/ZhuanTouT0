//
//  T0StatisticsViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/3.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0LineChartView.h"
#import "T0StatisticsDataModel.h"

#import "T0BalanceViewController.h"

@interface T0StatisticsViewController : T0BaseViewController<UIScrollViewDelegate>
{
    NSMutableArray *lineChartData, *xLabels, *yLabels, *points;
    CGRect bgImageViewOriginFrame;
    T0StatisticsDataModel *dataModel;
    NSDictionary *data;
}

@property (strong, nonatomic) T0LineChartView *lineChartView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *chartView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutlet T0ProgressHUDView *hud;
@property (strong, nonatomic) IBOutlet UILabel *allStockProfitLabel;
@property (strong, nonatomic) IBOutlet UILabel *yesterdayStockProfitLabel;
@property (strong, nonatomic) IBOutlet UILabel *allBrokerProfitLabel;
@property (strong, nonatomic) IBOutlet UILabel *yesterdayBrokerProfitLabel;
@property (strong, nonatomic) IBOutlet UILabel *grandTotalNumLabel;

@end
