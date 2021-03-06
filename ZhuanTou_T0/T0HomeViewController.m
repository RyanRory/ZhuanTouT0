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
@synthesize badge;

#pragma ViewController LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
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
    dataModel = [T0HomePageDataModel shareInstance];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMessage) name:@"NewMessage" object:nil];
    
    [self toDoEvents];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    messageDataModel = [T0MessageDataModel shareInstance];
    [messageDataModel resetPageIndex];
    [messageDataModel getDataFromServer];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMessage) name:@"NewMessage" object:nil];
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideBadge];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"NewMessage" object:nil];
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

#pragma didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma toDoEvents
- (void)toDoEvents
{
    if ([dataModel getData].count > 0)
    {
        LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",[[dataModel getData] objectForKey:@"eventType"]] message:[NSString stringWithFormat:@"%@",[[dataModel getData] objectForKey:@"text"]] style:LGAlertViewStyleAlert buttonTitles:@[@"前往处理"] cancelButtonTitle:@"暂不处理" destructiveButtonTitle:nil actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index){
            T0SSSettleViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0SSSettleViewController"];
            vc.orderNo = [NSString stringWithFormat:@"%@", [[dataModel getData] objectForKey:@"relatedRecord"]];
            [self.navigationController pushViewController:vc animated:YES];
            [dataModel clearData];
        } cancelHandler:^(LGAlertView *alertView){
            [dataModel clearData];
        } destructiveHandler:nil];
        alertView.backgroundColor = MYSSBUTTONDARK;
        alertView.titleTextColor = [UIColor whiteColor];
        alertView.titleFont = [UIFont systemFontOfSize:14.0];
        alertView.buttonsTitleColor = BUTTONYELLOEW;
        alertView.buttonsBackgroundColorHighlighted = MYSSBUTTONBLUE;
        alertView.buttonsFont = [UIFont systemFontOfSize:13.0];
        alertView.messageTextColor = [UIColor whiteColor];
        alertView.cancelButtonTitleColor = [UIColor whiteColor];
        alertView.cancelButtonBackgroundColorHighlighted = MYSSBUTTONBLUE;
        alertView.cancelButtonFont = [UIFont systemFontOfSize:13.0];
        alertView.separatorsColor = [UIColor colorWithRed:89.0/255.0 green:87.0/255.0 blue:87.0/255.0 alpha:1.0];
        [alertView showAnimated:YES completionHandler:nil];
    }
}

#pragma newMessage
- (void)newMessage
{
    if ([messageDataModel isNewMessage])
    {
        [self showBadge];
    }
    else
    {
        [self hideBadge];
    }
}

#pragma badgeFunction
- (void)showBadge
{
    badge = [[UIView alloc]initWithFrame:CGRectMake(30, 10, 8, 8)];
    badge.backgroundColor = MYSSRED;
    [badge.layer setCornerRadius:4];
    [self.navigationController.navigationBar addSubview:badge];
}

- (void)hideBadge
{
    if (badge)
    {
        [badge removeFromSuperview];
    }
}

#pragma buttonAction
- (void)buttonTouchUpInside:(long)index
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
            
        case 1:
        {
            T0StatisticsViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0StatisticsViewController"];
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
            
        case 4:
        {
            T0MyBankCardViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0MyBankCardViewController"];
            vc.style = MYBANKCARD;
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
    T0MessageViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0MessageViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toSettings:(id)sender
{
    T0SettingsViewController *vc = [[self storyboard]instantiateViewControllerWithIdentifier:@"T0SettingsViewController"];
    [self.navigationController pushViewController:vc animated:YES];
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
