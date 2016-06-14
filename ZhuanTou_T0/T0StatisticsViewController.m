//
//  T0StatisticsViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/3.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0StatisticsViewController.h"

@interface T0StatisticsViewController ()

@end

@implementation T0StatisticsViewController

@synthesize lineChartView, grandTotalNumLabel, operatingTotalNumLabel, yesterdayIncomeLabel, availableNumLabel,recordButton, chartView, bgImageView;
@synthesize scrollView, viewHeight;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [self initButtonAction:recordButton];
    
    [self initChart];
    
    scrollView.mj_header = [T0RefreshHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    
    dataModel = [T0StatisticsDataModel shareInstance];
    
    [self loadNewData];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    viewHeight.constant = SCREEN_HEIGHT-64-45;
    bgImageViewOriginFrame = bgImageView.frame;
}

#pragma loadNewData
- (void)loadNewData
{
    isLoading = true;
    [dataModel getDataFromServer];
}

#pragma initData
- (void)initChartData
{
    [xLabels removeAllObjects];
    [yLabels removeAllObjects];
    [points removeAllObjects];
    double max, min;
    NSString *key = @"cumProfit";
    max = min = [NSString stringWithFormat:@"%@",[lineChartData[0] objectForKey:key]].doubleValue;
    for (int i = 0; i < lineChartData.count; i++)
    {
        //[xLabels addObject:[NSString stringWithFormat:@"%@",[lineChartData[i] objectForKey:@"date"]]];
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
    
    if (lineChartData.count <=5)
    {
        for (int i = 0; i < lineChartData.count; i++)
        {
            [xLabels addObject:[NSString stringWithFormat:@"%@",[lineChartData[i] objectForKey:@"date"]]];
        }
    }
    else
    {
        int betweens = floor(lineChartData.count/4);
        for (int i = 0, j = 0; j < 5; j++, i+=betweens)
        {
            [xLabels addObject:[NSString stringWithFormat:@"%@",[lineChartData[i] objectForKey:@"date"]]];
        }
    }
    
    min = floor(min);
    max = ceil(max);
    double temp = (max-min)/5;
    for (int i = 0; i < 6; i++)
    {
        [yLabels addObject:[NSString stringWithFormat:@"%d",(int)(max-i*temp)]];
    }
    
    [lineChartView setXLabels:xLabels];
    [lineChartView setYLabels:yLabels];
    [lineChartView setPoints:points];
    [lineChartView showLineChart];
    
}

- (void)initData
{
    data = [NSDictionary dictionaryWithDictionary:[dataModel getData]];
    grandTotalNumLabel.text = [T0BaseFunction formatterNumberWithDecimal:[NSString stringWithFormat:@"%@", [data objectForKey:@"cumProfit"]]];
    operatingTotalNumLabel.text = [T0BaseFunction formatterNumberWithDecimal:[NSString stringWithFormat:@"%@", [data objectForKey:@"runningAssets"]]];
    [T0BaseFunction setColoredLabelText:yesterdayIncomeLabel Number:[NSString stringWithFormat:@"%@", [data objectForKey:@"yesterdayProfit"]]];
    availableNumLabel.text = [T0BaseFunction formatterNumberWithDecimal:[NSString stringWithFormat:@"%@", [data objectForKey:@"fundsAvailable"]]];
    lineChartData = [NSMutableArray arrayWithArray:[data objectForKey:@"dailyStats"]];
    xLabels = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil];
    yLabels = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", nil];
    points = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil];
    if (lineChartData.count > 0)
    {
        [self initChartData];
    }
    else
    {
        [lineChartView setXLabels:xLabels];
        [lineChartView setYLabels:yLabels];
        [lineChartView setPoints:points];
        [lineChartView showLineChart];
    }
}

#pragma initChart
- (void)initChart
{
    lineChartView = [[T0LineChartView alloc]initWithFrame:CGRectMake(4, 18, SCREEN_WIDTH-24, SCREEN_HEIGHT-216-SCREEN_WIDTH/32*21)];
    [chartView addSubview:lineChartView];
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

#pragma refreshData
- (void)refreshData
{
    self.hud.hidden = YES;
    isLoading = false;
    [self initData];
    
    [scrollView.mj_header endRefreshing];
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma buttonAction
#pragma buttonAction Function
- (void)initButtonAction:(UIButton*)sender
{
    [sender addTarget:self action:@selector(buttonTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(buttonTouchDownAction:) forControlEvents:UIControlEventTouchDown];
    [sender addTarget:self action:@selector(buttonCancelAction:) forControlEvents:UIControlEventTouchCancel];
    [sender addTarget:self action:@selector(buttonCancelAction:) forControlEvents:UIControlEventTouchDragExit];
}
- (void)buttonTouchUpInsideAction:(UIButton*)sender
{
    sender.backgroundColor = MYSSBUTTONDARK;
    T0BalanceViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0BalanceViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)buttonTouchDownAction:(UIButton*)sender
{
    sender.backgroundColor = MYSSBUTTONBLUE;
}

- (void)buttonCancelAction:(UIButton*)sender
{
    sender.backgroundColor = MYSSBUTTONDARK;
}

#pragma scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrView
{
    if (scrollView.contentOffset.y<=0)
    {
        [bgImageView setFrame:CGRectMake(bgImageViewOriginFrame.origin.x-bgImageViewOriginFrame.size.width*((bgImageViewOriginFrame.size.height-scrView.contentOffset.y)/bgImageViewOriginFrame.size.height-1)/2, bgImageViewOriginFrame.origin.y, bgImageViewOriginFrame.size.width*(bgImageViewOriginFrame.size.height-scrView.contentOffset.y)/bgImageViewOriginFrame.size.height, bgImageViewOriginFrame.size.height-scrView.contentOffset.y)];
    }
    else
    {
        [bgImageView setFrame:CGRectMake(bgImageViewOriginFrame.origin.x, bgImageViewOriginFrame.origin.y-scrView.contentOffset.y, bgImageViewOriginFrame.size.width, bgImageViewOriginFrame.size.height)];
    }
}



@end
