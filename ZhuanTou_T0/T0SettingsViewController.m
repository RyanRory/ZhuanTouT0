//
//  T0SettingsViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/5.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0SettingsViewController.h"

@interface T0SettingsViewController ()

@end

@implementation T0SettingsViewController

@synthesize tView;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    cellObjects = [NSArray arrayWithObjects:@"实名认证", @"登录密码", @"QQ联系", @"客服热线", @"意见反馈", @"退出登录", nil];
    
    tView.scrollEnabled = NO;
    
    dataModel = [T0SettingsDataModel shareInstance];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [tView reloadData];
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

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TableViewDelegate/DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == cellObjects.count-1)
    {
        return 40;
    }
    if (section == 2)
    {
        return 15;
    }
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
    NSString *data = cellObjects[indexPath.section];
    T0SettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"T0SettingsTableViewCell"];
    if (!cell)
    {
        cell = [[T0SettingsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"T0SettingsTableViewCell"];
    }
    cell.titleLabel.text = data;
    switch (indexPath.section) {
        case 0:
            if ([dataModel getIsRealNameSet])
            {
                cell.constraint.priority = 999;
                cell.rightImageView.image = [UIImage imageNamed:@""];
                cell.contentLabel.text = @"已认证";
            }
            else
            {
                cell.rightImageView.image = [UIImage imageNamed:@"NextArrow"];
                cell.contentLabel.text = @"去认证";
            }
            break;
            
        case 1:
            cell.rightImageView.image = [UIImage imageNamed:@"NextArrow"];
            cell.contentLabel.text = @"修改";
            break;
            
        case 2:
            cell.rightImageView.image = [UIImage imageNamed:@"QQLogo"];
            cell.contentLabel.text = @"";
            break;
            
        case 3:
            cell.rightImageView.image = [UIImage imageNamed:@"PhoneLogo"];
            cell.contentLabel.text = @"";
            break;
            
        case 4:
            cell.rightImageView.image = [UIImage imageNamed:@"NextArrow"];
            cell.contentLabel.text = @"";
            break;
            
        case 5:
            cell.rightImageView.image = [UIImage imageNamed:@""];
            cell.contentLabel.text = @"";
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            if (![dataModel getIsRealNameSet])
            {
                T0RealNameViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0RealNameViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        }
            
        case 1:
        {
            T0ChangeLoginPasswordViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0ChangeLoginPasswordViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 2:
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
            {
                UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
                NSURL *url = [NSURL URLWithString:@"mqq://im/chat?chat_type=wpa&uin=362236128&version=1&src_type=web"];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                webView.delegate = self;
                [webView loadRequest:request];
                [self.view addSubview:webView];
            }
            else
            {
                errorView = [[T0ErrorMessageView alloc]init];
                [errorView showInView:self.navigationController.view withMessage:@"请先安装手机QQ" byStyle:ERRORMESSAGEWARNING];
            }
            break;
        }
            
        case 3:
        {
            LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:nil message:@"工作时间：9:00 ~ 19:00" style:LGAlertViewStyleActionSheet buttonTitles:@[@"呼叫  400-698-9861"] cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index){[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4006989861"]];} cancelHandler:nil destructiveHandler:nil];
            alertView.backgroundColor = MYSSBUTTONDARK;
            alertView.buttonsTitleColor = [UIColor whiteColor];
            alertView.buttonsBackgroundColorHighlighted = MYSSBUTTONBLUE;
            alertView.buttonsFont = [UIFont systemFontOfSize:15.0];
            alertView.messageTextColor = [UIColor colorWithWhite:1.0 alpha:0.7];
            alertView.cancelButtonTitleColor = [UIColor whiteColor];
            alertView.cancelButtonFont = [UIFont systemFontOfSize:15.0];
            alertView.cancelButtonBackgroundColorHighlighted = MYSSBUTTONBLUE;
            alertView.separatorsColor = self.view.backgroundColor;
            [alertView showAnimated:YES completionHandler:nil];
            break;
        }
            
        case 4:
        {
            T0FeedbackViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0FeedbackViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 5:
        {
            LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:nil message:@"是否确认安全退出当前账户?" style:LGAlertViewStyleAlert buttonTitles:@[@"确定"] cancelButtonTitle:@"取消" destructiveButtonTitle:nil actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index){
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/auth/signOut"]];
                [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                    NSLog(@"%@", responseObject);
                    if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
                    {
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:MOBILE];
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:PASSWORD];
                        T0NavigationController *nav = (T0NavigationController*)[self.navigationController presentedViewController];
                        [nav popToRootViewControllerAnimated:NO];
                        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                    }
                    else
                    {
                        
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
            break;
        }
            
        default:
            break;
    }
}

@end
