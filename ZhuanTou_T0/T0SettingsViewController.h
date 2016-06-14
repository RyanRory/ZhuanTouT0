//
//  T0SettingsViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/5.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0SettingsTableViewCell.h"
#import "T0SettingsDataModel.h"

#import "T0RealNameViewController.h"
#import "T0FeedbackViewController.h"
#import "T0ChangeLoginPasswordViewController.h"

@interface T0SettingsViewController : T0BaseViewController<UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSArray *cellObjects;
    T0SettingsDataModel *dataModel;
}

@property (strong, nonatomic) IBOutlet UITableView *tView;

@end
