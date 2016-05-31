//
//  T0StockSourceCompleteViewController.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/26.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0StockSourceCompleteViewController.h"

@interface T0StockSourceCompleteViewController ()

@end

@implementation T0StockSourceCompleteViewController

@synthesize checkScheduleButton;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [checkScheduleButton addTarget:self action:@selector(checkSchedule:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Navigation Function
- (void)initNavigationBar
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"CancelCross"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    leftItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, item, nil];
}
- (void)cancel:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma ButtonAction
- (void)checkSchedule:(id)sender
{
    T0MySSViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0MySSViewController"];
    vc.style = self.style;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
