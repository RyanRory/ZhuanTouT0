//
//  T0ChangeLoginPasswordViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/7.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0ChangeLoginPasswordViewController.h"

@interface T0ChangeLoginPasswordViewController ()

@end

@implementation T0ChangeLoginPasswordViewController

@synthesize oldPswdTextField, oldPswdSecureEntryButton, neoPswdTextField, neoPswdSecureEntryButton;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    oldPswdTextField.delegate = self;
    [oldPswdTextField setSecureTextEntry:YES];
    [oldPswdTextField setPlaceHolderText:@"请输入原登录密码"];
    [oldPswdTextField setPlaceHolderChangeText:@"原登录密码"];
    
    neoPswdTextField.delegate = self;
    [neoPswdTextField setSecureTextEntry:YES];
    [neoPswdTextField setPlaceHolderText:@"请设置新的登录密码"];
    [neoPswdTextField setPlaceHolderChangeText:@"新登录密码"];
    
    [oldPswdTextField becomeFirstResponder];
    
    oldPswdSecureEntryButton.selected = YES;
    oldPswdSecureEntryButton.tag = 0;
    [oldPswdSecureEntryButton addTarget:self action:@selector(isSecureTextEntry:) forControlEvents:UIControlEventTouchUpInside];
    
    neoPswdSecureEntryButton.selected = YES;
    neoPswdSecureEntryButton.tag = 1;
    [neoPswdSecureEntryButton addTarget:self action:@selector(isSecureTextEntry:) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud.hidden = YES;
    
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
        if ([oldPswdTextField getTextFieldStr].length == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请输入原登录密码" byStyle:ERRORMESSAGEERROR];
        }
        else if ([neoPswdTextField getTextFieldStr].length == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请设置新登录密码" byStyle:ERRORMESSAGEERROR];
        }
        else
        {
            self.hud.hidden = NO;
            isLoading = true;
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSString *URL = [BASEURL stringByAppendingString:@"api/auth/changePassword"];
            NSDictionary *parameters = @{@"password":[oldPswdTextField getTextFieldStr],
                                         @"newPassword":[neoPswdTextField getTextFieldStr]};
            [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                NSLog(@"%@", responseObject);
                self.hud.hidden = YES;
                if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
                {
                    [[NSUserDefaults standardUserDefaults] setObject:[neoPswdTextField getTextFieldStr] forKey:PASSWORD];
                    errorView = [[T0ErrorMessageView alloc]init];
                    [errorView showInView:self.navigationController.view withMessage:@"修改登录密码成功" byStyle:ERRORMESSAGESUCCESS];
                    [oldPswdTextField resignFirstResponder];
                    [neoPswdTextField resignFirstResponder];
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
                self.hud.hidden = YES;
                [[NSNotificationCenter defaultCenter]postNotificationName:@"HTTPFail" object:nil];
            }];
        }
    }
}

- (void)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma SecureEntryButtonAction
- (void)isSecureTextEntry:(UIButton*)sender
{
    sender.selected = !sender.selected;
    if (sender.tag == 0)
    {
        [oldPswdTextField setSecureTextEntry:sender.selected];
    }
    else
    {
        [neoPswdTextField setSecureTextEntry:sender.selected];
    }
    //实现textfield安全输入和正常输入的文字转换
    if (sender.selected)
    {
        [sender setImage:[UIImage imageNamed:@"EyeClose"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"EyeOpen"] forState:UIControlStateNormal];
    }
}

#pragma TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == oldPswdTextField)
    {
        [oldPswdTextField resignFirstResponder];
        [neoPswdTextField becomeFirstResponder];
    }
    else
    {
        [self next:nil];
    }
    return YES;
}

@end
