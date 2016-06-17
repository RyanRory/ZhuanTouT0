//
//  T0ErrorMessageView.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/7.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0ErrorMessageView.h"

@implementation T0ErrorMessageView

@synthesize messageLabel;

- (instancetype)init
{
    if (self = [super init])
    {
        window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [window setBackgroundColor:[UIColor clearColor]];
        [window setWindowLevel:UIWindowLevelAlert];
        [window makeKeyAndVisible];
    }
    
    return self;
}

- (void)showInView:(UIView*)view withMessage:(NSString*)message byStyle:(NSString*)style
{
    [self setFrame:CGRectMake(0, -32, view.frame.size.width, 32)];
    [window setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:14.0f]};
    float width = [message boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    
    messageLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-width)/2, 0, width, 32)];
    messageLabel.text = message;
    messageLabel.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:messageLabel];
    
    if ([style isEqualToString:ERRORMESSAGEERROR])
    {
        messageLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = MESSAGERED;
    }
    else if ([style isEqualToString:ERRORMESSAGEWARNING])
    {
        messageLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = MESSAGERED;
    }
    else
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-20-messageLabel.frame.size.width)/2, 8, 16, 16)];
        imageView.image = [UIImage imageNamed:@"CheckWithCircle"];
        [self addSubview:imageView];
        [messageLabel setFrame:CGRectMake(messageLabel.frame.origin.x+10, 0, width, 32)];
        messageLabel.textColor = HOMEBLACK;
        self.backgroundColor = MESSAGEYELLOEW;
    }
    
    [window addSubview:self];

    [T0Animator transpositionAnimation:self toPoint:CGPointMake(0, 32) duration:0.3];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [T0Animator transpositionAnimation:self toPoint:CGPointMake(0, 0) duration:0.3];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

@end
