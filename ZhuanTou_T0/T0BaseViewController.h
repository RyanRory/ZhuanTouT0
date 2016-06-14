//
//  T0BaseViewController.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/4/18.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T0BaseViewController : UIViewController
{
    T0ErrorMessageView *errorView;
    BOOL isLoading;
}

- (void)refreshData;
- (void)showError:(NSString*)message;
- (void)HTTPFail;

@end
