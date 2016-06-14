//
//  T0MessageViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/5.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0MessageViewController.h"

@interface T0MessageViewController ()

@end

@implementation T0MessageViewController

@synthesize tView;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    dataModel = [T0MessageDataModel shareInstance];
    
    tView.mj_header = [T0RefreshHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    
    [self loadNewData];
}

#pragma loadNewData
- (void)loadNewData
{
    isLoading = true;
    [dataModel resetPageIndex];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma refreshData
- (void)refreshData
{
    self.hud.hidden = YES;
    isLoading = false;
    [tView.mj_header endRefreshing];
    cellObjects = [NSArray arrayWithArray:[dataModel getCellObjects]];
    [tView reloadData];
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TableViewDelegate/DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    T0MessageTableViewCell *cell = (T0MessageTableViewCell *)[self tableView: tView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.00000000001;
    }
    return 15;
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
        [tableView tableViewDisplayWitMsg:@"暂无消息" imageName:@"NoStockSource" ifNecessaryForRowCount:cellObjects.count];
    }
    return cellObjects.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id data = cellObjects[indexPath.section];
    T0MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"T0MessageTableViewCell"];
    if (!cell)
    {
        cell = [[T0MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"T0MessageTableViewCell"];
    }
    
    [cell setContentText:[NSString stringWithFormat:@"%@", [data objectForKey:@"content"]]];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"createdOn"]];
    
    return cell;
}

@end
