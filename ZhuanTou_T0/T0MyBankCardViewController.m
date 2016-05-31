//
//  T0MyBankCardViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/23.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0MyBankCardViewController.h"

@interface T0MyBankCardViewController ()

@end

@implementation T0MyBankCardViewController

@synthesize bankIconImageView, bankNameLabel, cardNumLabel, drawableNumLabel, branchLabel, drawButton;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [drawButton addTarget:self action:@selector(toDraw:) forControlEvents:UIControlEventTouchUpInside];
    
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

#pragma refreshData
- (void)refreshData
{
    
}

#pragma ServerError
- (void)showError
{
    
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma buttonAction
- (void)toDraw:(id)sender
{
    
}

@end
