//
//  T0SettingsTableViewCell.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/6.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T0SettingsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *rightImageView;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;

@end
