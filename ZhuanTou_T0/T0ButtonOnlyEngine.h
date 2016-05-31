//
//  T0ButtonOnlyEngine.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/21.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import "T0BaseFunction.h"

@interface T0ButtonOnlyEngine : T0BaseFunction
{
    NSMutableArray *buttons;
    int selectedTag;
}

- (void)addButton:(T0BorderedButton*)button;
- (int)getSelectedButtonTag;
- (NSString*)getSelectedButtonTitle;
- (NSArray*)getButtons;
- (void)setSelectedButton:(int)tag;

@end
