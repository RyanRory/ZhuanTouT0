//
//  T0BaseViewController.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/18.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseViewController.h"

@interface T0BaseViewController ()

@end

@implementation T0BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:NO];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:@"Refresh" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showError) name:@"ShowError" object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Refresh" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ShowError" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:@"Refresh" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showError) name:@"ShowError" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Refresh" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ShowError" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma refreshData
- (void)refreshData
{
    
}

#pragma ServerError
- (void)showError
{
    
}


@end
