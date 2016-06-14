//
//  T0ResetPswdViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/6.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0LoginDataModel.h"

@interface T0ResetPswdViewController : T0BaseViewController<UITextFieldDelegate>
{
    T0LoginDataModel *dataModel;
}

@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *passwordSecureEntryButton;
@property (strong, nonatomic) IBOutlet UILabel *passwordContentLabel;
@property (strong, nonatomic) IBOutlet T0ProgressHUDView *hud;

@end
