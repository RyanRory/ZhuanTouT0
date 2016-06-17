//
//  T0MessageTableViewCell.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/5.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T0MessageTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIView *isReadView;

- (void)setContentText:(NSString *)text;

@end
