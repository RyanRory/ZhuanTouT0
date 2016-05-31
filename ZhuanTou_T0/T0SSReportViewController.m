//
//  T0SSReportViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0SSReportViewController.h"

@interface T0SSReportViewController ()

@end

@implementation T0SSReportViewController

@synthesize lineChartView;
@synthesize data;
@synthesize chooseView;
@synthesize topBgView, rateLabel, allProfitLabel, realProfitLabel;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [self initData];
    
    [self initChart];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    T0NavigationController *nav = (T0NavigationController*)self.navigationController;
    [nav dismissPageControl];
}

#pragma initData
- (void)initChartData:(NSString*)key
{
    [xLabels removeAllObjects];
    [yLabels removeAllObjects];
    [points removeAllObjects];
    double max, min;
    max = min = [NSString stringWithFormat:@"%@",[lineChartData[0] objectForKey:key]].doubleValue;
    for (int i = 0; i < lineChartData.count; i++)
    {
        [xLabels addObject:[NSString stringWithFormat:@"%@",[lineChartData[i] objectForKey:@"date"]]];
        [points addObject:[NSString stringWithFormat:@"%@",[lineChartData[i] objectForKey:key]]];
        if ([NSString stringWithFormat:@"%@",[lineChartData[i] objectForKey:key]].doubleValue > max)
        {
            max = [NSString stringWithFormat:@"%@",[lineChartData[i] objectForKey:key]].doubleValue;
        }
        if (min > [NSString stringWithFormat:@"%@",[lineChartData[i] objectForKey:key]].doubleValue)
        {
            min = [NSString stringWithFormat:@"%@",[lineChartData[i] objectForKey:key]].doubleValue;
        }
    }
    min = floor(min);
    max = ceil(max);
    double temp = (max-min)/5;
    for (int i = 0; i < 6; i++)
    {
        [yLabels addObject:[NSString stringWithFormat:@"%d",(int)(max-i*temp)]];
    }
}

- (void)initData
{
    [topBgView.layer setBorderColor:MYSSBORDERGRAY.CGColor];
    [topBgView.layer setBorderWidth:1.0f];
    
    [T0BaseFunction setColoredLabelText:allProfitLabel Number:[NSString stringWithFormat:@"%@",[data objectForKey:@"cycleTotalProfit"]]];
    [T0BaseFunction setColoredLabelText:realProfitLabel Number:[NSString stringWithFormat:@"%@",[data objectForKey:@"cycleRealProfit"]]];
    rateLabel.text = @"40%";
    
    [chooseView setTitle:@""];
    [chooseView addButtons:[NSArray arrayWithObjects:@"当期T0总收益曲线", @"当期实际到手收益曲线", nil] withMarginBetween:15 withMarginSides:4];
    [chooseView setButtonsFontSize:13];
    [chooseView setSelected:0];
    NSArray *buttons = [NSArray arrayWithArray:[chooseView.buttonOnlyEngine getButtons]];
    [buttons[0] addTarget:self action:@selector(buttonTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttons[1] addTarget:self action:@selector(buttonTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
    
    lineChartData = [NSMutableArray arrayWithArray:[data objectForKey:@"dailyPerfs"]];
    xLabels = [[NSMutableArray alloc]init];
    yLabels = [[NSMutableArray alloc]init];
    points = [[NSMutableArray alloc]init];
    
    [self initChartData:@"dailyTotalProfit"];
}

#pragma initChart
- (void)initChart
{
    lineChartView = [[T0LineChartView alloc]initWithFrame:CGRectMake(12, 208, SCREEN_WIDTH-24, 200)];
    [self.view addSubview:lineChartView];
    [lineChartView setXLabels:xLabels];
    [lineChartView setYLabels:yLabels];
    [lineChartView setPoints:points];
    [lineChartView showLineChart];
}

#pragma buttonAction Function
- (void)buttonTouchUpInsideAction:(id)sender
{
    if ([chooseView.buttonOnlyEngine getSelectedButtonTag] == 0)
    {
        [self initChartData:@"dailyTotalProfit"];
        [lineChartView setXLabels:xLabels];
        [lineChartView setYLabels:yLabels];
        [lineChartView setPoints:points];
        [lineChartView showLineChart];
    }
    else
    {
        [self initChartData:@"dailyRealProfit"];
        [lineChartView setXLabels:xLabels];
        [lineChartView setYLabels:yLabels];
        [lineChartView setPoints:points];
        [lineChartView showLineChart];
    }
}

#pragma Navigation Function
- (void)initNavigationBar
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    leftItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, item, nil];
}

- (void)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
