//
//  T0BorderedButton.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/20.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BorderedButton.h"

@implementation T0BorderedButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initBorder];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initBorder];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)initBorder
{
    [self.layer setBorderColor:[UIColor colorWithWhite:1.0f alpha:0.5f].CGColor];
    [self.layer setCornerRadius:3.0f];
    [self.layer setBorderWidth:1.0f];
}

- (void)setSelectedBorder
{
    [self.layer setBorderColor:BUTTONYELLOEW.CGColor];
    [self.layer setBorderWidth:1.0f];
    [self setTitleColor:BUTTONYELLOEW forState:UIControlStateNormal];
}

- (void)clearBorder
{
    [self.layer setBorderWidth:0.0f];
    [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateNormal];
}


@end
