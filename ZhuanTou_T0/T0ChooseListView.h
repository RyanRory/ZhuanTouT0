//
//  T0ChooseListView.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/25.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T0ChooseListView : UIView
{
    BOOL flag;
}

@property (strong, nonatomic) NSMutableArray *buttonArray;

- (void)setButtonTitles:(NSArray*)titles;

- (BOOL)isButtonClicked;
- (void)textFieldEditing;

@end
