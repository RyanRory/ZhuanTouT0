//
//  T0LineChartView.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/30.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T0LineChartView : UIView
{
    NSMutableArray *xLabels, *yLabels, *points, *xTextLabels, *yTextLabels;
    double xlabelWidth, ylabelHeight, xLabelMargin;
    BOOL initLineFlag;
}

/** 渐变背景视图 */
@property (nonatomic, strong) UIView *gradientBackgroundView;
/** 渐变图层 */
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
/** 颜色数组 */
@property (nonatomic, strong) NSMutableArray *gradientLayerColors;
/** 折线图层 */
@property (nonatomic, strong) CAShapeLayer *lineChartLayer;

- (void)setXLabels:(NSArray*)array;
- (void)setYLabels:(NSArray*)array;
- (void)setPoints:(NSArray*)array;

- (void)showLineChart;

@end
