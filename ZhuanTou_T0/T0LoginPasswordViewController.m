//
//  T0LoginPasswordViewController.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/18.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0LoginPasswordViewController.h"

@interface T0LoginPasswordViewController ()

@end

@implementation T0LoginPasswordViewController

@synthesize passwordTextField, descriptionLabel, secureEntryButton, forgotPswdButton ,forgotPswdLine, forgotPswdLabel;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [passwordTextField setPlaceHolderText:@"请输入您的登录密码"];
    [passwordTextField setPlaceHolderChangeText:@"登录密码"];
    [passwordTextField setSecureTextEntry:YES];
    passwordTextField.delegate = self;
    
    secureEntryButton.selected = YES;
    [secureEntryButton addTarget:self action:@selector(isSecureTextEntry:) forControlEvents:UIControlEventTouchUpInside];
    
    [self initButtonAction:forgotPswdButton];
    
    dataModel = [T0LoginDataModel shareInstance];
    
    self.hud.hidden = YES;
    
    [passwordTextField becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    T0NavigationController *nav = (T0NavigationController*)self.navigationController;
    [nav setPageOfPageControl:1];
    [passwordTextField becomeFirstResponder];
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma buttonAction Function
- (void)initButtonAction:(UIButton*)sender
{
    [sender addTarget:self action:@selector(buttonTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(buttonTouchDownAction:) forControlEvents:UIControlEventTouchDown];
    [sender addTarget:self action:@selector(buttonCancelAction:) forControlEvents:UIControlEventTouchCancel];
    [sender addTarget:self action:@selector(buttonCancelAction:) forControlEvents:UIControlEventTouchDragExit];
}
- (void)buttonTouchUpInsideAction:(UIButton*)sender
{
    [T0Animator transopacityAnimation:forgotPswdLine fromValue:0.1 toValue:1.0 duration:0.15];
    [T0Animator transopacityAnimation:forgotPswdLabel fromValue:0.1 toValue:1.0 duration:0.15];
    T0NavigationController *nav = [[self storyboard]instantiateViewControllerWithIdentifier:@"ForgotPasswordNav"];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)buttonTouchDownAction:(UIButton*)sender
{
    [T0Animator transopacityAnimation:forgotPswdLine fromValue:1.0 toValue:0.1 duration:0.15];
    [T0Animator transopacityAnimation:forgotPswdLabel fromValue:1.0 toValue:0.1 duration:0.15];
}

- (void)buttonCancelAction:(UIButton*)sender
{
    [T0Animator transopacityAnimation:forgotPswdLine fromValue:0.1 toValue:1.0 duration:0.15];
    [T0Animator transopacityAnimation:forgotPswdLabel fromValue:0.1 toValue:1.0 duration:0.15];
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
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(next:)];
    rightItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, item, nil];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem, item, nil];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName,nil] forState:UIControlStateNormal];
}

- (void)next:(id)sender
{
    if (!isLoading)
    {
        if ([passwordTextField getTextFieldStr].length == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请输入登录密码" byStyle:ERRORMESSAGEERROR];
        }
        else
        {
            isLoading = true;
            self.hud.hidden = NO;
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/auth/signIn"]];
            NSDictionary *parameters = @{@"login":[T0BaseFunction deleteSpacesForString:[dataModel getMobile]],
                                         @"password":[self.passwordTextField getTextFieldStr]};
            [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                NSLog(@"%@", responseObject);
                self.hud.hidden = YES;
                if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isAuthenticated"]].boolValue)
                {
                    isLoading = false;
                    [dataModel setPassword:[self.passwordTextField getTextFieldStr]];
                    [dataModel saveAllDataToUserDefaults];
                    
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
                    [settingsDataModel setMobile:[NSString stringWithFormat:@"%@", [responseObject objectForKey:@"mobilePhone"]]];
                    
                    [passwordTextField resignFirstResponder];
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
