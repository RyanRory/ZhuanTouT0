//
//  T0ProgressTrackingViewController.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/28.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0SSProgressDataModel.h"
#import "T0ProgressTrackingTableViewCell.h"

@interface T0ProgressTrackingViewController : T0BaseViewController<UITableViewDelegate ,UITableViewDataSource>
{
    T0SSProgressDataModel *SSDataModel;
    NSArray *cellObjects;
}

@property (strong, nonatomic) IBOutlet UIView *navigationBarView;
@property (strong, nonatomic) IBOutlet UITableView *tView;

@end
