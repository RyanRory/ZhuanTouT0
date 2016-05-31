//
//  T0SSSettleTableViewCell.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T0SSSettleTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *noLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

- (void)setContentText:(NSString *)text;

@end
