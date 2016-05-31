//
//  T0MySSViewController.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/28.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0MySSTableViewCell1.h"
#import "T0MySSTableViewCell2.h"
#import "T0MySSTableViewCell3.h"
#import "T0MySSDataModel.h"
#import "T0RecommendSSDataModel.h"

#import "T0SSDetailViewController.h"

@interface T0MySSViewController : T0BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *cellObjects;
    T0MySSDataModel *SSDataModel;
    T0RecommendSSDataModel *ReSSDataModel;
}
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITableView *tView;
@property (readwrite, nonatomic) NSString *style;


@end
