//
//  T0ErrorMessageView.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/7.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseModel.h"

@interface T0ErrorMessageView : UIView
{
    UIWindow *window;
}

@property (strong, nonatomic) UILabel *messageLabel;

- (void)showInView:(UIView*)view withMessage:(NSString*)message byStyle:(NSString*)style;

@end
