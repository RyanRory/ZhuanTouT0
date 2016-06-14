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
@property (readwrite, nonatomic) NSDictionary *account;
@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *tradePswdTextField;
@property (strong, nonatomic) IBOutlet UIButton *tradePswdSecureEntryButton;
@property (strong, nonatomic) IBOutlet UILabel *communicationPswdStatusLabel;
@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *communicationPswdTextField;
@property (strong, nonatomic) IBOutlet UIButton *communicationPswdSecureEntryButton;
@property (strong, nonatomic) IBOutlet UIButton *changeCommunicationPswdButton;
@property (strong, nonatomic) IBOutlet UIButton *changeTradePswdButton;

@end
