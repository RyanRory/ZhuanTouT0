//
//  T0Animator.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/19.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0Animator.h"

@implementation T0Animator

//抖动动画
+ (void)shakeView:(UIView*)viewToShake
{
    CGFloat t =2.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    
    viewToShake.transform = translateLeft;
    
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}

//平移动画
+ (void)transpositionAnimation:(UIView*)viewToTrans toPoint:(CGPoint)point duration:(float)duration
{
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationDuration:duration];
    viewToTrans.transform = CGAffineTransformMakeTranslation(point.x, point.y);
    [UIView commitAnimations];
}

//透明度渐变动画
+ (void)transopacityAnimation:(UIView*)viewToTrans fromValue:(float)fromValue toValue:(float)toValue duration:(float)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:fromValue];
    animation.toValue = [NSNumber numberWithFloat:toValue];
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [animation setDuration:duration];
    [viewToTrans.layer addAnimation:animation forKey:nil];
}

//从远飞近动画
+ (void)fly:(UIView*)viewToTrans duration:(float)duration
{
    viewToTrans.transform = CGAffineTransformMakeScale(0.1, 0.1);
    viewToTrans.hidden = NO;
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    viewToTrans.transform = CGAffineTransformMakeScale(1.2, 1.2);
    [UIView commitAnimations];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
        [UIView setAnimationDuration:0.1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        viewToTrans.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [UIView commitAnimations];
    });
}

@end
