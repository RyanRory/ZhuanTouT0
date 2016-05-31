//
//  T0LaunchViewController.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/5/6.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0LaunchViewController.h"

@interface T0LaunchViewController ()

@end

@implementation T0LaunchViewController

@synthesize toLoginButton, toRegisterButton;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [toLoginButton addTarget:self action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
    [toRegisterButton addTarget:self action:@selector(toRegister:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    T0NavigationController *nav = (T0NavigationController*)self.navigationController;
    [nav dismissPageControl];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Button Function
- (void)toLogin:(id)sender
{
    T0NavigationController *nav = [[self storyboard]instantiateViewControllerWithIdentifier:@"LoginNav"];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)toRegister:(id)sender
{
    T0NavigationController *nav = [[self storyboard]instantiateViewControllerWithIdentifier:@"RegisterNav"];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
