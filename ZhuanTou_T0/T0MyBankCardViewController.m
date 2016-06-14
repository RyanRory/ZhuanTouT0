//
//  T0MyBankCardViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/23.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0MyBankCardViewController.h"

@interface T0MyBankCardViewController ()

@end

@implementation T0MyBankCardViewController

@synthesize titleLabel, tView, functionButton, drawContentLabel;
@synthesize style;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    dataModel = [T0BankCardDataModel shareInstance];
    
    functionButton.tag = 0;
    [self initButtonAction:functionButton];
    
    editing = false;
    isLoading = true;
    
    deleteIndex = [[NSMutableArray alloc]init];
    deleteIds = [[NSMutableArray alloc]init];
    deleteBankCards = [[NSMutableArray alloc]init];
    
    if ([style isEqualToString:MYBANKCARD])
    {
        titleLabel.text = @"我的银行卡";
        drawContentLabel.hidden = YES;
    }
    
    else
    {
        titleLabel.text = @"选择银行卡";
        drawContentLabel.hidden = NO;
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isLoading = true;
    [dataModel getDataFromServer];
}

#pragma Navigation Function
- (void)initNavigationBar
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    leftItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15], NSFontAttributeName,nil] forState:UIControlStateNormal];

    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, item, nil];
}

- (void)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)chooseDelete:(UIBarButtonItem*)sender
{
    if (!editing)
    {
        [sender setTitle:@"取消"];
        [sender setImage:[UIImage imageNamed:@""]];
        for (int i = 0; i < cellObjects.count; i++)
        {
            T0BankCardTableViewCell *cell = (T0BankCardTableViewCell *)[tView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            [T0Animator transpositionAnimation:cell.bankCardView toPoint:CGPointMake(20, 0) duration:0.2];
            [T0Animator transopacityAnimation:cell.chooseView fromValue:0 toValue:1 duration:0.2];
        }
        editing = true;
        [functionButton setTitle:@"解除绑定" forState:UIControlStateNormal];
        [functionButton setBackgroundColor:MYSSRED];
        functionButton.tag = 1;
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"DeleteBankCard"]];
        [sender setTitle:@""];
        for (int i = 0; i < cellObjects.count; i++)
        {
            T0BankCardTableViewCell *cell = (T0BankCardTableViewCell *)[tView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            [T0Animator transpositionAnimation:cell.bankCardView toPoint:CGPointMake(0, 0) duration:0.2];
            [T0Animator transopacityAnimation:cell.chooseView fromValue:1 toValue:0 duration:0.2];
            cell.chooseView.backgroundColor = [UIColor clearColor];
            [cell.chooseView.layer setBorderWidth:1];
        }
        editing = false;
        [functionButton setTitle:@"添加银行卡" forState:UIControlStateNormal];
        [functionButton setBackgroundColor:MYSSBUTTONDARK];
        functionButton.tag = 0;
        
        [deleteIndex removeAllObjects];
        [deleteIds removeAllObjects];
        [deleteBankCards removeAllObjects];
    }
    
}

#pragma refreshData
- (void)refreshData
{
    self.hud.hidden = YES;
    isLoading = false;
    cellObjects = [NSMutableArray arrayWithArray:[dataModel getCellObjects]];
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
    if (sender.tag == 0)
    {
        sender.backgroundColor = MYSSBUTTONDARK;
        settingsDataModel = [T0SettingsDataModel shareInstance];
        if ([settingsDataModel getIsRealNameSet])
        {
            T0AddBankCardViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0AddBankCardViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:nil message:@"请先进行实名认证" style:LGAlertViewStyleAlert buttonTitles:@[@"去认证"] cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index){
                T0RealNameViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0RealNameViewController"];
                [self.navigationController pushViewController:vc animated:YES];
                
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
    }
    else
    {
        sender.backgroundColor = MYSSRED;
        if (deleteIds.count == 0)
        {
            [self chooseDelete:self.navigationItem.rightBarButtonItem];
        }
        else
        {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/account/removeBankCards"]];
            NSDictionary *parameters = @{@"bankCardIds":deleteIds};
            [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                NSLog(@"%@", responseObject);
                if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
                {
                    [deleteIds removeAllObjects];
                    [cellObjects removeObjectsInArray:deleteBankCards];
                    [deleteBankCards removeAllObjects];
                    [tView deleteRowsAtIndexPaths:deleteIndex withRowAnimation:UITableViewRowAnimationFade];
                    [deleteIndex removeAllObjects];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self chooseDelete:self.navigationItem.rightBarButtonItem];
                    });
                }
                else
                {
                    errorView = [[T0ErrorMessageView alloc]init];
                    [errorView showInView:self.navigationController.view withMessage:[NSString stringWithFormat:@"%@", [responseObject objectForKey:@"errorMessage"]] byStyle:ERRORMESSAGEERROR];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"HTTPFail" object:nil];
            }];
        }
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
    return (SCREEN_WIDTH-40)/283*157+16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([style isEqualToString:DRAW])
    {
        return 18;
    }
    return 0.00000000000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00000000000001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!isLoading)
    {
        [tableView tableViewDisplayWitMsg:@"暂无银行卡" imageName:@"NoBankCard" ifNecessaryForRowCount:cellObjects.count];
    }
    if (cellObjects.count == 0)
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    else
    {
        if (!self.navigationItem.rightBarButtonItem)
        {
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"DeleteBankCard"] style:UIBarButtonItemStylePlain target:self action:@selector(chooseDelete:)];
            rightItem.tintColor = [UIColor whiteColor];
            self.navigationItem.rightBarButtonItem = rightItem;
        }

    }
    return cellObjects.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id data = cellObjects[indexPath.row];
    T0BankCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"T0BankCardTableViewCell"];
    if (!cell)
    {
        cell = [[T0BankCardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"T0BankCardTableViewCell"];
    }
    cell.bankNameLabel.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"bankName"]];
    cell.cardNumLabel.text = [T0BaseFunction addSpacesForString:[NSString stringWithFormat:@"%@",[data objectForKey:@"cardCodeDisplay"]]];
    cell.branchNameLabel.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"subBankName"]];
    [cell.logoImageView sd_setImageWithURL:[NSURL URLWithString:[BASEURL stringByAppendingString:[NSString stringWithFormat: @"content/images/banks/%@.png", [data objectForKey:@"bankCode"]]]]];
    cell.chooseView.alpha = 0;
    cell.chooseView.backgroundColor = [UIColor clearColor];
    [cell.chooseView.layer setBorderWidth:1];
    [T0Animator transpositionAnimation:cell.bankCardView toPoint:CGPointMake(0, 0) duration:0];
    
    if (editing)
    {
        [T0Animator transpositionAnimation:cell.bankCardView toPoint:CGPointMake(20, 0) duration:0];
        cell.chooseView.alpha = 1;
        if ([deleteIndex indexOfObject:indexPath] != NSNotFound)
        {
            cell.chooseView.backgroundColor = MYSSRED;
            [cell.chooseView.layer setBorderWidth:0];
        }
    }
    else
    {
        cell.chooseView.alpha = 0;
        [T0Animator transpositionAnimation:cell.bankCardView toPoint:CGPointMake(0, 0) duration:0];
        if ([deleteIndex indexOfObject:indexPath] == NSNotFound)
        {
            cell.chooseView.backgroundColor = [UIColor clearColor];
            [cell.chooseView.layer setBorderWidth:1];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (editing)
    {
        T0BankCardTableViewCell *cell = (T0BankCardTableViewCell *)[tView cellForRowAtIndexPath:indexPath];
        if (cell.chooseView.backgroundColor == [UIColor clearColor])
        {
            cell.chooseView.backgroundColor = MYSSRED;
            [cell.chooseView.layer setBorderWidth:0];
            [deleteIndex addObject:indexPath];
            [deleteIds addObject:[cellObjects[indexPath.row] objectForKey:@"id"]];
            [deleteBankCards addObject:cellObjects[indexPath.row]];
        }
        else
        {
            cell.chooseView.backgroundColor = [UIColor clearColor];
            [cell.chooseView.layer setBorderWidth:1];
            [deleteIndex removeObject:indexPath];
            [deleteIds removeObject:[cellObjects[indexPath.row] objectForKey:@"id"]];
            [deleteBankCards removeObject:cellObjects[indexPath.row]];
        }
    }
    else
    {
        if ([style isEqualToString:DRAW])
        {
            T0DrawViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0DrawViewController"];
            vc.data = @{@"fundsAvailable":[[dataModel getData] objectForKey:@"fundsAvailable"],
                        @"bankCard":[cellObjects objectAtIndex:indexPath.row]};
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


@end
