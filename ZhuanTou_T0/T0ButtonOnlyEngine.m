//
//  T0ButtonOnlyEngine.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/21.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0ButtonOnlyEngine.h"

@implementation T0ButtonOnlyEngine

- (instancetype)init
{
    if (self = [super init])
    {
        buttons = [[NSMutableArray alloc]init];
        selectedTag = -1;
    }
    
    return self;
}

- (void)addButton:(T0BorderedButton*)button
{
    button.tag = buttons.count;
    [buttons addObject:button];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickButton:(T0BorderedButton*)sender
{
    if (!sender.selected)
    {
        sender.selected = YES;
        selectedTag = (int)sender.tag;
        [sender setSelectedBorder];
        for (int i = 0; i < buttons.count; i++)
        {
            T0BorderedButton *temT0utton = buttons[i];
            if (temT0utton.tag != sender.tag)
            {
                [temT0utton clearBorder];
                temT0utton.selected = NO;
            }
        }
    }
}

- (int)getSelectedButtonTag
{
    return  selectedTag;
}

- (NSString*)getSelectedButtonTitle
{
    UIButton *button = buttons[selectedTag];
    return button.titleLabel.text;
}

- (NSArray*)getButtons
{
    return buttons;
}

- (void)setSelectedButton:(int)tag
{
    [self performSelector:@selector(clickButton:) withObject:buttons[tag] afterDelay:0.0];
}

@end
