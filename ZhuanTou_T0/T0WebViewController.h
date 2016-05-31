//
//  T0WebViewController.h
//  ZhuanTouT0
//
//  Created by 赵润声 on 16/5/5.
//  Copyright © 2016年 ShanghaiMomuFinancialInformationServiceCo.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T0WebViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *reloadButton;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString *url;

@end
