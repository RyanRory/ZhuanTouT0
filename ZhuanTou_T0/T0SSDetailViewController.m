//
//  T0SSDetailViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/30.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0SSDetailViewController.h"

@interface T0SSDetailViewController ()

@end

@implementation T0SSDetailViewController

@synthesize tView, cellObjects,titleLabel, data;
@synthesize passwordButton, endButton, recordButton, agreementButton;
@synthesize statusLabel, dateLabel, modeLabel, sumProfitLabel, allProfitLabel;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [self initData];
    
    [self initButtonAction:agreementButton];
    agreementButton.tag = 0;
    [self initButtonAction:recordButton];
    recordButton.tag = 1;
    [self initButtonAction:passwordButton];
    passwordButton.tag = 2;
    [self initButtonAction:endButton];
    endButton.tag = 3;
    
    if ([self.style isEqualToString:RECOMMENDSTOCKCOURCE])
    {
        passwordButton.hidden = YES;
        endButton.hidden = YES;
        self.ReSSButtonLayoutConstraint.priority = 999;
    }
    
//    [tView.layer setBorderWidth:1.0];
//    [tView.layer setBorderColor:[UIColor colorWithRed:45.0/255.0 green:47.0/255.0 blue:56.0/255.0 alpha:1.0].CGColor];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    T0NavigationController *nav = (T0NavigationController*)self.navigationController;
    [nav dismissPageControl];
}

#pragma initData Function
- (void)initData
{
    cellObjects = [NSArray arrayWithArray:[data objectForKey:@"stocks"]];
    if ([[[data objectForKey:@"stockAccount"] objectForKey:@"accountNumber"] isKindOfClass:[NSNull class]])
    {
        titleLabel.text = @"账户号(暂未登记)";
    }
    else
    {
        titleLabel.text = [NSString stringWithFormat:@"账户号%@", [[data objectForKey:@"stockAccount"] objectForKey:@"accountNumber"]];
    }
    
    statusLabel.text = [data objectForKey:@"status"];
    if ([statusLabel.text isEqualToString:@"操盘中"] || [statusLabel.text isEqualToString:@"合作到期"] || [statusLabel.text isEqualToString:@"申请终止"] || [statusLabel.text isEqualToString:@"已结束"])
    {
        [recordButton setUserInteractionEnabled:YES];
        [recordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        [recordButton setUserInteractionEnabled:NO];
        [recordButton setTitleColor:MYSSUNABLEGRAY forState:UIControlStateNormal];
    }
    
    if ([statusLabel.text isEqualToString:@"提前终结处理中"] || [statusLabel.text isEqualToString:@"合作到期"] || [statusLabel.text isEqualToString:@"申请终止"] || [statusLabel.text isEqualToString:@"已结束"])
    {
        [endButton setUserInteractionEnabled:NO];
        [endButton setTitleColor:MYSSUNABLEGRAY forState:UIControlStateNormal];
    }
    else
    {
        [endButton setUserInteractionEnabled:YES];
        [endButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    modeLabel.text = [data objectForKey:@"profitModel"];
    if ([[data objectForKey:@"nextWithdrawDate"] isKindOfClass:[NSNull class]])
    {
        dateLabel.text = @"未知";
    }
    else
    {
        dateLabel.text = [data objectForKey:@"nextWithdrawDate"];
    }
    
    [T0BaseFunction setColoredLabelText:allProfitLabel Number:[NSString stringWithFormat:@"%@",[data objectForKey:@"currentCycleProfit"]]];
    [T0BaseFunction setColoredLabelText:sumProfitLabel Number:[NSString stringWithFormat:@"%@",[data objectForKey:@"cumExtraProfit"]]];
}

#pragma initButtonAction Function
- (void)initButtonAction:(UIButton*)sender
{
    [sender addTarget:self action:@selector(buttonTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(buttonTouchDownAction:) forControlEvents:UIControlEventTouchDown];
    [sender addTarget:self action:@selector(buttonCancelAction:) forControlEvents:UIControlEventTouchCancel];
    [sender addTarget:self action:@selector(buttonCancelAction:) forControlEvents:UIControlEventTouchDragExit];
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

- (void)buttonTouchUpInsideAction:(UIButton*)sender
{
    sender.backgroundColor = MYSSBUTTONDARK;
    switch (sender.tag) {
        case 0:
        {
            T0WebViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0WebViewController"];
            vc.titleText = @"合同";
            vc.url = [NSString stringWithFormat:@"https://www.zhuantouwang.com/Wap/WebView/RegisterStatement"];
            [[self navigationController]pushViewController:vc animated:YES];
            break;
        }
            
        case 1:
        {
            T0SSRecordViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0SSRecordViewController"];
            vc.orderNo = [NSString stringWithFormat:@"%@", [data objectForKey:@"orderNo"]];
            vc.style = self.style;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
    
        case 2:
        {
            if ([[[data objectForKey:@"stockAccount"] objectForKey:@"tradePassword"] isKindOfClass:[NSNull class]])
            {
                T0SetPasswordViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0SetPasswordViewController"];
                vc.account = [NSDictionary dictionaryWithDictionary:[data objectForKey:@"stockAccount"]];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                T0ShowPasswordViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0ShowPasswordViewController"];
                vc.account = [NSDictionary dictionaryWithDictionary:[data objectForKey:@"stockAccount"]];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        }
            
        case 3:
        {
            LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:nil message:@"是否确认提前终结?" style:LGAlertViewStyleAlert buttonTitles:@[@"确定"] cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index){
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/intraday/finish/%@", [data objectForKey:@"id"]]];
                NSLog(@"%@",URL);
                [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                    NSLog(@"%@", responseObject);
                    if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
                    {
                        errorView = [[T0ErrorMessageView alloc]init];
                        [errorView showInView:self.navigationController.view withMessage:@"提前终结完成" byStyle:ERRORMESSAGESUCCESS];
                        [self.navigationController popViewControllerAnimated:YES];

                    }
                    else
                    {
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowError" object:[responseObject objectForKey:@"errorMessage"]];
                    }
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"HTTPFail" object:nil];
                    
                }];
            } cancelHandler:nil destructiveHandler:nil];
            alertView.backgroundColor = MYSSBUTTONDARK;
            alertView.buttonsTitleColor = [UIColor whiteColor];
            alertView.buttonsBackgroundColorHighlighted = MYSSBUTTONBLUE;
            alertView.buttonsFont = [UIFont systemFontOfSize:13.0];
            alertView.messageTextColor = [UIColor whiteColor];
            alertView.cancelButtonTitleColor = [UIColor whiteColor];
            alertView.cancelButtonBackgroundColorHighlighted = MYSSBUTTONBLUE;
            alertView.cancelButtonFont = [UIFont systemFontOfSize:13.0];
            alertView.separatorsColor = self.view.backgroundColor;
            [alertView showAnimated:YES completionHandler:nil];

        }
            
        default:
            break;
    }
}

- (void)buttonTouchDownAction:(UIButton*)sender
{
    sender.backgroundColor = MYSSBUTTONBLUE;
}

- (void)buttonCancelAction:(UIButton*)sender
{
    sender.backgroundColor = MYSSBUTTONDARK;
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TableViewDelegate/DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 103;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.00000000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00000000001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return cellObjects.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = cellObjects[indexPath.section];
    T0SSDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"T0SSDetailTableViewCell"];
    if (!cell)
    {
        cell = [[T0SSDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"T0SSDetailTableViewCell"];
    }
    cell.nameLabel.text = [object objectForKey:@"stockName"];
    
    cell.originalStockAmountLabel.text = [T0BaseFunction formatterNumberWithoutDecimal:[NSString stringWithFormat:@"%@",[object objectForKey:@"initialNoOfShares"]]];
    cell.instanceStockAmountLabel.text = [T0BaseFunction formatterNumberWithoutDecimal:[NSString stringWithFormat:@"%@",[object objectForKey:@"yesterdayNoOfShares"]]];
    cell.marketValueLabel.text = [T0BaseFunction formatterNumberWithDecimal:[NSString stringWithFormat:@"%@",[object objectForKey:@"yesterdayMarketValue"]]];
    if (indexPath.section == cellObjects.count-1)
    {
        cell.shortLine.hidden = YES;
        cell.bottomLine.hidden = NO;
    }
    else
    {
        cell.shortLine.hidden = NO;
        cell.bottomLine.hidden = YES;
    }
    
    [T0BaseFunction setColoredLabelText:cell.lastDayProfitLabel Number:[NSString stringWithFormat:@"%@",[object objectForKey:@"yesterdayProfit"]]];
    [T0BaseFunction setColoredLabelText:cell.allProfitLabel Number:[NSString stringWithFormat:@"%@",[object objectForKey:@"currentCycleProfit"]]];
    [T0BaseFunction setColoredLabelText:cell.sumProfitLabel Number:[NSString stringWithFormat:@"%@",[object objectForKey:@"cumExtraProfit"]]];
    
    return cell;
}

@end
