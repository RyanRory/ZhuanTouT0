//
//  T0RegisterMobileViewController.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/18.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0RegisterDataModel.h"
#import "T0RegisterSmsCodeViewController.h"

@interface T0RegisterMobileViewController : T0BaseViewController<UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    T0RegisterDataModel *dataModel;
}

@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *mobileTextField;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet T0ProgressHUDView *hud;

@end
