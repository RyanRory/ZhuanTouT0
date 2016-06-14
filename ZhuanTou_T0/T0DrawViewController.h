//
//  T0DrawViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/3.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"

@interface T0DrawViewController : T0BaseViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *bankLogoImageView;
@property (strong, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *cardNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *branchLabel;
@property (strong, nonatomic) IBOutlet UILabel *availableNumLabel;
@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *drawTextField;
@property (strong, nonatomic) IBOutlet T0ProgressHUDView *hud;

@property (readwrite, nonatomic) NSDictionary *data;

@end
