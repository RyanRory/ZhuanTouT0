//
//  T0LineChartView.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/30.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0LineChartView.h"

@implementation T0LineChartView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.backgroundColor = [UIColor clearColor];
        xTextLabels = [[NSMutableArray alloc]init];
        yTextLabels = [[NSMutableArray alloc]init];
        initLineFlag = false;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        xTextLabels = [[NSMutableArray alloc]init];
        yTextLabels = [[NSMutableArray alloc]init];
        initLineFlag = false;
    }
    return self;
}

- (void)setXLabels:(NSArray*)array
{
    xLabels = [NSMutableArray arrayWithArray:array];
}

- (void)setYLabels:(NSArray*)array
{
    yLabels = [NSMutableArray arrayWithArray:array];
}

- (void)setPoints:(NSArray*)array
{
    points = [NSMutableArray arrayWithArray:array];
}

- (void)initXLabels
{
    if (xTextLabels.count == 0)
    {
        if (points.count > 5)
        {
            xLabelMargin = (self.frame.size.width+10)/(points.count-0.5)*(points.count%4-1);
        }
        else
        {
            xLabelMargin = 0;
        }
        xlabelWidth = (self.frame.size.width+10-xLabelMargin)/(xLabels.count-0.5);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(-7, self.frame.size.height-10, xlabelWidth, 10)];
        label.text = xLabels[0];
        label.textColor = MYSSGRAY;
        label.font = [UIFont systemFontOfSize:9.0f];
        [self addSubview:label];
        [xTextLabels addObject:label];
        
        for (int i = 1; i < xLabels.count; i++)
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(1.0+(self.frame.size.width+10)/points.count*(i*floor(points.count/4))-xlabelWidth/2, self.frame.size.height-10, xlabelWidth, 10)];
            label.text = xLabels[i];
            label.textColor = MYSSGRAY;
            label.textAlignment = 1;
            label.font = [UIFont systemFontOfSize:9.0f];
            [self addSubview:label];
            [xTextLabels addObject:label];
        }
    }
    else
    {
        for (int i = 0; i < xLabels.count; i++)
        {
            UILabel *label = xTextLabels[i];
            label.text = xLabels[i];
        }
    }
}

- (void)initYLabels
{
    if (yTextLabels.count == 0)
    {
        ylabelHeight = (self.frame.size.height-12)/(yLabels.count+0.5);
        for (int i = 0; i < yLabels.count; i++)
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(1, ylabelHeight*i, 30, ylabelHeight)];
            label.text = yLabels[i];
            label.textColor = MYSSGRAY;
            label.textAlignment = 1;
            label.font = [UIFont systemFontOfSize:9.0f];
            [self addSubview:label];
            [yTextLabels addObject:label];
        }
    }
    else
    {
        for (int i = 0; i < yLabels.count; i++)
        {
            UILabel *label = yTextLabels[i];
            label.text = yLabels[i];
        }
    }
}

- (void)initLines
{
    initLineFlag = true;
    UIView *xLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-12, self.frame.size.width, 1)];
    xLine.backgroundColor = MYSSBORDERGRAY;
    [self addSubview:xLine];
    
    UIView *yLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, self.frame.size.height-12)];
    yLine.backgroundColor = MYSSBORDERGRAY;
    [self addSubview:yLine];
    
    for (int i = 0; i < yLabels.count; i++)
    {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(31, ylabelHeight*(i+0.5), self.frame.size.width-31, 1)];
        line.backgroundColor = MYSSBORDERGRAY;
        [self addSubview:line];
    }
    
    for (int i = 0; i <(xLabels.count-1)/2; i++)
    {
        UIView *rectangle = [[UIView alloc]initWithFrame:CGRectMake(1.0+(self.frame.size.width+10)/points.count*((i*2+1)*floor(points.count/4)), 0, (self.frame.size.width+10)/points.count*floor(points.count/4), self.frame.size.height-12)];
        rectangle.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
        [self addSubview:rectangle];
    }
}

- (void)drawPointsLine
{
    [self.gradientBackgroundView removeFromSuperview];
    self.gradientBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 13)];
    [self addSubview:self.gradientBackgroundView];
    /** 创建并设置渐变背景图层 */
    //初始化CAGradientlayer对象，使它的大小为渐变背景视图的大小
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.gradientBackgroundView.bounds;
    //设置渐变区域的起始和终止位置（范围为0-1），即渐变路径
    self.gradientLayer.startPoint = CGPointMake(0, 0.0);
    self.gradientLayer.endPoint = CGPointMake(1.0, 0.0);
    //设置颜色的渐变过程
    self.gradientLayerColors = [NSMutableArray arrayWithArray:@[(__bridge id)[UIColor colorWithRed:242.0 / 255.0 green:150.0 / 255.0 blue:0.0 / 255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255.0 / 255.0 green:241.0 / 255.0 blue:0.0 / 255.0 alpha:1.0].CGColor]];
    self.gradientLayer.colors = self.gradientLayerColors;
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.gradientBackgroundView.layer addSublayer:self.gradientLayer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(1, [self calculatePointY:0])];
    for (int i = 1; i < points.count; i++)
    {
        [path addLineToPoint:CGPointMake(1.0+(self.frame.size.width+10)/points.count*i, [self calculatePointY:i])];
    }
    /** 将折线添加到折线图层上，并设置相关的属性 */
    self.lineChartLayer = [CAShapeLayer layer];
    self.lineChartLayer.path = path.CGPath;
    self.lineChartLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.lineChartLayer.fillColor = [[UIColor clearColor] CGColor];
    // 默认设置路径宽度为0，使其在起始状态下不显示
    self.lineChartLayer.lineWidth = 0;
    self.lineChartLayer.lineCap = kCALineCapRound;
    self.lineChartLayer.lineJoin = kCALineJoinRound;
    // 设置折线图层为渐变图层的mask
    self.gradientBackgroundView.layer.mask = self.lineChartLayer;
}

- (double)calculatePointY:(int)index
{
    return (self.frame.size.height-ylabelHeight*1.5)/([NSString stringWithFormat:@"%@",yLabels[0]].doubleValue - [NSString stringWithFormat:@"%@",yLabels[yLabels.count-1]].doubleValue)*([NSString stringWithFormat:@"%@",yLabels[0]].doubleValue - [NSString stringWithFormat:@"%@",points[index]].doubleValue)+0.5*ylabelHeight;
}

- (void)startDrawlineChart
{
    // 设置路径宽度为4，使其能够显示出来
    self.lineChartLayer.lineWidth = 3;
    // 设置动画的相关属性
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.lineChartLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

- (void)showLineChart
{
    [self initXLabels];
    [self initYLabels];
    if (!initLineFlag)
    {
        [self initLines];
    }
    [self drawPointsLine];
    [self startDrawlineChart];
}

@end
