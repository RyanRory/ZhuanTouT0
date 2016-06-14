//
//  T0SetPasswordViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/5.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"

@interface T0SetPasswordViewController : T0BaseViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *tradePswdTextField;
@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *communicationPswdTExtField;
@property (readwrite, nonatomic) NSDictionary *account;
@property (readwrite, nonatomic) NSString *stockAccountId;

@end
