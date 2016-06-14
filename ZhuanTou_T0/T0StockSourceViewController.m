//
//  T0StockSourceViewController.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/26.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0StockSourceViewController.h"

@interface T0StockSourceViewController ()

@end

@implementation T0StockSourceViewController

@synthesize tView, chooseView;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [chooseView setTitle:@"账户是否属于您本人"];
    [chooseView addButtons:[NSArray arrayWithObjects:@"是", @"否", nil] withMarginBetween:30 withMarginSides:20];
    
    dataModel = [T0StockDataModel shareInstance];
    
    self.hud.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [tView reloadData];
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Navigation Function
- (void)initNavigationBar
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    leftItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ConfirmCheck"] style:UIBarButtonItemStylePlain target:self action:@selector(next:)];
    rightItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, item, nil];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem, item, nil];
}

- (void)next:(id)sender
{
    if (!isLoading)
    {
        if ([chooseView.buttonOnlyEngine getSelectedButtonTag] == -1)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请选择账户是否属于您本人" byStyle:ERRORMESSAGEWARNING];
        }
        else if ([dataModel getStockSourceArray].count == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请添加您的股票" byStyle:ERRORMESSAGEWARNING];
        }
        else
        {
            isLoading = true;
            self.hud.hidden = NO;
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/intraday/sendStockSource"]];
            BOOL isBroker = [chooseView.buttonOnlyEngine getSelectedButtonTag];
            
            NSDictionary *parameters = @{@"isBroker":[T0BaseFunction boolToString:isBroker],
                                         @"stocks":[dataModel getStockSourceArray]};
            [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                NSLog(@"%@", responseObject);
                self.hud.hidden = YES;
                if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
                {
                    [dataModel clearData];
                    T0StockSourceCompleteViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0StockSourceCompleteViewController"];
                    if ([chooseView.buttonOnlyEngine getSelectedButtonTag] == 0)
                    {
                        vc.style = MYSTOCKCOURCE;
                    }
                    else
                    {
                        vc.style = RECOMMENDSTOCKCOURCE;
                    }
                    isLoading = false;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowError" object:[responseObject objectForKey:@"errorMessage"]];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                self.hud.hidden = YES;
                [[NSNotificationCenter defaultCenter]postNotificationName:@"HTTPFail" object:nil];
            }];
        }
    }

}

- (void)cancel:(id)sender
{
    [dataModel clearData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addStockSource:(id)sender
{
    T0StockSourceAddViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0StockSourceAddViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma DeleteButtonAction
- (void)deleteAtIndex:(UIButton*)sender
{
    [dataModel deleteStockSourceAtIndex:(int)sender.tag];
    [tView reloadData];
}

#pragma TableViewDelegate/DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([dataModel getStockSourceArray].count == 0)
    {
        return 35;
    }
    return 73;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 5;
    }
    return  0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataModel getStockSourceArray].count+1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [dataModel getStockSourceArray].count)
    {
        T0StockSourceButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"T0StockSourceButtonTableViewCell"];
        if (!cell)
        {
            cell = [[T0StockSourceButtonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"T0StockSourceButtonTableViewCell"];
        }
        [cell.button addTarget:self action:@selector(addStockSource:) forControlEvents:UIControlEventTouchUpInside];
        if ([dataModel getStockSourceArray].count == 0)
        {
            [cell.button setTitle:@"添加券源" forState:UIControlStateNormal];
        }
        else
        {
            [cell.button setTitle:@"继续添加" forState:UIControlStateNormal];
        }
    
        return cell;
        
    }
    else
    {
        id data = [[dataModel getStockSourceArray] objectAtIndex:indexPath.section];
        T0StockSourceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"T0StockSourceTableViewCell"];
        if (!cell)
        {
            cell = [[T0StockSourceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"T0StockSourceTableViewCell"];
        }
        cell.stockCodeNNameLabel.text = [NSString stringWithFormat:@"%@ %@", [data objectForKey:@"stockCode"], [data objectForKey:@"stockName"]];
        cell.marketValueLabel.text = [T0BaseFunction formatterNumberWithoutDecimal:[data objectForKey:@"noOfShares"]];
        cell.preTimeLabel.text = [data objectForKey:@"preTime"];
        cell.deleteButton.tag = indexPath.section;
        [cell.deleteButton addTarget:self action:@selector(deleteAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}

@end
