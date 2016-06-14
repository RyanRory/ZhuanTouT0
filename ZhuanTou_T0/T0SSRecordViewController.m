//
//  T0SSRecordViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0SSRecordViewController.h"

@interface T0SSRecordViewController ()

@end

@implementation T0SSRecordViewController

@synthesize tView, orderNo, BalanceButton;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    dataModel = [T0SettleRecordDataModel shareInstance];
    
    BalanceButton.hidden = YES;
    
    if ([self.style isEqualToString:RECOMMENDSTOCKCOURCE])
    {
        BalanceButton.hidden = NO;
        BalanceButton.tag = 0;
        [self initButtonAction:BalanceButton];
    }
    
    tView.mj_header = [T0RefreshHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadNewData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    T0NavigationController *nav = (T0NavigationController*)self.navigationController;
    [nav dismissPageControl];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goToDetail) name:@"GoToDetail" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"GoToDetail" object:nil];
}

#pragma loadNewData
- (void)loadNewData
{
    isDataLoading = true;
    [dataModel getDataFromServer:orderNo];
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
    isDataLoading = false;
    cellObjects = [NSArray arrayWithArray:[dataModel getCellObjects]];
    [tView reloadData];
    [tView.mj_header endRefreshing];
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma GotoDetail
- (void)goToDetail
{
    self.hud.hidden = YES;
    isLoading = false;
    T0SSReportViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0SSReportViewController"];
    vc.data = [NSDictionary dictionaryWithDictionary:[dataModel getDetailData]];
    [self.navigationController pushViewController:vc animated:YES];
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
    long index = sender.tag/1000;
    long tag = sender.tag%1000;
    if (tag == 2)
    {
        if (!isLoading)
        {
            self.hud.hidden = NO;
            isLoading = true;
            [dataModel getDetailDataFromServer:orderNo from:[cellObjects[index] objectForKey:@"startDate"] to:[cellObjects[index] objectForKey:@"settleDate"]];
        }
    }
    else if (tag == 1)
    {
        T0SSSettleViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0SSSettleViewController"];
        vc.orderNo = [cellObjects[index] objectForKey:@"id"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        T0BalanceViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0BalanceViewController"];
        [self.navigationController pushViewController:vc animated:YES];
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

#pragma TableViewDelegate/DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 0.00000000001;
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == cellObjects.count-1)
    {
        if ([self.style isEqualToString:RECOMMENDSTOCKCOURCE])
        {
            return 50;
        }
        return 0.00000000001;
    }
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!isDataLoading)
    {
        [tableView tableViewDisplayWitMsg:@"暂无结算记录" imageName:@"NoRecord" ifNecessaryForRowCount:[dataModel getCellObjects].count];
    }
    return cellObjects.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = cellObjects[indexPath.section];
    T0SSRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"T0SSRecordTableViewCell"];
    if (!cell)
    {
        cell = [[T0SSRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"T0SSRecordTableViewCell"];
    }
    
    [self initButtonAction:cell.closeButton];
    cell.closeButton.tag = indexPath.section *1000 + 1;
    cell.closeButton.hidden = NO;
    if ([self.style isEqualToString:RECOMMENDSTOCKCOURCE])
    {
        cell.closeButton.hidden = YES;
        cell.constraint.priority = 997;
    }
    [self initButtonAction:cell.reportButton];
    cell.reportButton.tag = indexPath.section *1000 + 2;
    
    cell.dateLabel.text = [object objectForKey:@"settleDate"];
    [T0BaseFunction setColoredLabelText:cell.profitLabel Number:[NSString stringWithFormat:@"%@",[object objectForKey:@"earningAmount"]]];
    cell.statusLabel.text = [object objectForKey:@"status"];
    if ([cell.statusLabel.text isEqualToString:@"已完成打款"])
    {
        [cell.closeButton setUserInteractionEnabled:NO];
        [cell.closeButton setTitleColor:MYSSUNABLEGRAY forState:UIControlStateNormal];
        [cell.closeButton setTitle:@"已完成打款" forState:UIControlStateNormal];
    }
    else
    {
        [cell.closeButton setUserInteractionEnabled:YES];
        [cell.closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.closeButton setTitle:@"我要结算" forState:UIControlStateNormal];
    }
    
    return cell;
}

@end
