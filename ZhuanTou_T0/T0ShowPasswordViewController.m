//
//  T0ShowPasswordViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0ShowPasswordViewController.h"

@interface T0ShowPasswordViewController ()

@end

@implementation T0ShowPasswordViewController

@synthesize account, accountLabel, changePasswordButton, passwordTextField, secureEntryButton;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [passwordTextField setSecureTextEntry:YES];
    [passwordTextField setUserInteractionEnabled:NO];
    [passwordTextField setText:@"123456"];
    
    accountLabel.text = account;
    
    secureEntryButton.selected = YES;
    [secureEntryButton addTarget:self action:@selector(isSecureTextEntry:) forControlEvents:UIControlEventTouchUpInside];
    
    [self initButtonAction:changePasswordButton];
    
}

#pragma initButtonAction Function
- (void)initButtonAction:(UIButton*)sender
{
    [sender addTarget:self action:@selector(buttonTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(buttonTouchDownAction:) forControlEvents:UIControlEventTouchDown];
    [sender addTarget:self action:@selector(buttonCancelAction:) forControlEvents:UIControlEventTouchCancel];
    [sender addTarget:self action:@selector(buttonCancelAction:) forControlEvents:UIControlEventTouchDragExit];
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

- (void)buttonTouchUpInsideAction:(UIButton*)sender
{
    sender.backgroundColor = MYSSBUTTONDARK;
    T0InputPasswordViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0InputPasswordViewController"];
    vc.hadAPassword = true;
    vc.account = account;
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

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
