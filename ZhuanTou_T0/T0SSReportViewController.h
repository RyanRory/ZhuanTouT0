//
//  T0SSReportViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0LineChartView.h"
#import "T0StockSourceChooseView.h"

@interface T0SSReportViewController : T0BaseViewController
{
    NSMutableArray *lineChartData, *xLabels, *yLabels, *points;
}

@property (strong, nonatomic) T0LineChartView *lineChartView;
@property (strong, nonatomic) IBOutlet UIView *topBgView;
@property (strong, nonatomic) IBOutlet T0StockSourceChooseView *chooseView;
@property (strong, nonatomic) IBOutlet UILabel *rateLabel;
@property (strong, nonatomic) IBOutlet UILabel *allProfitLabel;
@property (strong, nonatomic) IBOutlet UILabel *realProfitLabel;

@property (readwrite, nonatomic)NSDictionary *data;

@end
