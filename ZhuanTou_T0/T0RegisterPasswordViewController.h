//
//  T0RegisterPasswordViewController.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/18.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0RegisterDataModel.h"
#import "T0RegisterSuccessViewController.h"

@interface T0RegisterPasswordViewController : T0BaseViewController<UITextFieldDelegate>
{
    T0RegisterDataModel *dataModel;
}

@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIButton *secureEntryButton;

@end
