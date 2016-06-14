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

@synthesize account, accountLabel, tradePswdTextField, tradePswdSecureEntryButton, changeTradePswdButton, communicationPswdTextField, communicationPswdStatusLabel, communicationPswdSecureEntryButton, changeCommunicationPswdButton;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    if ([[account objectForKey:@"accountNumber"] isKindOfClass:[NSNull class]])
    {
        accountLabel.text = @"账户号(暂未登记)";
    }
    else
    {
        accountLabel.text = [NSString stringWithFormat:@"账户号%@", [account objectForKey:@"accountNumber"]];
    }
    
    [tradePswdTextField setSecureTextEntry:YES];
    [tradePswdTextField setText:[NSString stringWithFormat:@"%@",[account objectForKey:@"tradePassword"]]];
    [tradePswdTextField setUserInteractionEnabled:NO];
    
    if ([[account objectForKey:@"commPassword"] isKindOfClass:[NSNull class]])
    {
        communicationPswdStatusLabel.text = @"您当前的通讯密码暂未设置";
        communicationPswdSecureEntryButton.hidden = YES;
    }
    else
    {
        communicationPswdStatusLabel.text = @"您当前的通讯密码为";
        communicationPswdSecureEntryButton.hidden = NO;
        [communicationPswdTextField setText:[NSString stringWithFormat:@"%@",[account objectForKey:@"commPassword"]]];
        
    }
    [communicationPswdTextField setSecureTextEntry:YES];
    [communicationPswdTextField setUserInteractionEnabled:NO];
    
    tradePswdSecureEntryButton.tag = 0;
    communicationPswdSecureEntryButton.tag = 1;
    tradePswdSecureEntryButton.selected = YES;
    communicationPswdSecureEntryButton.selected = YES;
    [tradePswdSecureEntryButton addTarget:self action:@selector(isSecureTextEntry:) forControlEvents:UIControlEventTouchUpInside];
    [communicationPswdSecureEntryButton addTarget:self action:@selector(isSecureTextEntry:) forControlEvents:UIControlEventTouchUpInside];
    
    changeTradePswdButton.tag = 0;
    changeCommunicationPswdButton.tag = 1;
    [self initButtonAction:changeTradePswdButton];
    [self initButtonAction:changeCommunicationPswdButton];
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
    if (sender.tag == 0)
    {
        T0InputPasswordViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0InputPasswordViewController"];
        vc.style = 0;
        vc.account = account;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        T0InputPasswordViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0InputPasswordViewController"];
        if (communicationPswdSecureEntryButton.hidden)
        {
            vc.style = 1;
        }
        else
        {
            vc.style = 2;
        }
        vc.account = account;
        [self.navigationController pushViewController:vc animated:YES];
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

#pragma SecureEntryButtonAction
- (void)isSecureTextEntry:(UIButton*)sender
{
    sender.selected = !sender.selected;
    //实现textfield安全输入和正常输入的文字转换
    if (sender.tag == 0)
    {
        [tradePswdTextField setSecureTextEntry:sender.selected];
    }
    else
    {
        [communicationPswdTextField setSecureTextEntry:sender.selected];
    }
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
