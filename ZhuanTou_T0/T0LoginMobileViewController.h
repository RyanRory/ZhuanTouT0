//
//  T0LoginMobileViewController.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/18.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0LoginDataModel.h"

#import "T0LoginPasswordViewController.h"

@interface T0LoginMobileViewController : T0BaseViewController<UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    T0LoginDataModel *dataModel;
}

@property (strong, nonatomic) IBOutlet T0SmartPlaceholderTextField *mobileTextField;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
