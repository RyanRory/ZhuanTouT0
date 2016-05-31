//
//  T0SSSettleViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0SSSettleTableViewCell.h"

@interface T0SSSettleViewController : T0BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *cellObjects;
}

@property (strong, nonatomic) IBOutlet UIButton *finshButton;
@property (strong, nonatomic) IBOutlet UITableView *tView;

@end
