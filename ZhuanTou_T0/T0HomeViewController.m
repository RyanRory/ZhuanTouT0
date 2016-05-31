//
//  T0HomeViewController.m
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/27.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import "T0HomeViewController.h"

@interface T0HomeViewController ()

@end

@implementation T0HomeViewController

@synthesize topBgView, topBgImage;
@synthesize declareView, declareImage, declareLabel, declareButton;
@synthesize statisticsView, statisticsImage, statisticsLabel, statisticsButton;
@synthesize yuGuBaoView, yuGuBaoImage, yuGuBaoLabel, yuGuBaoButton;
@synthesize recommendView, recommendImage, recommendLabel, recommendButton;
@synthesize bankCardView, bankCardImage, bankCardLabel, bankCardButton;
@synthesize incomeView, incomeImage, incomeLabel, incomeButton;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    views = [NSArray arrayWithObjects:declareView, statisticsView, yuGuBaoView, recommendView, bankCardView, incomeView, nil];
    imageViews = [NSArray arrayWithObjects:declareImage, statisticsImage, yuGuBaoImage, recommendImage, bankCardImage, incomeImage, nil];
    labels = [NSArray arrayWithObjects:declareLabel, statisticsLabel, yuGuBaoLabel, recommendLabel, bankCardLabel, incomeLabel, nil];
    buttons = [NSArray arrayWithObjects:declareButton, statisticsButton, yuGuBaoButton, recommendButton, bankCardButton, incomeButton, nil];
    
    for (int i = 0; i < 6; i ++)
    {
        UIButton *button = buttons[i];
        button.tag = i;
        [button addTarget:self action:@selector(buttonTouchDownAction:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(buttonTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(buttonTouchCancelAction:) forControlEvents:UIControlEventTouchCancel];
        [button addTarget:self action:@selector(buttonTouchCancelAction:) forControlEvents:UIControlEventTouchDragExit];
        UIView *view = views[i];
        view.hidden = YES;
    }
    
    animatedFlag = false;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    T0NavigationController *nav = (T0NavigationController*)self.navigationController;
    [nav dismissPageControl];
    
    if (!animatedFlag)
    {
        [self buttonAnimation];
        animatedFlag = true;
    }
}

#pragma Navigation Function
- (void)initNavigationBar
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"MessageIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(toMessages:)];
    leftItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"SettingsIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(toSettings:)];
    rightItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, item, nil];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem, item, nil];
}

#pragma refreshData
- (void)refreshData
{
    
}

#pragma ServerError
- (void)showError
{
    
}

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma buttonAction
- (void)buttonTouchUpInside:(NSInteger)index
{
    UIView *view = views[index];
    UIImageView *imageView = imageViews[index];
    UILabel *label = labels[index];
    view.backgroundColor = HOMEBLACK;
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"HomeButton%ld", index]];
    label.textColor = HOMEGRAY;
}

- (void)buttonTouchDown:(NSInteger)index
{
    UIView *view = views[index];
    UIImageView *imageView = imageViews[index];
    UILabel *label = labels[index];
    view.backgroundColor = HOMEBLUE;
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"HomeButtonTouch%ld", index]];
    label.textColor = [UIColor whiteColor];
}

- (void)buttonTouchUpInsideAction:(UIButton*)sender
{
    [self buttonTouchUpInside:sender.tag];
    switch (sender.tag) {
        case 0:
        {
            T0StockSourceViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0StockSourceViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        
        case 2:
        {
            T0MySSViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0MySSViewController"];
            vc.style = MYSTOCKCOURCE;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 3:
        {
            T0MySSViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0MySSViewController"];
            vc.style = RECOMMENDSTOCKCOURCE;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 5:
        {
            T0BalanceViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0BalanceViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (void)buttonTouchDownAction:(UIButton*)sender
{
    [self buttonTouchDown:sender.tag];
}

- (void)buttonTouchCancelAction:(UIButton*)sender
{
    [self buttonTouchUpInside:sender.tag];
}

- (void)toMessages:(id)sender
{
    
}

- (void)toSettings:(id)sender
{
    
}

#pragma buttonAnimation
- (void)buttonAnimation
{
    [T0Animator fly:views[0] duration:0.3];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [T0Animator fly:views[1] duration:0.3];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [T0Animator fly:views[2] duration:0.3];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [T0Animator fly:views[3] duration:0.3];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [T0Animator fly:views[4] duration:0.3];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [T0Animator fly:views[5] duration:0.3];
    });
}

@end
