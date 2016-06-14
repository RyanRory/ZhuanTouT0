//
//  T0LoginMobileViewController.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/18.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0LoginMobileViewController.h"

@interface T0LoginMobileViewController ()

@end

@implementation T0LoginMobileViewController

@synthesize mobileTextField, descriptionLabel;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [mobileTextField setPlaceHolderText:@"请输入您的手机号码"];
    [mobileTextField setPlaceHolderChangeText:@"手机号码"];
    mobileTextField.delegate = self;
    
    dataModel = [T0LoginDataModel shareInstance];
    
    self.hud.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [mobileTextField becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    T0NavigationController *nav = (T0NavigationController*)self.navigationController;
    [nav setPageOfPageControl:0];
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Navigation Function
- (void)initNavigationBar
{
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"CancelCross"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    leftItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(next:)];
    rightItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, item, nil];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    T0NavigationController *nav = (T0NavigationController*)self.navigationController;
    [nav showPageControl:2];
}

- (void)next:(id)sender
{
    if (!isLoading)
    {
        if ([mobileTextField getTextFieldStr].length == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请输入手机号码" byStyle:ERRORMESSAGEERROR];
        }
        else
        {
            self.hud.hidden = NO;
            isLoading = true;
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/auth/checkMobile/%@?vCode=%@", [T0BaseFunction deleteSpacesForString:[mobileTextField getTextFieldStr]], [T0BaseFunction md5HexDigest:[NSString stringWithFormat:@"rujustkiddingme%@", [T0BaseFunction deleteSpacesForString:[mobileTextField getTextFieldStr]]]]]];
            [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                NSLog(@"%@", responseObject);
                self.hud.hidden = YES;
                if ([[NSString stringWithFormat:@"%@", [responseObject objectForKey:@"errorCode"]] isEqualToString:@"MobileAlreadyExists"])
                {
                    isLoading = false;
                    [dataModel setMobile:[T0BaseFunction deleteSpacesForString:[mobileTextField getTextFieldStr]]];
                    [dataModel setVCode:[T0BaseFunction md5HexDigest:[NSString stringWithFormat:@"rujustkiddingme%@", [T0BaseFunction deleteSpacesForString:[mobileTextField getTextFieldStr]]]]];
                    T0LoginPasswordViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0LoginPasswordViewController"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
                    {
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowError" object:@"该手机尚未注册"];
                    }
                    else
                    {
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowError" object:[responseObject objectForKey:@"errorMessage"]];
                    }
                    [T0Animator shakeView:self.mobileTextField.textInputView];
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

- (void)cancel:(id)sender
{
    [mobileTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
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
