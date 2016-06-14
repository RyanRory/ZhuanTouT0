//
//  T0InputPasswordViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"

@interface T0InputPasswordViewController : T0BaseViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *passwordTextField;
@property (readwrite, nonatomic) NSDictionary *account;
@property (readwrite, nonatomic) int style;//0修改交易密码，1设置通讯密码，2修改通讯密码

@end
