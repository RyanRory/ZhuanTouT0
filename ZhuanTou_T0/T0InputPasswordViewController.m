//
//  T0InputPasswordViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0InputPasswordViewController.h"

@interface T0InputPasswordViewController ()

@end

@implementation T0InputPasswordViewController

@synthesize accountLabel, statusLabel, passwordTextField, hadAPassword, account;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    accountLabel.text = account;
    passwordTextField.delegate = self;
    [passwordTextField becomeFirstResponder];
    [passwordTextField setSecureTextEntry:YES];
    if (hadAPassword)
    {
        statusLabel.text = @"";
        [passwordTextField setPlaceHolderText:@"请输入新的交易密码"];
        [passwordTextField setPlaceHolderChangeText:@"交易密码"];
    }
    else
    {
        statusLabel.text = @"您还未递交您的交易密码，请完成递交。";
        [passwordTextField setPlaceHolderText:@"请输入您的交易密码"];
        [passwordTextField setPlaceHolderChangeText:@"交易密码"];
    }
    
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
    [self.navigationController popViewControllerAnimated:YES];
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
    [self next:nil];
    return YES;
}


@end
