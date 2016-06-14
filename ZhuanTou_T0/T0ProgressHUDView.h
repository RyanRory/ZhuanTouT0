//
//  T0ProgressHUD.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/6.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T0ProgressHUDView : UIView
{
    NSArray *images;
    UIView *tempView;
}

@property (strong, nonatomic) UIImageView *imageView;

@end
