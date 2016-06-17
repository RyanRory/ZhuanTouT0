//
//  T0ChooseListView.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/25.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0ChooseListView.h"

@implementation T0ChooseListView

@synthesize buttonArray;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        buttonArray = [[NSMutableArray alloc]init];
        [self initButtons];
        flag = false;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        buttonArray = [[NSMutableArray alloc]init];
        [self initButtons];
        flag = false;
    }
    return self;
}

- (void)initButtons
{
    for (int i = 0; i < 5; i++)
    {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 31*i, self.bounds.size.width, 30)];
        [button addTarget:self action:@selector(buttonTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithWhite:1 alpha:0.9] forState:UIControlStateNormal];
        [buttonArray addObject:button];
        [self addSubview:button];
        
        if (i > 0)
        {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(8, 30*i, self.bounds.size.width-8, 1)];
            line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
            [self addSubview:line];
        }
    }
}

- (void)setButtonTitles:(NSArray*)titles
{
    for (int i = 0; i < 5; i ++)
    {
        UIButton *button = buttonArray[i];
        NSString *str = [NSString stringWithFormat:@"%@   %@", [titles[i] objectForKey:@"code"], [titles[i] objectForKey:@"name"]];
        
        [button setTitle:str forState:UIControlStateNormal];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentFill];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 13, 0, 0)];
    }
}

- (void)buttonTouchUpInsideAction:(id)sender
{
    flag = true;
}


- (BOOL)isButtonClicked
{
    return flag;
}

- (void)textFieldEditing
{
    flag = false;
}

@end
