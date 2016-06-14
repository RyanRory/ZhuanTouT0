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

@synthesize tView, titleLabel, toStockSourceButton;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];

    if ([self.style isEqualToString:MYSTOCKCOURCE])
    {
        SSDataModel = [T0MySSDataModel shareInstance];
        titleLabel.text = @"我的股票";
    }
    else
    {
        ReSSDataModel = [T0RecommendSSDataModel shareInstance];
        titleLabel.text = @"我的推荐";
    }
    
    toStockSourceButton.hidden = YES;
    [self initButtonAction:toStockSourceButton];
    
    tView.mj_header = [T0RefreshHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadNewData];
}

#pragma loadNewData
- (void)loadNewData
{
    isLoading = true;
    if ([self.style isEqualToString:MYSTOCKCOURCE])
    {
        [SSDataModel getDataFromServer];
    }
    else
    {
        [ReSSDataModel getDataFromServer];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma refreshData
- (void)refreshData
{
    self.hud.hidden = YES;
    isLoading = false;
    [tView.mj_header endRefreshing];
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

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    T0StockSourceViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0StockSourceViewController"];
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
    if (!isLoading)
    {
        [tableView tableViewDisplayWitMsg:@"暂无记录" imageName:@"NoStockSource" ifNecessaryForRowCount:cellObjects.count];
        if (cellObjects.count)
        {
            toStockSourceButton.hidden = YES;
        }
        else
        {
            toStockSourceButton.hidden = NO;
        }
    }
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
        if ([[[data objectForKey:@"stockAccount"] objectForKey:@"accountNumber"] isKindOfClass:[NSNull class]])
        {
            cell.accountLabel.text = @"账户号(暂未登记)";
        }
        else
        {
            cell.accountLabel.text = [NSString stringWithFormat:@"账户号%@", [[data objectForKey:@"stockAccount"] objectForKey:@"accountNumber"]];
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
        
        if ([[data objectForKey:@"status"] isEqualToString:@"操盘中"] || [[data objectForKey:@"status"] isEqualToString:@"合作到期"])
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
