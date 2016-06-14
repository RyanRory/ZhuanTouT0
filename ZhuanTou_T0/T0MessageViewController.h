//
//  T0MessageViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/5.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0MessageTableViewCell.h"
#import "T0MessageDataModel.h"

@interface T0MessageViewController : T0BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *cellObjects;
    T0MessageDataModel *dataModel;
}

@property (strong, nonatomic) IBOutlet UITableView *tView;
@property (strong, nonatomic) IBOutlet T0ProgressHUDView *hud;

@end
