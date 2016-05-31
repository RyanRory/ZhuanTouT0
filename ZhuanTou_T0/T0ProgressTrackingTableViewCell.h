//
//  T0ProgressTrackingTableViewCell.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/28.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T0ProgressTrackingTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *topLine;
@property (strong, nonatomic) IBOutlet UIView *bottomLine;
@property (strong, nonatomic) IBOutlet UIImageView *circleImage;
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@end
