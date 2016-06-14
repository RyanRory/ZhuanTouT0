//
//  T0ProgressHUD.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/6.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0ProgressHUDView.h"

@implementation T0ProgressHUDView

@synthesize imageView;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.backgroundColor = [UIColor clearColor];
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 46, 40)];
        [self addSubview:imageView];
        images = [NSArray arrayWithObjects:[UIImage imageNamed:@"Loading0"], [UIImage imageNamed:@"Loading1"], [UIImage imageNamed:@"Loading2"], [UIImage imageNamed:@"Loading3"], [UIImage imageNamed:@"Loading4"], [UIImage imageNamed:@"Loading5"], [UIImage imageNamed:@"Loading6"], [UIImage imageNamed:@"Loading7"], [UIImage imageNamed:@"Loading8"], [UIImage imageNamed:@"Loading9"], [UIImage imageNamed:@"Loading10"], [UIImage imageNamed:@"Loading11"], [UIImage imageNamed:@"Loading12"], [UIImage imageNamed:@"Loading13"], nil];
        imageView.animationImages = images;
        imageView.animationDuration = 1;
        imageView.animationRepeatCount = 0;
        [imageView startAnimating];
    }
    return self;
}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    if (hidden)
    {
        [tempView removeFromSuperview];
    }
    else
    {
        tempView = [[UIView alloc]initWithFrame:self.superview.bounds];
        tempView.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:48.0/255.0 blue:51.0/255.0 alpha:0.4];
        [self.superview addSubview:tempView];
        [self.superview bringSubviewToFront:self];
    }
}


@end
