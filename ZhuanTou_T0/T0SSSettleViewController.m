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

@synthesize finshButton, tView, orderNo;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [self initButtonAction:finshButton];
    
    tView.scrollEnabled = NO;
    
    dataModel = [T0SettleViewDataModel shareInstance];
    [dataModel getDataFromServer:orderNo];
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
    self.hud.hidden = YES;
    cellObjects = [NSArray arrayWithArray:[dataModel getCellObjects]];
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
    if (!isLoading)
    {
        self.hud.hidden = NO;
        isLoading = true;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"/api/intraday/confirmWithdraw/%@",orderNo]];
        [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
            NSLog(@"%@", responseObject);
            self.hud.hidden = YES;
            if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
            {
                isLoading = false;
                [self.navigationController popViewControllerAnimated:YES];
                errorView = [[T0ErrorMessageView alloc]init];
                [errorView showInView:self.navigationController.view withMessage:@"工作人员将尽快核对金额" byStyle:ERRORMESSAGESUCCESS];
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
