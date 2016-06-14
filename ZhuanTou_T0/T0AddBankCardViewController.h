//
//  T0AddBankCardViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/24.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0SettingsDataModel.h"

@interface T0AddBankCardViewController : T0BaseViewController<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSArray *bankArray, *provinceArray, *cityArray;
    UIPickerView *picker;
    UIView *view;
    UIToolbar *toolBar;
    int bankTemp, provinceTemp, cityTemp;
    int buttonTag;
    T0SettingsDataModel *dataModel;
}
@property (strong, nonatomic) IBOutlet T0ProgressHUDView *hud;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *cardNumTextField;
@property (strong, nonatomic) IBOutlet UITextField *branchTextField;
@property (strong, nonatomic) IBOutlet UILabel *bankLabel;
@property (strong, nonatomic) IBOutlet UILabel *provinceLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;

@property (strong, nonatomic) IBOutlet UIButton *nameButton;
@property (strong, nonatomic) IBOutlet UIButton *cardNumButton;
@property (strong, nonatomic) IBOutlet UIButton *bankButton;
@property (strong, nonatomic) IBOutlet UIButton *provinceButton;
@property (strong, nonatomic) IBOutlet UIButton *cityButton;
@property (strong, nonatomic) IBOutlet UIButton *branchButton;

@end
