//
//  T0RegisterPasswordViewController.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/18.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0RegisterPasswordViewController.h"

@interface T0RegisterPasswordViewController ()

@end

@implementation T0RegisterPasswordViewController

@synthesize passwordTextField, descriptionLabel, secureEntryButton;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [passwordTextField setPlaceHolderText:@"请设置您的登录密码"];
    [passwordTextField setPlaceHolderChangeText:@"登录密码"];
    [passwordTextField setSecureTextEntry:YES];
    passwordTextField.delegate = self;
    
    secureEntryButton.selected = YES;
    [secureEntryButton addTarget:self action:@selector(isSecureTextEntry:) forControlEvents:UIControlEventTouchUpInside];
    
    dataModel = [T0RegisterDataModel shareInstance];
    
    self.hud.hidden = YES;
    
    [passwordTextField becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    T0NavigationController *nav = (T0NavigationController*)self.navigationController;
    [nav setPageOfPageControl:2];
    [passwordTextField becomeFirstResponder];
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma SecureEntryButtonAction
- (void)isSecureTextEntry:(UIButton*)sender
{
    sender.selected = !sender.selected;
    [passwordTextField setSecureTextEntry:sender.selected];
    //实现textfield安全输入和正常输入的文字转换
    if (sender.selected)
    {
        [sender setImage:[UIImage imageNamed:@"EyeClose"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"EyeOpen"] forState:UIControlStateNormal];
    }
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
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName,nil] forState:UIControlStateNormal];
}

- (void)next:(id)sender
{
    if (!isLoading)
    {
        if ([passwordTextField getTextFieldStr].length == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请设置登录密码" byStyle:ERRORMESSAGEERROR];
        }
        else
        {
            isLoading = true;
            self.hud.hidden = NO;
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/auth/register"]];
            NSDictionary *parameters = @{@"mobilePhone":[dataModel getMobile],
                                         @"smsCode":[dataModel getSmsCode],
                                         @"password":[passwordTextField getTextFieldStr]};
            [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                NSLog(@"%@", responseObject);
                isLoading = false;
                self.hud.hidden = YES;
                if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
                {
                    [dataModel setPassword:[passwordTextField getTextFieldStr]];
                    [dataModel saveAllDataToUserDefaults];
                    
                    [passwordTextField resignFirstResponder];
                    errorView = [[T0ErrorMessageView alloc]init];
                    [errorView showInView:self.navigationController.view withMessage:@"注册成功" byStyle:ERRORMESSAGESUCCESS];
                    
                    settingsDataModel = [T0SettingsDataModel shareInstance];
                    [settingsDataModel setIsRealNameSet:false];
                    [settingsDataModel setRealName:@""];
                    [settingsDataModel setMobile:[dataModel getMobile]];
                    
                    [self.navigationController dismissViewControllerAnimated:NO completion:^(void){
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowHomePage" object:nil];
                    }];
                }
                else
                {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowError" object:[responseObject objectForKey:@"errorMessage"]];
                    [T0Animator shakeView:self.passwordTextField.textInputView];
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

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [passwordTextField resignFirstResponder];
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
