//
//  TravelViewController.m
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/18.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import "TravelViewController.h"
#import "TravelDataAccess.h"
#import "TravelDataDelegate.h"

@interface TravelViewController ()<TravelDataDelegate>
{
    UIWebView *webView;
}
@end

@implementation TravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatTableView];
    
    [TravelDataAccess getDataWithPage:1 Num:20 CallbackDelegate:self requestCode:0];
}
#pragma mark-TravelDataAccess请求返回的数据以及错误信息
- (void)callbackTravelData:(id)data requestCode:(NSInteger)requestCode {
    NSLog(@"%@",data);
}
#pragma mark- 创建tableView
- (void)creatTableView {
    
}





@end
