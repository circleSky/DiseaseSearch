//
//  CityInfoViewController.m
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/19.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import "CityInfoViewController.h"
#import "DataAccess.h"
#import "NetWorkCallbackDelegate.h"

@interface CityInfoViewController ()<NetWorkCallbackDelegate>

@end

@implementation CityInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%f======%f",_zero.lon,_zero.lat);
    [DataAccess getDataWithCity:_zero.city requestCode:0 callBackDelegate:self];
}

- (void)callBackWithData:(id)data requestCode:(NSInteger)requestCode {
    NSLog(@"%@",data);
}

@end
