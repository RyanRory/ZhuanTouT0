//
//  T0ShowPasswordViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0InputPasswordViewController.h"

@interface T0ShowPasswordViewController : T0BaseViewController

@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *changePasswordButton;
@property (strong, nonatomic) IBOutlet UIButton *secureEntryButton;
@property (readwrite, nonatomic) NSString *account;

@end
