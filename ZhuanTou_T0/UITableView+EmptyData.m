//
//  UITableView+EmptyData.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/6.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "UITableView+EmptyData.h"

@implementation UITableView(EmptyData)

- (void) tableViewDisplayWitMsg:(NSString *)message imageName:(NSString *)name ifNecessaryForRowCount:(NSUInteger) rowCount
{
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        UIView *emptyView = [[UIView alloc]initWithFrame:self.bounds];
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:name]];
        [imageView setFrame:CGRectMake((emptyView.frame.size.width-imageView.frame.size.width)/2, (emptyView.frame.size.height-80-imageView.frame.size.height)/2, imageView.frame.size.width, imageView.frame.size.height)];
        
        UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+imageView.frame.size.height, emptyView.bounds.size.width, 30)];
        messageLabel.text = message;
        messageLabel.font = [UIFont systemFontOfSize:13.0];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        
        [emptyView addSubview:imageView];
        [emptyView addSubview:messageLabel];
        
        self.backgroundView = emptyView;
    }
    else
    {
        self.backgroundView = nil;
    }
}

@end
