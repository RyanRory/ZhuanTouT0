//
//  T0LaunchViewController.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/5/6.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0SettingsDataModel.h"
#import "T0HomePageDataModel.h"

@interface T0LaunchViewController : T0BaseViewController
{
    T0SettingsDataModel *settingsDataModel;
    T0HomePageDataModel *homePageDataModel;
    BOOL isLaunch;
}

@property (strong, nonatomic) IBOutlet UIButton *toRegisterButton;
@property (strong, nonatomic) IBOutlet UIButton *toLoginButton;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;

@end
