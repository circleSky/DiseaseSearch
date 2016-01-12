//
//  TravelDataAccess.m
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/18.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import "TravelDataAccess.h"
#import <AFNetworking.h>
#import "TravelModelMaster.h"


@implementation TravelDataAccess
+ (void)getDataWithPage:(NSInteger)page Num:(NSInteger)num CallbackDelegate:(id<TravelDataDelegate>)delegate requestCode:(NSInteger)requestCode {
    NSString *address = @"http://apis.baidu.com/qunartravel/travellist/travellist?query=%22%22&page=1";
    NSDictionary *parameters = @{@"query":@"""",@"page":[NSNumber numberWithInteger:page]};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"8b7c36a82b729536154378e1bf63a603" forHTTPHeaderField:@"apikey"];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableLeaves];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:address parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *dic =responseObject;
        
        TravelModelMaster *masterModel = [[TravelModelMaster alloc] initWithDictionary:dic error:nil];
        
//        NSLog(@"%@",masterModel);
        
        [delegate callbackTravelData:masterModel requestCode:0];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
//    [manager GET:address parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *data = responseObject;
//        NSError *jsonError;
//        ShopJSONModel *shopJSONModel = [[ShopJSONModel alloc] initWithDictionary:data error:&jsonError];
//        //        ShopJSONModel *shopJSONModel = responseObject;
//        NSLog(@"massage : %@",shopJSONModel.msg);
//        //        NSLog(@"%@",shopJSONModel.shops);
//        if (jsonError) {
//            if (callbackDelegate) {
//                [callbackDelegate callBackWithErrorCode:-1 message:@"网络解析错误" innerError:jsonError requestCode:requestCode];
//            }
//        }else{
//            if (callbackDelegate) {
//                [callbackDelegate callBackWithData:shopJSONModel requestCode:requestCode];
//            }
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (callbackDelegate) {
//            [callbackDelegate callBackWithErrorCode:-1 message:@"网络数据操作错误" innerError:error requestCode:requestCode];
//        }
//    }];
    
    
}

@end
