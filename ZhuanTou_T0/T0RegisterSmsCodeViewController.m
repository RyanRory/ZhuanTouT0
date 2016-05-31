//
//  T0RegisterSmsCodeViewController.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/18.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0RegisterSmsCodeViewController.h"

@interface T0RegisterSmsCodeViewController ()

@end

@implementation T0RegisterSmsCodeViewController

@synthesize smsCodeTextField, descriptionLabel, errorLabel, smsCodeButton;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [smsCodeTextField setPlaceHolderText:@"请输入您收到的验证码"];
    [smsCodeTextField setPlaceHolderChangeText:@"验证码"];
    smsCodeTextField.delegate = self;
    
    [smsCodeButton addTarget:self action:@selector(clickSmsCode:) forControlEvents:UIControlEventTouchUpInside];
    
    dataModel = [T0RegisterDataModel shareInstance];
    NSLog(@"%@",[dataModel getMobile]);
    
    self.errorLabel.alpha = 0;
    //进入页面自动发送验证码
    [self sendSmsCode:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [smsCodeTextField becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    T0NavigationController *nav = (T0NavigationController*)self.navigationController;
    [nav setPageOfPageControl:1];
}

#pragma timer事件
- (void)timeFireMethod
{
    secondsCountDown--;
    if (secondsCountDown == 0)
    {
        smsCodeButton.titleLabel.text = @"语音验证码";
        [smsCodeButton setTitle:@"语音验证码" forState:UIControlStateNormal];
        [smsCodeButton setUserInteractionEnabled:YES];
        [timer invalidate];
    }
    else
    {
        smsCodeButton.titleLabel.text = [NSString stringWithFormat:@"%ds",secondsCountDown];
        [smsCodeButton setTitle:[NSString stringWithFormat:@"%ds",secondsCountDown] forState:UIControlStateNormal];
    }
}

#pragma SmsCodeButtonAction
- (void)clickSmsCode:(id)button
{
    [self sendSmsCode:YES];
}

- (void)sendSmsCode:(BOOL)flag
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/auth/sendRegisterSmsCode/%@/%@?vCode=%@", [dataModel getMobile], [T0BaseFunction boolToString:flag], [dataModel getVCode]]];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@", responseObject);
        if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
        {
            secondsCountDown = 60;
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
            [smsCodeButton setUserInteractionEnabled:NO];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Navigation Function
- (void)initNavigationBar
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    leftItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(next:)];
    rightItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, item, nil];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem, item, nil];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13], NSFontAttributeName,nil] forState:UIControlStateNormal];
}

- (void)next:(id)sender
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"/api/auth/checkRegisterSmsCode/%@/%@", [dataModel getMobile], [T0BaseFunction deleteSpacesForString:[smsCodeTextField getTextFieldStr]]]];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@", responseObject);
        if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
        {
            [dataModel setSmsCode:[smsCodeTextField getTextFieldStr]];
            T0RegisterPasswordViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0RegisterPasswordViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            errorLabel.text = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"errorMessage"]];
            errorLabel.textColor = ERRORRED;
            [T0Animator transopacityAnimation:self.errorLabel fromValue:0 toValue:1 duration:0.2f];
            [T0Animator transpositionAnimation:self.descriptionLabel toPoint:CGPointMake(0, 24) duration:0.2f];
            [T0Animator shakeView:self.smsCodeTextField.textInputView];
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //返回一个BOOL值，指明是否允许在按下回车键时结束编辑
    //如果允许要调用resignFirstResponder 方法，这回导致结束编辑，而键盘会被收起
    [self next:nil];
    return YES;
}

@end
