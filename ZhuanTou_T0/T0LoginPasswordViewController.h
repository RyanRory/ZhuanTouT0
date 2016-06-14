//
//  T0LoginPasswordViewController.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/18.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0LoginDataModel.h"
#import "T0SettingsDataModel.h"


@interface T0LoginPasswordViewController : T0BaseViewController<UITextFieldDelegate>
{
    T0LoginDataModel *dataModel;
    T0SettingsDataModel *settingsDataModel;
}

@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIButton *secureEntryButton;
@property (strong, nonatomic) IBOutlet UIButton *forgotPswdButton;
@property (strong, nonatomic) IBOutlet UIView *forgotPswdLine;
@property (strong, nonatomic) IBOutlet UILabel *forgotPswdLabel;
@property (strong, nonatomic) IBOutlet T0ProgressHUDView *hud;

@end
