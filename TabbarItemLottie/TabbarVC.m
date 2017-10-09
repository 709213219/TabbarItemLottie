//
//  TabbarVC.m
//  TabbarItemLottie
//
//  Created by 叶晓倩 on 2017/9/29.
//  Copyright © 2017年 xa. All rights reserved.
//

#import "TabbarVC.h"
#import <Lottie/Lottie.h>
#import "UITabBar+Ex.h"

@interface TabbarVC () <UITabBarControllerDelegate>

@end

@implementation TabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateSelected];
    
    UIViewController *homeVC = [[UIViewController alloc] init];
    homeVC.title = @"直播";
    [self addLottieImage:homeVC lottieImage:@"home_priase_animation"];
    
    UIViewController *nearVC = [[UIViewController alloc] init];
    nearVC.title = @"附近";
    [self addLottieImage:nearVC lottieImage:@"music_animation"];
    
    UIViewController *videoVC = [[UIViewController alloc] init];
    [self addLottieImage:videoVC lottieImage:@"record_change"];
    videoVC.title = @"消息";
    
    UIViewController *meVC = [[UIViewController alloc] init];
    [self addLottieImage:meVC lottieImage:@"upgrade"];
    meVC.title = @"我的";
    
    self.viewControllers = @[homeVC, nearVC, videoVC, meVC];
    
    [self lottieImagePlay:homeVC];
    
    self.delegate = self;
    
    [self addTabLottieView];
    [self.tabBar animationLottieImage:0];
}

- (void)addTabLottieView {
    [self.tabBar addLottieImage:0 lottieName:@"tab_home_animate"];
    [self.tabBar addLottieImage:1 lottieName:@"tab_search_animate"];
    [self.tabBar addLottieImage:2 lottieName:@"tab_message_animate"];
    [self.tabBar addLottieImage:3 lottieName:@"tab_me_animate"];
}

- (void)addLottieImage:(UIViewController *)vc lottieImage:(NSString *)lottieImage {
    vc.view.backgroundColor = [UIColor lightGrayColor];
    
    LOTAnimationView *lottieView = [LOTAnimationView animationNamed:lottieImage];
    lottieView.frame = [UIScreen mainScreen].bounds;
    lottieView.contentMode = UIViewContentModeScaleAspectFit;
    lottieView.loopAnimation = YES;
    lottieView.tag = 100;
    [vc.view addSubview:lottieView];
}

- (void)lottieImagePlay:(UIViewController *)vc {
    LOTAnimationView *lottieView = (LOTAnimationView *)[vc.view viewWithTag:100];
    
    if (!lottieView || ![lottieView isKindOfClass:[LOTAnimationView class]]) {
        return;
    }
    
    lottieView.animationProgress = 0;
    [lottieView play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [self lottieImagePlay:viewController];
    return YES;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ([self.tabBar.items containsObject:item]) {
        NSInteger index = [self.tabBar.items indexOfObject:item];
        [self.tabBar animationLottieImage:(int)index];
    }
}

@end
