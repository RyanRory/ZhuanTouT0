//
//  T0BalanceViewController.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/28.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BalanceViewController.h"

@interface T0BalanceViewController ()

@end

@implementation T0BalanceViewController

@synthesize tView, toChargeButton, balanceLabel;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [toChargeButton addTarget:self action:@selector(toCharge:) forControlEvents:UIControlEventTouchUpInside];
    
    dataModel = [T0BalanceDataModel shareInstance];
    
    balanceLabel.text = [T0BaseFunction formatterNumberWithDecimal:[dataModel getBalance]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    T0NavigationController *nav = (T0NavigationController*)self.navigationController;
    [nav dismissPageControl];
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
    balanceLabel.text = [T0BaseFunction formatterNumberWithDecimal:[dataModel getBalance]];
    [tView reloadData];
}

#pragma ServerError
- (void)showError
{
    
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma buttonAction
- (void)toCharge:(id)sender
{
    
}

#pragma TableViewDelegate/DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 10;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataModel getCellObjects].count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    T0BalanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"T0BalanceTableViewCell"];
    if (!cell)
    {
        cell = [[T0BalanceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"T0BalanceTableViewCell"];
    }
    id data = [dataModel getCellObjects][indexPath.section];
    
    cell.titleLabel.text = [data objectForKey:@"title"];
    cell.progressLabel.text = [data objectForKey:@"progress"];
    cell.timeLabel.text = [data objectForKey:@"time"];
    [T0BaseFunction setColoredLabelText:cell.amountLabel Number:[NSString stringWithFormat:@"%@",[data objectForKey:@"amount"]]];
    
    return cell;
}

@end
