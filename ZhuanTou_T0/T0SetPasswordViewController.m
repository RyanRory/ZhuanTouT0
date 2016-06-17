//
//  T0SetPasswordViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/5.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0SetPasswordViewController.h"

@interface T0SetPasswordViewController ()

@end

@implementation T0SetPasswordViewController

@synthesize accountLabel, account, tradePswdTextField, communicationPswdTExtField, stockAccountId;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    if ([[account objectForKey:@"accountNumber"] isKindOfClass:[NSNull class]])
    {
        accountLabel.text = @"资金账户(暂未登记)";
    }
    else
    {
        accountLabel.text = [NSString stringWithFormat:@"资金账户%@", [account objectForKey:@"accountNumber"]];
    }
    
    tradePswdTextField.delegate = self;
    [tradePswdTextField setPlaceHolderText:@"请输入您的交易密码"];
    [tradePswdTextField setPlaceHolderChangeText:@"交易密码"];
    [tradePswdTextField setSecureTextEntry:YES];
    
    communicationPswdTExtField.delegate = self;
    [communicationPswdTExtField setPlaceHolderText:@"请输入您的通讯密码"];
    [communicationPswdTExtField setPlaceHolderChangeText:@"通讯密码"];
    [communicationPswdTExtField setSecureTextEntry:YES];
    
    [tradePswdTextField becomeFirstResponder];
    
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
        if ([tradePswdTextField getTextFieldStr].length == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请输入交易密码" byStyle:ERRORMESSAGEERROR];
        }
        else
        {
            isLoading = true;
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/intraday/updateStockAccount"]];
            NSDictionary *parameters = @{@"stockAccountId":[account objectForKey:@"stockAccountId"],
                                         @"tradePassword":[tradePswdTextField getTextFieldStr],
                                         @"commPassword":[communicationPswdTExtField getTextFieldStr]};
            
            [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                NSLog(@"%@", responseObject);
                if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
                {
                    errorView = [[T0ErrorMessageView alloc]init];
                    [errorView showInView:self.navigationController.view withMessage:@"递交密码成功" byStyle:ERRORMESSAGESUCCESS];
                    [self.navigationController popViewControllerAnimated:YES];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        isLoading = false;
                    });
                }
                else
                {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowError" object:[responseObject objectForKey:@"errorMessage"]];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"HTTPFail" object:nil];
            }];
        }
    }
}

- (void)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //返回一个BOOL值，指明是否允许在按下回车键时结束编辑
    //如果允许要调用resignFirstResponder 方法，这回导致结束编辑，而键盘会被收起
    if (textField == tradePswdTextField)
    {
        [tradePswdTextField resignFirstResponder];
        [communicationPswdTExtField becomeFirstResponder];
    }
    else
    {
        [self next:nil];
    }
    return YES;
}

@end
