//
//  T0SSSettleTableViewCell.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/31.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0SSSettleTableViewCell.h"

@implementation T0SSSettleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContentText:(NSString *)text
{
    CGRect frame = [self frame];
    self.contentLabel.text = text;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = CGSizeMake(SCREEN_WIDTH-44, MAXFLOAT);
    CGSize labelSize = [self.contentLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.contentLabel.font,NSFontAttributeName, nil] context:nil].size;
    self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y, labelSize.width, labelSize.height);
    frame.size.height = labelSize.height;
    self.frame = frame;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
