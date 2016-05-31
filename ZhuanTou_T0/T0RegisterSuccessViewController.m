//
//  T0RegisterSuccessViewController.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/20.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0RegisterSuccessViewController.h"

@interface T0RegisterSuccessViewController ()

@end

@implementation T0RegisterSuccessViewController

@synthesize toDiscoverButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [toDiscoverButton addTarget:self action:@selector(toDiscover:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavigationBar
{
    T0NavigationController *nav = (T0NavigationController*)self.navigationController;
    [nav dismissPageControl];
    [self.navigationItem setHidesBackButton:YES];
}

- (void)toDiscover:(id)sender
{
    T0NavigationController *nav = [[self storyboard]instantiateViewControllerWithIdentifier:@"MainNav"];
    [nav setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self.navigationController presentViewController:nav animated:NO completion:nil];
}


@end
