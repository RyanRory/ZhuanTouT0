//
//  T0FeedbackViewController.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/6/5.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0BaseViewController.h"

@interface T0FeedbackViewController : T0BaseViewController<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *contentTextView;

@property (strong, nonatomic) IBOutlet T0ProgressHUDView *hud;

@end
