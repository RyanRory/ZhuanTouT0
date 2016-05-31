//
//  T0HomeViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/27.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"
#import "T0StockSourceViewController.h"
#import "T0MySSViewController.h"
#import "T0BalanceViewController.h"

@interface T0HomeViewController : T0BaseViewController
{
    NSArray *views, *imageViews, *labels, *buttons;
    BOOL animatedFlag;
}

@property (strong, nonatomic) IBOutlet UIView *topBgView;
@property (strong, nonatomic) IBOutlet UIImageView *topBgImage;

@property (strong, nonatomic) IBOutlet UIView *declareView;
@property (strong, nonatomic) IBOutlet UIImageView *declareImage;
@property (strong, nonatomic) IBOutlet UILabel *declareLabel;
@property (strong, nonatomic) IBOutlet UIButton *declareButton;

@property (strong, nonatomic) IBOutlet UIView *statisticsView;
@property (strong, nonatomic) IBOutlet UIImageView *statisticsImage;
@property (strong, nonatomic) IBOutlet UILabel *statisticsLabel;
@property (strong, nonatomic) IBOutlet UIButton *statisticsButton;

@property (strong, nonatomic) IBOutlet UIView *yuGuBaoView;
@property (strong, nonatomic) IBOutlet UIImageView *yuGuBaoImage;
@property (strong, nonatomic) IBOutlet UILabel *yuGuBaoLabel;
@property (strong, nonatomic) IBOutlet UIButton *yuGuBaoButton;

@property (strong, nonatomic) IBOutlet UIView *recommendView;
@property (strong, nonatomic) IBOutlet UIImageView *recommendImage;
@property (strong, nonatomic) IBOutlet UILabel *recommendLabel;
@property (strong, nonatomic) IBOutlet UIButton *recommendButton;

@property (strong, nonatomic) IBOutlet UIView *bankCardView;
@property (strong, nonatomic) IBOutlet UIImageView *bankCardImage;
@property (strong, nonatomic) IBOutlet UILabel *bankCardLabel;
@property (strong, nonatomic) IBOutlet UIButton *bankCardButton;

@property (strong, nonatomic) IBOutlet UIView *incomeView;
@property (strong, nonatomic) IBOutlet UIImageView *incomeImage;
@property (strong, nonatomic) IBOutlet UILabel *incomeLabel;
@property (strong, nonatomic) IBOutlet UIButton *incomeButton;

@end
