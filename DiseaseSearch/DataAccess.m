//
//  DataAccess.m
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/8.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import "DataAccess.h"
#import <AFNetworking.h>
#import "Zero.h"

@implementation DataAccess

+(void)getDataWithCityName:(NSString *)cityName requestCode:(NSInteger)requestCode callbackDelegate:(id<NetWorkCallbackDelegate>)callbackDelegate
{
    
    NSString *address = @"http://apis.baidu.com/heweather/weather/free";
    
//    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSString *httpArg = [[NSString stringWithFormat:@"city=北京"] encoding:NSUTF8StringEncoding];
    
    
    
//    [httpArg UTF8String];
    NSString *httpArg = [NSString stringWithFormat:@"city=%@",cityName];
    
    
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", address, httpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"cf4f9eeddaa23171ddb508a0281fe8fe" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                                   [callbackDelegate callBackWithErrorCode:error.code message:error.localizedDescription innerError:nil requestCode:0];
                               } else {
//                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                   
//                                   NSLog(@"%@",responseString);
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
                                   NSArray *array = dict[@"HeWeather data service 3.0"];
                                   
                                   NSDictionary *dic = array[0];
                                   
                                   NSError *jsonError;
                                   Zero *dataModel = [[Zero alloc] initWithDictionary:dic error:&jsonError];
                                           NSLog(@"%@",jsonError);
//                                   NSLog(@"datamodel:   %@",dataModel);
                           
//                                   NSLog(@"%@",array);
                                   [callbackDelegate callBackWithData:dataModel requestCode:requestCode];
                           
                                  
                                   
                                   

//                                   NSLog(@"HttpResponseCode:%ld", responseCode);
//                                   NSLog(@"HttpResponseBody %@",responseString);
                               }
                           }];

    
}

+ (void)getDataWithCity:(NSString *)city requestCode:(NSInteger)requestCode callBackDelegate:(id<NetWorkCallbackDelegate>)callbackDelegate {
    NSString *httpUrl = @"http://apis.baidu.com/apistore/travel/line";
    
    //http://apis.baidu.com/apistore/travel/line
    //location=131&day=3&output=json&coord_type=bd09ll&out_coord_type=bd09ll
    NSString *httpArg = @"location=113.264999,23.108000&output=json";
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"cf4f9eeddaa23171ddb508a0281fe8fe" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                   NSLog(@"HttpResponseCode:%ld", responseCode);
//                                   NSLog(@"HttpResponseBody %@",responseString);
                                   
                                   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
                                   [callbackDelegate callBackWithData:dic requestCode:requestCode];
                               }
                           }];

    
    
}

@end
