//
//  T0SmartPlaceholderTextField.m
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/20.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0SmartPlaceholderTextField.h"

@implementation T0SmartPlaceholderTextField

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
        [self initPlaceHolderLabel];
        [self addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addTarget:self action:@selector(editingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
        lastLength = 0;
        self.clipsToBounds = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initPlaceHolderLabel];
        [self addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addTarget:self action:@selector(editingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
        lastLength = 0;
        self.clipsToBounds = NO;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initPlaceHolderLabel];
        [self addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addTarget:self action:@selector(editingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
        lastLength = 0;
        self.clipsToBounds = NO;
    }
    return self;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    if (!isNumberFomatterEntry)
    {
        textFieldStr = text;
    }
}

//初始化placeholderLabel
- (void)initPlaceHolderLabel
{
    self.placeholderLabel = [[UILabel alloc]initWithFrame:self.bounds];
    self.placeholderLabel.alpha = 0.4;
    self.placeholderLabel.textColor = self.tintColor;
    self.placeholderLabel.font = [UIFont systemFontOfSize:[self.font pointSize]*0.8];
    [self addSubview:self.placeholderLabel];
    [self sendSubviewToBack:self.placeholderLabel];
    textFieldStr = @"";
}

//设置变换前后文字
- (void)setPlaceHolderText:(NSString*)str
{
    self.placeholderLabel.text = str;
    placeholderText = self.placeholderLabel.text;
}

- (void)setPlaceHolderChangeText:(NSString*)str
{
    placeholderChangedText = str;
}

//获取textField上的真正内容
- (NSString*)getTextFieldStr
{
    return textFieldStr;
}

//设置是否安全输入
- (void)setSecureTextEntry:(BOOL)flag
{
    NSString *str = self.text;
    self.text = @"";
    [super setSecureTextEntry:flag];
    isSecureTextEntry = flag;
    self.text = str;
}

//设置是否格式化数字输入
- (void)setNumberFomatterEntry:(BOOL)flag Decimal:(BOOL)decimal
{
    isNumberFomatterEntry = flag;
    isDecimal = decimal;
}

//设置是否要有单位
- (void)setUnitsEntry:(BOOL)flag Units:(NSString*)str
{
    isUnitsEntry = flag;
    units = str;
    if (flag)
    {
        self.percentIconLabel = [[UILabel alloc]initWithFrame:self.bounds];
        [self addSubview:self.percentIconLabel];
        NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@", placeholderText, units]];
        [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, placeholderText.length)];
        [aStr addAttribute:NSFontAttributeName value:self.placeholderLabel.font range:NSMakeRange(0, placeholderText.length)];
        [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(placeholderText.length, 1)];
        [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[self.font pointSize]*0.6] range:NSMakeRange(placeholderText.length, 1)];
        self.percentIconLabel.attributedText = aStr;
    }
}

//设置是否输入的是百分比
- (void)setPercentEntry:(BOOL)flag
{
    isPercentEntry = flag;
    if (flag)
    {
        self.percentIconLabel = [[UILabel alloc]initWithFrame:self.bounds];
        [self addSubview:self.percentIconLabel];
        NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%%", placeholderText]];
        [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, placeholderText.length)];
        [aStr addAttribute:NSFontAttributeName value:self.placeholderLabel.font range:NSMakeRange(0, placeholderText.length)];
        [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(placeholderText.length, 1)];
        [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[self.font pointSize]*0.6] range:NSMakeRange(placeholderText.length, 1)];
        self.percentIconLabel.attributedText = aStr;
    }
}

//设置是否是输入股票代码
- (void)setStockEntry:(BOOL)flag
{
    isStockEntry = flag;
}

//输入监听
- (void)shouldLabelAnimated:(UITextField*)textField
{
    if (textField.text.length > 0 && lastLength == 0)
    {
        self.placeholderLabel.text = placeholderChangedText;
        [self labelAnimation:YES label:self.placeholderLabel];
    }
    if (textField.text.length == 0 && lastLength > 0)
    {
        self.placeholderLabel.text = placeholderText;
        [self labelAnimation:NO label:self.placeholderLabel];
    }
    lastLength = self.text.length;
}

- (void)editingChanged:(UITextField*)sender
{
    textFieldStr = self.text;
    //输入百分比
    if (isPercentEntry)
    {
        if (textFieldStr.length == 0)
        {
            NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%%", placeholderText]];
            [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, placeholderText.length)];
            [aStr addAttribute:NSFontAttributeName value:self.placeholderLabel.font range:NSMakeRange(0, placeholderText.length)];
            [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(placeholderText.length, 1)];
            [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[self.font pointSize]*0.6] range:NSMakeRange(placeholderText.length, 1)];
            self.percentIconLabel.attributedText = aStr;
        }
        else
        {
            NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%%", self.text]];
            [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, self.text.length)];
            [aStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, self.text.length)];
            [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(self.text.length, 1)];
            [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[self.font pointSize]*0.6] range:NSMakeRange(self.text.length, 1)];
            self.percentIconLabel.attributedText = aStr;
        }
    }
    if (isUnitsEntry)
    {
        if (textFieldStr.length == 0)
        {
            NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@", placeholderText, units]];
            [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, placeholderText.length)];
            [aStr addAttribute:NSFontAttributeName value:self.placeholderLabel.font range:NSMakeRange(0, placeholderText.length)];
            [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(placeholderText.length, 1)];
            [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[self.font pointSize]*0.6] range:NSMakeRange(placeholderText.length, 1)];
            self.percentIconLabel.attributedText = aStr;
        }
        else
        {
            NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@", self.text, units]];
            [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, self.text.length)];
            [aStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, self.text.length)];
            [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(self.text.length, 1)];
            [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[self.font pointSize]*0.6] range:NSMakeRange(self.text.length, 1)];
            self.percentIconLabel.attributedText = aStr;
        }
    }
    [self shouldLabelAnimated:sender];
}

- (void)editingDidEnd:(UITextField *)sender
{
    if (isNumberFomatterEntry)
    {
        if (self.text.length != 0)
        {
            if ([self.text rangeOfString:@"."].location != NSNotFound)
            {
                self.text = [T0BaseFunction formatterNumberWithDecimal:textFieldStr];
            }
            else
            {
                self.text = [T0BaseFunction formatterNumberWithoutDecimal:textFieldStr];
            }
        }
    }
}

//动画
- (void)labelAnimation:(BOOL)flyUp label:(UILabel*)sender
{
    float x = sender.bounds.size.width/8;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    if (flyUp)
    {
        [sender setAlpha:1.0f];
        CGAffineTransform t = CGAffineTransformMakeTranslation(0-x, -23);
        t = CGAffineTransformScale(t, 0.75, 0.75);
        sender.transform = t;
    }
    else
    {
        [sender setAlpha:0.4f];
        sender.transform = CGAffineTransformMakeScale(1, 1);
    }
    [UIView commitAnimations];
}

@end
