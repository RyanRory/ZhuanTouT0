//
//  T0StockSourceChooseView.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/21.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0StockSourceChooseView.h"

@implementation T0StockSourceChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)init
{
    if (self = [super init])
    {
        [self initTitle];
        self.buttonOnlyEngine = [[T0ButtonOnlyEngine alloc]init];
        marginSides = 0;
        marginBetween = 0;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initTitle];
        self.buttonOnlyEngine = [[T0ButtonOnlyEngine alloc]init];
        marginSides = 0;
        marginBetween = 0;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initTitle];
        self.buttonOnlyEngine = [[T0ButtonOnlyEngine alloc]init];
        marginSides = 0;
        marginBetween = 0;
    }
    
    return self;
}

- (void)initTitle
{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 20)];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [super updateConstraints];
    NSArray *buttons = [NSArray arrayWithArray:[self.buttonOnlyEngine getButtons]];
    float width = (self.bounds.size.width - marginBetween*(buttons.count-1) - marginSides*2)/buttons.count;
    for (int i = 0; i < buttons.count; i++)
    {
        [buttons[i] setFrame:CGRectMake(marginSides + (width+marginBetween)*i, 40, width, 32)];
    }
}

- (void)setTitle:(NSString*)str
{
    self.titleLabel.text = str;
}

- (void)addButtons:(NSArray*)buttonTitleArray withMarginBetween:(float)between withMarginSides:(float)sides
{
    marginBetween = between;
    marginSides = sides;
    for (int i = 0; i < buttonTitleArray.count; i++)
    {
        T0BorderedButton *button = [[T0BorderedButton alloc]init];
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:button];
        [self.buttonOnlyEngine addButton:button];
    }
}

- (void)setButtonsFontSize:(float)size
{
    NSArray *array = [NSArray arrayWithArray:[self.buttonOnlyEngine getButtons]];
    for (int i=0; i<array.count; i++)
    {
        UIButton *button = array[i];
        [button.titleLabel setFont:[UIFont systemFontOfSize:size]];
    }
}

- (void)setSelected:(int)tag
{
    [self.buttonOnlyEngine setSelectedButton:tag];
}

@end
