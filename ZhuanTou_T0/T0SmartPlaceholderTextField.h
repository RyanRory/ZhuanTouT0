//
//  T0SmartPlaceholderTextField.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/20.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T0SmartPlaceholderTextField : UITextField
{
    unsigned long lastLength;
    NSString *placeholderText;
    NSString *placeholderChangedText;
    BOOL isSecureTextEntry, isNumberFomatterEntry, isDecimal, isPercentEntry, isStockEntry, isUnitsEntry;
    NSString *textFieldStr;
    NSString *units;
}

@property (strong, nonatomic) UILabel *placeholderLabel;
@property (strong, nonatomic) UILabel *percentIconLabel;

- (void)setPlaceHolderText:(NSString*)str;
- (void)setPlaceHolderChangeText:(NSString*)str;
- (NSString*)getTextFieldStr;
- (void)setSecureTextEntry:(BOOL)flag;
- (void)setNumberFomatterEntry:(BOOL)flag Decimal:(BOOL)decimal;
- (void)setUnitsEntry:(BOOL)flag Units:(NSString*)str;
- (void)setPercentEntry:(BOOL)flag;
- (void)setStockEntry:(BOOL)flag;

@end
