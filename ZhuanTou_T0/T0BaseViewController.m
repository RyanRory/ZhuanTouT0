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
    isLoading = false;
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:NO];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:0.0f];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:@"Refresh" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showError:) name:@"ShowError" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HTTPFail) name:@"HTTPFail" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Refresh" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ShowError" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HTTPFail" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:@"Refresh" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showError:) name:@"ShowError" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HTTPFail) name:@"HTTPFail" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Refresh" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ShowError" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HTTPFail" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma refreshData
- (void)refreshData
{
    
}

#pragma showError
- (void)showError:(NSNotification *)notification
{
    errorView = [[T0ErrorMessageView alloc]init];
    [errorView showInView:self.view withMessage:notification.object byStyle:ERRORMESSAGEERROR];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        isLoading = false;
    });
}

#pragma HTTPFail
- (void)HTTPFail
{
    errorView = [[T0ErrorMessageView alloc]init];
    [errorView showInView:self.view withMessage:@"当前网络状况不佳，请稍后再试" byStyle:ERRORMESSAGEWARNING];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        isLoading = false;
    });
}


@end
