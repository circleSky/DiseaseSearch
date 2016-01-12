//
//  DataAccess.h
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/8.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkCallbackDelegate.h"

@interface DataAccess : NSObject

+ (void)getDataWithCityName:(NSString *)cityName requestCode:(NSInteger)requestCode callbackDelegate:(id<NetWorkCallbackDelegate>)callbackDelegate;

//请求城市旅游路线
+ (void)getDataWithCity:(NSString *)city requestCode:(NSInteger)requestCode callBackDelegate:(id<NetWorkCallbackDelegate>)callbackDelegate;
@end
