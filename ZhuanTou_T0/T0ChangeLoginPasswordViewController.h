//
//  T0ChangeLoginPasswordViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/7.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"

@interface T0ChangeLoginPasswordViewController : T0BaseViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *oldPswdTextField;
@property (strong, nonatomic) IBOutlet UIButton *oldPswdSecureEntryButton;
@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *neoPswdTextField;
@property (strong, nonatomic) IBOutlet UIButton *neoPswdSecureEntryButton;
@property (strong, nonatomic) IBOutlet T0ProgressHUDView *hud;

@end
