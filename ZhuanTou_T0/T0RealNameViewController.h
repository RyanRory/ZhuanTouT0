//
//  T0RealNameViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/5.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0SettingsDataModel.h"

@interface T0RealNameViewController : T0BaseViewController<UITextFieldDelegate>
{
    T0SettingsDataModel *dataModel;
}

@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *nameTextField;
@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *idCardNumTextField;
@property (strong, nonatomic) IBOutlet T0ProgressHUDView *hud;

@end
