//
//  T0RegisterSmsCodeViewController.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/18.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0RegisterDataModel.h"
#import "T0RegisterPasswordViewController.h"

@interface T0RegisterSmsCodeViewController : T0BaseViewController<UITextFieldDelegate>
{
    NSTimer *timer; //计时器
    int secondsCountDown; //秒数
    T0RegisterDataModel *dataModel;
}

@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *smsCodeTextField;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) IBOutlet UIButton *smsCodeButton;

@end
