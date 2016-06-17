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
    [smsCodeTextField becomeFirstResponder];
    
    [smsCodeButton addTarget:self action:@selector(clickSmsCode:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.style isEqualToString:REGISTER])
    {
        dataModel = [T0RegisterDataModel shareInstance];
    }
    else
    {
        loginDataModel = [T0LoginDataModel shareInstance];
    }
    
    self.errorLabel.alpha = 0;
    //进入页面自动发送验证码
    [self sendSmsCode:NO];
    
    self.hud.hidden = YES;
    
    [smsCodeTextField becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    T0NavigationController *nav = (T0NavigationController*)self.navigationController;
    if ([self.style isEqualToString:REGISTER])
    {
        [nav setPageOfPageControl:1];
    }
    else
    {
        [nav showPageControl:2];
    }
    [smsCodeTextField becomeFirstResponder];
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
    if ([self.style isEqualToString:REGISTER])
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
                [smsCodeButton setTitle:@"60s" forState:UIControlStateNormal];
                errorView = [[T0ErrorMessageView alloc]init];
                [errorView showInView:self.navigationController.view withMessage:@"验证码已发送" byStyle:ERRORMESSAGESUCCESS];
            }
            else
            {
                errorView = [[T0ErrorMessageView alloc]init];
                [errorView showInView:self.navigationController.view withMessage:[NSString stringWithFormat:@"%@", [responseObject objectForKey:@"errorMessage"]] byStyle:ERRORMESSAGEWARNING];
                [smsCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"HTTPFail" object:nil];
        }];
    }
    else
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/auth/sendForgetSms/%@/%@?vCode=%@", [loginDataModel getMobile], [T0BaseFunction boolToString:flag], [loginDataModel getVCode]]];
        [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
            NSLog(@"%@", responseObject);
            if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
            {
                secondsCountDown = 60;
                timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
                [smsCodeButton setUserInteractionEnabled:NO];
                [smsCodeButton setTitle:@"60s" forState:UIControlStateNormal];
                errorView = [[T0ErrorMessageView alloc]init];
                [errorView showInView:self.navigationController.view withMessage:@"验证码已发送" byStyle:ERRORMESSAGESUCCESS];
            }
            else
            {
                errorView = [[T0ErrorMessageView alloc]init];
                [errorView showInView:self.navigationController.view withMessage:[NSString stringWithFormat:@"%@", [responseObject objectForKey:@"errorMessage"]] byStyle:ERRORMESSAGEWARNING];
                [smsCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"HTTPFail" object:nil];
            [smsCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        }];
    }
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Navigation Function
- (void)initNavigationBar
{
    UIBarButtonItem *leftItem;
    UIBarButtonItem *rightItem;
    if ([self.style isEqualToString:REGISTER])
    {
        leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
        rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(next:)];
    }
    else
    {
        leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"CancelCross"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
        rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(forgotNext:)];
    }
    leftItem.tintColor = [UIColor whiteColor];
    rightItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, item, nil];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13], NSFontAttributeName,nil] forState:UIControlStateNormal];
}

- (void)next:(id)sender
{
    if (!isLoading)
    {
        if ([smsCodeTextField getTextFieldStr].length == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请输入验证码" byStyle:ERRORMESSAGEERROR];
        }
        else
        {
            isLoading = true;
            self.hud.hidden = NO;
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"/api/auth/checkRegisterSmsCode/%@/%@", [dataModel getMobile], [T0BaseFunction deleteSpacesForString:[smsCodeTextField getTextFieldStr]]]];
            [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                NSLog(@"%@", responseObject);
                self.hud.hidden = YES;
                isLoading = false;
                if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
                {
                    [dataModel setSmsCode:[smsCodeTextField getTextFieldStr]];
                    T0RegisterPasswordViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0RegisterPasswordViewController"];
                    [self.navigationController pushViewController:vc animated:YES];
                    [smsCodeTextField resignFirstResponder];
                }
                else
                {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowError" object:[responseObject objectForKey:@"errorMessage"]];
                    [T0Animator shakeView:self.smsCodeTextField.textInputView];
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                isLoading = false;
                self.hud.hidden = YES;
                [[NSNotificationCenter defaultCenter]postNotificationName:@"HTTPFail" object:nil];
            }];
        }
    }
}

- (void)forgotNext:(id)sender
{
    if (!isLoading)
    {
        if ([smsCodeTextField getTextFieldStr].length == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请输入验证码" byStyle:ERRORMESSAGEERROR];
        }
        else
        {
            isLoading = true;
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"/api/auth/checkForgetSms/%@/%@", [loginDataModel getMobile], [T0BaseFunction deleteSpacesForString:[smsCodeTextField getTextFieldStr]]]];
            [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                NSLog(@"%@", responseObject);
                isLoading = false;
                if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
                {
                    [loginDataModel setSmsCode:[smsCodeTextField getTextFieldStr]];
                    T0ResetPswdViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0ResetPswdViewController"];
                    [self.navigationController pushViewController:vc animated:YES];
                    [smsCodeTextField resignFirstResponder];
                }
                else
                {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowError" object:[responseObject objectForKey:@"errorMessage"]];
                    [T0Animator shakeView:self.smsCodeTextField.textInputView];
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                isLoading = false;
                [[NSNotificationCenter defaultCenter]postNotificationName:@"HTTPFail" object:nil];
            }];
        }
    }
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [smsCodeTextField resignFirstResponder];
}

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [smsCodeTextField resignFirstResponder];
}

#pragma TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //返回一个BOOL值，指明是否允许在按下回车键时结束编辑
    //如果允许要调用resignFirstResponder 方法，这回导致结束编辑，而键盘会被收起
    if ([self.style isEqualToString:REGISTER])
    {
        [self next:nil];
    }
    else
    {
        [self forgotNext:nil];
    }
    return YES;
}

@end
