//
//  T0AddBankCardViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/24.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0AddBankCardViewController.h"

@interface T0AddBankCardViewController ()

@end

@implementation T0AddBankCardViewController

@synthesize nameTextField, branchTextField, cardNumTextField, bankLabel, cityLabel, provinceLabel;
@synthesize nameButton, bankButton, cityButton, branchButton, provinceButton, cardNumButton;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:30.0f];
    
    [self initNavigationBar];
    
    [cardNumTextField becomeFirstResponder];
    
    nameButton.tag = 0;
    [nameButton addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    cardNumButton.tag = 1;
    [cardNumButton addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    bankButton.tag = 2;
    [bankButton addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    provinceButton.tag = 3;
    [provinceButton addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    cityButton.tag = 4;
    [cityButton addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    branchButton.tag = 5;
    [branchButton addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    [nameTextField setValue:[UIColor colorWithWhite:1.0 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    [cardNumTextField setValue:[UIColor colorWithWhite:1.0 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    [branchTextField setValue:[UIColor colorWithWhite:1.0 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self initPickerView];
    
    self.hud.hidden = YES;
    
    dataModel = [T0SettingsDataModel shareInstance];
    nameTextField.text = [dataModel getRealName];
    nameButton.userInteractionEnabled = NO;
}

- (void)dealloc
{
    picker.delegate = nil;
    picker.dataSource = nil;
}

#pragma initPickerView
- (void)initPickerView
{
    view = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationController.view.frame.size.height, self.navigationController.view.frame.size.width, 224)];
    
    picker = [[UIPickerView alloc] init];
    picker.backgroundColor = [UIColor whiteColor];
    picker.frame = CGRectMake(0, view.frame.size.height - 180, view.frame.size.width, 180);
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = YES;
    
    [view addSubview:picker];
    
    toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, view.frame.size.height - 224, view.frame.size.width, 44)];
    UIBarButtonItem *okButton = [[UIBarButtonItem alloc]initWithTitle:@"下一项" style:UIBarButtonItemStylePlain target:self action:@selector(OKButton:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(CancelButton:)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    toolBar.items = [NSArray arrayWithObjects:cancelButton, flexibleSpace, okButton, nil];
    
    [view addSubview:toolBar];
    
    bankTemp = provinceTemp = cityTemp = 0;

    [self.navigationController.view addSubview:view];
    
    bankArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bankList" ofType:@"plist"]];
    provinceArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"provinceList" ofType:@"plist"]];

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
    [T0Animator transpositionAnimation:view toPoint:CGPointMake(0, 0) duration:0.3];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)next:(id)sender
{
    [T0Animator transpositionAnimation:view toPoint:CGPointMake(0, 0) duration:0.3];
    [nameTextField resignFirstResponder];
    [cardNumTextField resignFirstResponder];
    [branchTextField resignFirstResponder];
    if (!isLoading)
    {
        if (nameTextField.text.length == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请输入账户姓名" byStyle:ERRORMESSAGEWARNING];
            [nameTextField becomeFirstResponder];
        }
        else if (cardNumTextField.text.length == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请输入银行账号" byStyle:ERRORMESSAGEWARNING];
            [cardNumTextField becomeFirstResponder];
        }
        else if ([bankLabel.text isEqualToString:@"请选择"])
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请选择开户行" byStyle:ERRORMESSAGEWARNING];
            [self buttonTouchUpInside:bankButton];
        }
        else if ([provinceLabel.text isEqualToString:@"请选择"])
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请选择省份" byStyle:ERRORMESSAGEWARNING];
            [self buttonTouchUpInside:provinceButton];
        }
        else if ([cityLabel.text isEqualToString:@"请选择"])
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请选择城市" byStyle:ERRORMESSAGEWARNING];
            [self buttonTouchUpInside:cityButton];
        }
        else if (branchTextField.text.length == 0)
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请输入开户支行" byStyle:ERRORMESSAGEWARNING];
            [branchTextField becomeFirstResponder];
        }
        else
        {
            self.hud.hidden = NO;
            isLoading = true;
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSString *URL = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"api/account/addBankCard"]];
            NSDictionary *parameters = @{@"accountName":nameTextField.text,
                                         @"bankCode":[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bankCodeList" ofType:@"plist"]] objectForKey:bankLabel.text],
                                         @"cardCode":[T0BaseFunction deleteSpacesForString:cardNumTextField.text],
                                         @"city":cityLabel.text,
                                         @"province":provinceLabel.text,
                                         @"subBankName":branchTextField.text};
            [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                NSLog(@"%@", responseObject);
                self.hud.hidden = YES;
                if ([NSString stringWithFormat:@"%@", [responseObject objectForKey:@"isSuccess"]].boolValue)
                {
                    errorView = [[T0ErrorMessageView alloc]init];
                    [errorView showInView:self.navigationController.view withMessage:@"添加银行卡成功" byStyle:ERRORMESSAGESUCCESS];
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

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma buttonAction
- (void)buttonTouchUpInside:(UIButton*)sender
{
    switch (sender.tag) {
        case 0:
            [branchTextField resignFirstResponder];
            [cardNumTextField resignFirstResponder];
            [T0Animator transpositionAnimation:view toPoint:CGPointMake(0, 0) duration:0.3];
            [nameTextField becomeFirstResponder];
            break;
            
        case 1:
            [nameTextField resignFirstResponder];
            [branchTextField resignFirstResponder];
            [T0Animator transpositionAnimation:view toPoint:CGPointMake(0, 0) duration:0.3];
            [cardNumTextField becomeFirstResponder];
            break;
            
        case 5:
            [nameTextField resignFirstResponder];
            [cardNumTextField resignFirstResponder];
            [T0Animator transpositionAnimation:view toPoint:CGPointMake(0, 0) duration:0.3];
            [branchTextField becomeFirstResponder];
            break;
            
        default:
            [self showChooseDetail:sender];
            break;
    }
}

- (void)showChooseDetail:(UIButton*)sender
{
    [nameTextField resignFirstResponder];
    [cardNumTextField resignFirstResponder];
    [branchTextField resignFirstResponder];
    
    if (sender == bankButton)
    {
        buttonTag = 0;
        [T0Animator transpositionAnimation:view toPoint:CGPointMake(0, -224) duration:0.3];
        
        [picker selectRow:bankTemp inComponent:0 animated:NO];
        
        [picker reloadAllComponents];
    }
    else if (sender == provinceButton)
    {
        buttonTag = 1;
        [T0Animator transpositionAnimation:view toPoint:CGPointMake(0, -224) duration:0.3];
        
        [picker selectRow:provinceTemp inComponent:0 animated:NO];
        
        [picker reloadAllComponents];
    }
    else
    {
        if ([provinceLabel.text isEqualToString:@"请选择"])
        {
            errorView = [[T0ErrorMessageView alloc]init];
            [errorView showInView:self.navigationController.view withMessage:@"请先选择省份" byStyle:ERRORMESSAGEWARNING];
        }
        else
        {
            buttonTag = 2;
            [T0Animator transpositionAnimation:view toPoint:CGPointMake(0, -224) duration:0.3];
            cityArray = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cityList" ofType:@"plist"]] objectForKey:provinceLabel.text];
            [picker selectRow:cityTemp inComponent:0 animated:NO];
            
            [picker reloadAllComponents];
        }
    }
}

#pragma TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //返回一个BOOL值，指明是否允许在按下回车键时结束编辑
    //如果允许要调用resignFirstResponder 方法，这回导致结束编辑，而键盘会被收起
    [textField resignFirstResponder];
    if (textField == nameTextField)
    {
        [cardNumTextField becomeFirstResponder];
    }
    else if (textField == cardNumTextField)
    {
        cardNumTextField.text = [T0BaseFunction formatterBankCardNum:cardNumTextField.text];
        [self showChooseDetail:bankButton];
    }
    else
    {
        [self next:self.navigationItem.rightBarButtonItem];
    }
    return YES;
}

#pragma UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (buttonTag == 0)
    {
        return bankArray.count;
    }
    else if (buttonTag == 1)
    {
        return provinceArray.count;
    }
    else
    {
        return cityArray.count;
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (buttonTag == 0)
    {
        return [bankArray objectAtIndex:row];
    }
    else if (buttonTag == 1)
    {
        return [provinceArray objectAtIndex:row];
    }
    else
    {
        return [cityArray objectAtIndex:row];;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (buttonTag == 0)
    {
        bankTemp = (int)row;
    }
    else if (buttonTag == 1)
    {
        provinceTemp = (int)row;
    }
    else
    {
        cityTemp = (int)row;
    }
}

- (void)OKButton:(id)sender
{
    if (buttonTag == 0)
    {
        bankLabel.text = [bankArray objectAtIndex:bankTemp];
        bankLabel.textColor = [UIColor whiteColor];
        [self showChooseDetail:provinceButton];
    }
    else if (buttonTag == 1)
    {
        if (![provinceLabel.text isEqualToString:[provinceArray objectAtIndex:provinceTemp]])
        {
            cityTemp = 0;
            cityLabel.text = @"请选择";
            cityLabel.textColor = [UIColor colorWithWhite:1 alpha:0.5];
        }
        provinceLabel.text = [provinceArray objectAtIndex:provinceTemp];
        provinceLabel.textColor = [UIColor whiteColor];
        [self showChooseDetail:cityButton];
    }
    else
    {
        cityLabel.text = [cityArray objectAtIndex:cityTemp];
        cityLabel.textColor = [UIColor whiteColor];
        [T0Animator transpositionAnimation:view toPoint:CGPointMake(0, 0) duration:0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [branchTextField becomeFirstResponder];
        });
    }
}

- (void)CancelButton:(id)sender
{
    [T0Animator transpositionAnimation:view toPoint:CGPointMake(0, 0) duration:0.3];
}



@end
