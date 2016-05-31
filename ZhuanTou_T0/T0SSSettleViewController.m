//
//  T0SSSettleViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0SSSettleViewController.h"

@interface T0SSSettleViewController ()

@end

@implementation T0SSSettleViewController

@synthesize finshButton, tView;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [self initButtonAction:finshButton];
    
    tView.scrollEnabled = NO;
    
    cellObjects = [NSMutableArray arrayWithObjects:@"当期总T0收益为XX元，约定分成比例为XX%，因此您将获得XX元收益。", @"请于XXXX年XX月XX日 XX:XX前将XX元银证转账至您的银行卡账户，并将其中的XX元转至本公司指定账户。", @"公司账户信息如下\n开户行：XXX银行\n账户号：6217001210006737121\n开户支行：XXX支行", @"当您完成转账后，请点击页面下方“我已完成转账”按钮，递交处理申请。", nil];
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
    [self.navigationController popViewControllerAnimated:YES];
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
    T0SSSettleTableViewCell *cell = (T0SSSettleTableViewCell*)[self tableView: tView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
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
    NSString* object = cellObjects[indexPath.section];
    T0SSSettleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"T0SSSettleTableViewCell"];
    if (!cell)
    {
        cell = [[T0SSSettleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"T0SSSettleTableViewCell"];
    }
    cell.noLabel.text = [NSString stringWithFormat:@"%ld .", indexPath.section+1];
    [cell setContentText:object];
    
    return cell;
}

@end
