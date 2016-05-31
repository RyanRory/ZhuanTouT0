//
//  T0Animator.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/19.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface T0Animator : NSObject

+ (void)shakeView:(UIView*)viewToShake;
+ (void)transpositionAnimation:(UIView*)viewToTrans toPoint:(CGPoint)point duration:(float)duration;
+ (void)transopacityAnimation:(UIView*)viewToTrans fromValue:(float)fromValue toValue:(float)toValue duration:(float)duration;
+ (void)fly:(UIView*)viewToTrans duration:(float)duration;

@end
