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

@synthesize toLoginButton, toRegisterButton, bgImageView;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [toLoginButton addTarget:self action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
    [toRegisterButton addTarget:self action:@selector(toRegister:) forControlEvents:UIControlEventTouchUpInside];
    toLoginButton.hidden = YES;
    toRegisterButton.hidden = YES;
    
    isLaunch = true;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL = [BASEURL stringByAppendingString:@"api/auth/checkLogin"];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@", responseObject);
        if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isAuthenticated"]].boolValue)
        {
            settingsDataModel = [T0SettingsDataModel shareInstance];
            if ([[responseObject objectForKey:@"fullName"] isKindOfClass:[NSNull class]])
            {
                [settingsDataModel setIsRealNameSet:false];
                [settingsDataModel setRealName:@""];
            }
            else
            {
                [settingsDataModel setIsRealNameSet:true];
                [settingsDataModel setRealName:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"fullName"]]];
            }
            
            homePageDataModel = [T0HomePageDataModel shareInstance];
            [homePageDataModel setData:[responseObject objectForKey:@"todoEvents"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self showHomePage];
            });
        }
        else
        {
            toLoginButton.hidden = NO;
            toRegisterButton.hidden = NO;
            bgImageView.image = [UIImage imageNamed:@"LoginImage"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        toLoginButton.hidden = NO;
        toRegisterButton.hidden = NO;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HTTPFail" object:nil];
    }];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showHomePage) name:@"ShowHomePage" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!isLaunch)
    {
        toLoginButton.hidden = NO;
        toRegisterButton.hidden = NO;
        bgImageView.image = [UIImage imageNamed:@"LoginImage"];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    isLaunch = false;
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

#pragma showHomePage
- (void)showHomePage
{
    T0NavigationController *nav = [[self storyboard]instantiateViewControllerWithIdentifier:@"MainNav"];
    [nav setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
