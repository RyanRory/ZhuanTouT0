//
//  T0BaseButton.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/8.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseButton.h"

@implementation T0BaseButton

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted)
    {
        self.backgroundColor = MYSSBUTTONBLUE;
    }
    else
    {
        self.backgroundColor = MYSSBUTTONDARK;
    }
}

@end
