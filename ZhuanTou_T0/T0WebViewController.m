//
//  T0WebViewController.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/5/5.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0WebViewController.h"

@interface T0WebViewController ()

@end

@implementation T0WebViewController

@synthesize titleLabel, reloadButton, webView;
@synthesize url;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [reloadButton addTarget:self action:@selector(reloadWebView:) forControlEvents:UIControlEventTouchUpInside];
    
    reloadButton.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadWebView];
    T0NavigationController *nav = (T0NavigationController*)self.navigationController;
    [nav dismissPageControl];
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

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma loadWeb Function
- (void)loadWebView
{
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [webView loadRequest:request];
}

- (void)reloadWebView:(id)sender
{
    [self loadWebView];
}

- (void)webViewStopLaoding
{
    [webView stopLoading];
}

#pragma WebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    reloadButton.hidden = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    reloadButton.hidden = NO;

}


@end
