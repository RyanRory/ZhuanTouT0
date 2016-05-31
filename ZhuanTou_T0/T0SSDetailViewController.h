//
//  T0SSDetailViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/30.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0SSDetailTableViewCell.h"

#import "T0SSRecordViewController.h"
#import "T0InputPasswordViewController.h"
#import "T0ShowPasswordViewController.h"

@interface T0SSDetailViewController : T0BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *passwordButton;
@property (strong, nonatomic) IBOutlet UIButton *endButton;
@property (strong, nonatomic) IBOutlet UIButton *agreementButton;
@property (strong, nonatomic) IBOutlet UIButton *recordButton;
@property (strong, nonatomic) IBOutlet UILabel *modeLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *sumProfitLabel;
@property (strong, nonatomic) IBOutlet UILabel *allProfitLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ReSSButtonLayoutConstraint;
@property (readwrite, nonatomic) NSDictionary *data;
@property (readwrite, nonatomic) NSArray *cellObjects;
@property (readwrite, nonatomic) NSString *style;

@end
