//
//  T0NavigationController.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/18.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0NavigationController.h"

@interface T0NavigationController ()

@end

@implementation T0NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"TransparentBackground"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage imageNamed:@"TransparentBackground"]];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.navigationBar.bounds.size.width/2-50, self.navigationBar.bounds.size.height/2-8, 100, 10)];
    [self.navigationBar addSubview:self.pageControl];
    self.pageControl.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showPageControl:(int)number
{
    [self.pageControl setNumberOfPages:number];
    [self.pageControl setCurrentPage:0];
    self.pageControl.hidden = NO;
}

- (void)dismissPageControl
{
    self.pageControl.hidden = YES;
}

- (void)setPageOfPageControl:(int)page
{
    [self.pageControl setCurrentPage:page];
}


@end
