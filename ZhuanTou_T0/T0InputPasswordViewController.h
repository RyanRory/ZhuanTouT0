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
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *passwordTextField;
@property (readwrite, nonatomic) BOOL hadAPassword;
@property (readwrite, nonatomic) NSString *account;

@end
