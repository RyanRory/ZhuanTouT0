//
//  T0MySSViewController.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/28.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0MySSViewController.h"

@interface T0MySSViewController ()

@end

@implementation T0MySSViewController

@synthesize tView, titleLabel;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];

    if ([self.style isEqualToString:MYSTOCKCOURCE])
    {
        SSDataModel = [T0MySSDataModel shareInstance];
        [SSDataModel getDataFromServer];
        cellObjects = [NSMutableArray arrayWithArray:[SSDataModel getCellObjects]];
        titleLabel.text = @"我的股票";
    }
    else
    {
        ReSSDataModel = [T0RecommendSSDataModel shareInstance];
        [ReSSDataModel getDataFromServer];
        cellObjects = [NSMutableArray arrayWithArray:[ReSSDataModel getCellObjects]];
        titleLabel.text = @"我的推荐";
    }
    
    
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma refreshData
- (void)refreshData
{
    if ([self.style isEqualToString:MYSTOCKCOURCE])
    {
        cellObjects = [NSMutableArray arrayWithArray:[SSDataModel getCellObjects]];
    }
    else
    {
        cellObjects = [NSMutableArray arrayWithArray:[ReSSDataModel getCellObjects]];
    }
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

#pragma TableViewDelegate/DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id data = cellObjects[indexPath.section];
    NSArray *array = [NSArray arrayWithArray:[data objectForKey:@"stocks"]];
    if (indexPath.row == 0)
    {
        return 31;
    }
    else if (indexPath.row == array.count+1)
    {
        return 40;
    }
    else
    {
        return 113;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return 0.00000000001;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == cellObjects.count-1)
    {
        return 0.00000000001;
    }
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id data = cellObjects[section];
    NSArray *array = [NSArray arrayWithArray:[data objectForKey:@"stocks"]];
    return array.count+2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return cellObjects.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id data = cellObjects[indexPath.section];
    NSArray *array = [NSArray arrayWithArray:[data objectForKey:@"stocks"]];
    if (indexPath.row == 0)
    {
        T0MySSTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"T0MySSTableViewCell1"];
        if (!cell)
        {
            cell = [[T0MySSTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"T0MySSTableViewCell1"];
        }
        if ([[data objectForKey:@"stockAccount"] isKindOfClass:[NSNull class]])
        {
            cell.accountLabel.text = @"资金账户？？？？？？";
        }
        else
        {
            cell.accountLabel.text = [NSString stringWithFormat:@"资金账户%@", [data objectForKey:@"stockAccount"]];
        }
        cell.statusLabel.text = [data objectForKey:@"status"];
        
        return cell;
    }
    else if (indexPath.row == array.count+1)
    {
        T0MySSTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"T0MySSTableViewCell3"];
        if (!cell)
        {
            cell = [[T0MySSTableViewCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"T0MySSTableViewCell3"];
        }
        
        return cell;
    }
    else
    {
        T0MySSTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"T0MySSTableViewCell2"];
        if (!cell)
        {
            cell = [[T0MySSTableViewCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"T0MySSTableViewCell2"];
        }
        id stock = array[indexPath.row-1];
        cell.nameLabel.text = [stock objectForKey:@"stockName"];
        
        if ([[data objectForKey:@"status"] isEqualToString:@"操盘中"])
        {
            [T0BaseFunction setColoredLabelText:cell.lastDayProfitLabel Number:[NSString stringWithFormat:@"%@",[stock objectForKey:@"yesterdayProfit"]]];
            [T0BaseFunction setColoredLabelText:cell.allProfitLabel Number:[NSString stringWithFormat:@"%@",[stock objectForKey:@"currentCycleProfit"]]];
        }
        else
        {
            cell.lastDayProfitLabel.textColor = MYSSGRAY;
            cell.lastDayProfitLabel.text = @"/";
            cell.allProfitLabel.textColor = MYSSGRAY;
            cell.allProfitLabel.text = @"/";
        }
        
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id data = cellObjects[indexPath.section];
    NSArray *array = [NSArray arrayWithArray:[data objectForKey:@"stocks"]];
    if (indexPath.row == array.count+1)
    {
        T0SSDetailViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0SSDetailViewController"];
        vc.data = [NSDictionary dictionaryWithDictionary:data];
        vc.style = self.style;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
