//
//  T0ResetPswdViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/6.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0ResetPswdViewController.h"

@interface T0ResetPswdViewController ()

@end

@implementation T0ResetPswdViewController

@synthesize passwordTextField, passwordContentLabel, passwordSecureEntryButton;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [passwordTextField setPlaceHolderText:@"请输入新的登录密码"];
    [passwordTextField setPlaceHolderChangeText:@"登录密码"];
    [passwordTextField setSecureTextEntry:YES];
    passwordTextField.delegate = self;
    
    passwordSecureEntryButton.selected = YES;
    passwordSecureEntryButton.tag = 0;
    [passwordSecureEntryButton addTarget:self action:@selector(isSecureTextEntry:) forControlEvents:UIControlEventTouchUpInside];
    
    dataModel = [T0LoginDataModel shareInstance];
    
    self.hud.hidden = YES;
    
    [passwordTextField becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    T0NavigationController *nav = (T0NavigationController*)self.navigationController;
    [nav setPageOfPageControl:1];
    [passwordTextField becomeFirstResponder];
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma SecureEntryButtonAction
- (void)isSecureTextEntry:(UIButton*)sender
{
    sender.selected = !sender.selected;
    [passwordTextField setSecureTextEntry:sender.selected];
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

#pragma Navigation Function
- (void)initNavigationBar
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    leftItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(next:)];
    rightItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, item, nil];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem, item, nil];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName,nil] forState:UIControlStateNormal];
}

- (void)next:(id)sender
{
    if (!isLoading)
    {
        if ([passwordTextField getTextFieldStr].length == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请设置新的登录密码" byStyle:ERRORMESSAGEERROR];
        }
        else
        {
            isLoading = true;
            self.hud.hidden = NO;
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"/api/auth/resetPassword"]];
            NSDictionary *parameters = @{@"password":[passwordTextField getTextFieldStr],
                                         @"smsCode":[dataModel getSmsCode]};
            [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                NSLog(@"%@", responseObject);
                self.hud.hidden = YES;
                if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
                {
                    isLoading = false;
                    errorView = [[T0ErrorMessageView alloc]init];
                    [errorView showInView:self.navigationController.view withMessage:@"密码设置成功" byStyle:ERRORMESSAGESUCCESS];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [passwordTextField becomeFirstResponder];
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

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [passwordTextField becomeFirstResponder];
}

#pragma TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //返回一个BOOL值，指明是否允许在按下回车键时结束编辑
    //如果允许要调用resignFirstResponder 方法，这回导致结束编辑，而键盘会被收起
    [self next:nil];
    return YES;
}

@end
