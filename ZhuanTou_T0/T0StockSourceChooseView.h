//
//  T0StockSourceChooseView.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/21.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "T0ButtonOnlyEngine.h"

@interface T0StockSourceChooseView : UIView
{
    float marginBetween, marginSides;
}

@property (strong, nonatomic) T0ButtonOnlyEngine *buttonOnlyEngine;
@property (strong, nonatomic) UILabel *titleLabel;

- (void)setTitle:(NSString*)str;
- (void)addButtons:(NSArray*)buttonTitleArray withMarginBetween:(float)between withMarginSides:(float)sides;
- (void)setButtonsFontSize:(float)size;
- (void)setSelected:(int)tag;

@end
