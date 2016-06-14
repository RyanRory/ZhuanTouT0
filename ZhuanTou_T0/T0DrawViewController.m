//
//  T0DrawViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/3.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0DrawViewController.h"

@interface T0DrawViewController ()

@end

@implementation T0DrawViewController

@synthesize drawTextField, bankLogoImageView, bankNameLabel, branchLabel, cardNumLabel, availableNumLabel;
@synthesize data;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    [drawTextField becomeFirstResponder];
    [drawTextField setPlaceHolderText:@"请输入提现金额"];
    [drawTextField setPlaceHolderChangeText:@"提现金额(元)"];
    [drawTextField setNumberFomatterEntry:YES Decimal:YES];
    
    bankNameLabel.text = [NSString stringWithFormat:@"%@",[[data objectForKey:@"bankCard" ] objectForKey:@"bankName"]];
    cardNumLabel.text = [T0BaseFunction addSpacesForString:[NSString stringWithFormat:@"%@",[[data objectForKey:@"bankCard" ] objectForKey:@"cardCodeDisplay"]]];
    branchLabel.text = [NSString stringWithFormat:@"%@",[[data objectForKey:@"bankCard" ] objectForKey:@"subBankName"]];
    availableNumLabel.text = [T0BaseFunction formatterNumberWithDecimal:[NSString stringWithFormat:@"%@",[data objectForKey:@"fundsAvailable"]]];
    [bankLogoImageView sd_setImageWithURL:[NSURL URLWithString:[BASEURL stringByAppendingString:[NSString stringWithFormat: @"content/images/banks/%@.png", [[data objectForKey:@"bankCard" ] objectForKey:@"bankCode"]]]]];
    
    self.hud.hidden = YES;
}

#pragma Navigation Function
- (void)initNavigationBar
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    leftItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ConfirmCheck"] style:UIBarButtonItemStylePlain target:self action:@selector(next:)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, item, nil];
}

- (void)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)next:(id)sender
{
    if (!isLoading)
    {
        if ([drawTextField getTextFieldStr].length == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请输入提现金额" byStyle:ERRORMESSAGEWARNING];
        }
        else if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(([1-9]\\d{0,9})|0)(\\.\\d{1,2})?$"] evaluateWithObject:[drawTextField getTextFieldStr]])
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请输入正确的提现金额" byStyle:ERRORMESSAGEWARNING];
        }
        else
        {
            isLoading = true;
            self.hud.hidden = NO;
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/withdraw/applyWithdraw"]];
            NSDictionary *parameters = @{@"amount":[drawTextField getTextFieldStr],
                                         @"bankCardId":[[data objectForKey:@"bankCard"] objectForKey:@"id"],
                                         @"accountName":[[data objectForKey:@"bankCard"] objectForKey:@"accountName"],
                                         @"transferAccount":[[data objectForKey:@"bankCard"] objectForKey:@"cardCode"],
                                         @"channel":@"2"};
            NSLog(@"%@",parameters);
            [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                NSLog(@"%@", responseObject);
                self.hud.hidden = YES;
                if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
                {
                    errorView = [[T0ErrorMessageView alloc]init];
                    [errorView showInView:self.navigationController.view withMessage:@"提现申请成功" byStyle:ERRORMESSAGESUCCESS];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        isLoading = false;
                    });
                    [self.navigationController popToViewController:self.navigationController.viewControllers[[self.navigationController.viewControllers indexOfObject:self]-2]  animated:YES];
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

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
