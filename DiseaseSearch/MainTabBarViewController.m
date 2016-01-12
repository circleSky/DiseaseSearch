//
//  MainTabBarViewController.m
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/7.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import "MainTabBarViewController.h"

#import "NetWorkCallbackDelegate.h"

#import "RootViewController.h"
#import "TravelViewController.h"

@interface MainTabBarViewController ()<NetWorkCallbackDelegate>


@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBar.tintColor = [UIColor colorWithRed:75/255.0f green:123/255.0f blue:183/255.0f alpha:1];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.tabBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationBar.shadowImage = [UIImage new];
    
//    self.tabBar.hidden = YES;
//    [BookListDataControll getIDatarequestCode:0 callbackDelegate:self];
    TravelViewController *travelVC = [[TravelViewController alloc] init];
    travelVC.title = @"旅游";
    RootViewController *rootVC = [[RootViewController alloc] init];
    rootVC.title = @"one";
    self.viewControllers = @[rootVC,travelVC];
    //这侧通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotificationFromLeft:) name:@"TAB" object:nil];
    
    
}

- (void)getNotificationFromLeft:(NSNotification *)sender {
    NSArray *arr = [[NSArray alloc] init];
    arr = sender.object;
    if (arr.count == 0) {
        self.selectedIndex = 0;
        [self.view reloadInputViews];
    }
}

//- (void)callBackWithData:(id)data requestCode:(NSInteger)requestCode
//{
//    NSLog(@"%@",data);
//}

@end
