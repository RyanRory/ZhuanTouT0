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

@synthesize tView, toChargeButton, balanceLabel, scrollView, viewConstraint, bgImageView;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [self initButtonAction:toChargeButton];
    
    dataModel = [T0BalanceDataModel shareInstance];
    
    scrollView.userInteractionEnabled = NO;
    
    tView.mj_header = [T0RefreshHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadNewData];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    viewConstraint.constant = self.view.frame.size.height;
    bgImageViewOriginFrame = bgImageView.frame;
}

#pragma loadNewData
- (void)loadNewData
{
    isLoading = true;
    [dataModel getDataFromServer];
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
    balanceLabel.text = [T0BaseFunction formatterNumberWithDecimal:[dataModel getBalance]];
    [tView reloadData];
    [tView.mj_header endRefreshing];
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
    T0MyBankCardViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0MyBankCardViewController"];
    vc.style = DRAW;
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
    return 58;
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
    if (!isLoading)
    {
        [tableView tableViewDisplayWitMsg:@"暂无佣金记录" imageName:@"NoRecord" ifNecessaryForRowCount:[dataModel getCellObjects].count];
    }
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
    
    cell.titleLabel.text = [data objectForKey:@"subject"];
    cell.timeLabel.text = [data objectForKey:@"createdOn"];
    [T0BaseFunction setColoredLabelText:cell.amountLabel Number:[NSString stringWithFormat:@"%@",[data objectForKey:@"amount"]]];
    if ([[data objectForKey:@"status"] isKindOfClass:[NSNull class]])
    {
        cell.statusLabel.text = @"";
        cell.titleConstraint.constant = 0;
    }
    else
    {
        cell.statusLabel.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"status"]];
        cell.titleConstraint.constant = -4;
    }
    
    return cell;
}

@end
