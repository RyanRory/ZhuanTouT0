//
//  T0RealNameViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/5.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0RealNameViewController.h"

@interface T0RealNameViewController ()

@end

@implementation T0RealNameViewController

@synthesize nameTextField, idCardNumTextField;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [nameTextField becomeFirstResponder];
    
    [nameTextField setPlaceHolderText:@"请输入您的真实姓名"];
    [nameTextField setPlaceHolderChangeText:@"真实姓名"];
    nameTextField.delegate = self;
    
    [idCardNumTextField setPlaceHolderText:@"请输入您的身份证号码"];
    [idCardNumTextField setPlaceHolderChangeText:@"身份证号码"];
    idCardNumTextField.delegate = self;
    
    self.hud.hidden = YES;
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Navigation Function
- (void)initNavigationBar
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    leftItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ConfirmCheck"] style:UIBarButtonItemStylePlain target:self action:@selector(next:)];
    rightItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, item, nil];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem, item, nil];
}

- (void)next:(id)sender
{
    if (!isLoading)
    {
        if ([nameTextField getTextFieldStr].length == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请输入您的真实姓名" byStyle:ERRORMESSAGEERROR];
        }
        else if ([idCardNumTextField getTextFieldStr].length == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请输入您的身份证号码" byStyle:ERRORMESSAGEERROR];
        }
        else
        {
            self.hud.hidden = NO;
            isLoading = true;
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/account/setIdCard/%@/%@", [idCardNumTextField getTextFieldStr], [[nameTextField getTextFieldStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ]]];
            [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                NSLog(@"%@", responseObject);
                self.hud.hidden = YES;
                if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
                {
                    dataModel = [T0SettingsDataModel shareInstance];
                    [dataModel setIsRealNameSet:true];
                    [dataModel setRealName:nameTextField.text];
                    errorView = [[T0ErrorMessageView alloc]init];
                    [errorView showInView:self.navigationController.view withMessage:@"实名认证成功" byStyle:ERRORMESSAGESUCCESS];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        isLoading = false;
                    });
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowError" object:[responseObject objectForKey:@"errorMessage"]];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                self.hud.hidden = YES;
                [[NSNotificationCenter defaultCenter]postNotificationName:@"HTTPFail" object:nil];
            }];
        }
    }
}

- (void)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //返回一个BOOL值，指明是否允许在按下回车键时结束编辑
    //如果允许要调用resignFirstResponder 方法，这回导致结束编辑，而键盘会被收起
    if (textField == nameTextField)
    {
        [nameTextField resignFirstResponder];
        [idCardNumTextField becomeFirstResponder];
    }
    else
    {
        [self next:nil];
    }
    return YES;
}

@end
