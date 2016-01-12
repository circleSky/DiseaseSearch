//
//  Zero.m
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/8.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import "Zero.h"


@implementation Zero


+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc]initWithDictionary:@{
                                                      /**
                                                       *  @property NSInteger aqi;//空气质量指数
                                                       @property NSInteger co;//一氧化碳1小时平均值(ug/m³)
                                                       @property NSInteger no2;//二氧化氮1小时平均值(ug/m³)
                                                       @property NSInteger o3;//臭氧1小时平均值(ug/m³)
                                                       @property NSInteger pm10;//PM10 1小时平均值(ug/m³)
                                                       @property NSInteger pm25;//PM2.5 1小时平均值(ug/m³)
                                                       @property NSString *qlty;//空气质量类别 优良等
                                                       @property NSInteger so2;//二氧化硫1小时平均值(ug/m³)
                                                       
                                                       //basic
                                                       @property NSString *city;//城市名称
                                                       @property NSString *cnty;//国家
                                                       @property NSString *cityId;//城市ID
                                                       @property float lat;//城市经度
                                                       @property float lon;//城市纬度


//                                                       */
//                                                      @"aqi.city.aqi":@"aqi",
//                                                      @"aqi.city.co":@"co",
//                                                      @"aqi.city.no2":@"no2",
//                                                      @"aqi.city.o3":@"o3",
//                                                      @"aqi.city.pm10":@"pm10",
//                                                      @"aqi.city.pm25":@"pm25",
//                                                      @"aqi.city.qlty":@"qlty",
//                                                      @"aqi.city.so2":@"so2",
                                                      
                                                      @"basic.city":@"city",
                                                      @"basic.cnty":@"cnty",
                                                      @"basic.id":@"cityId",
                                                      @"basic.lat":@"lat",
                                                      @"basic.lon":@"lon",
                                                      
                                                      /**
                                                       *  @property NSString *loc;//当地时间
                                                       @property NSString *utc;//UTC时间

                                                       */
                                                      @"basic.update.loc":@"loc",
                                                      @"basic.update.utc":@"utc",
                                                      
                                                      /**
                                                       *  //now
                                                       @property NSInteger code;//天气状况代码
                                                       @property NSString *txt;//天气状况描述  晴等
                                                       */
                                                      @"now.cond.code":@"code",
                                                      @"now.cond.txt":@"txt",
                                                      
                                                      /**
                                                       *  @property NSInteger fl;//体感温度
                                                       @property NSInteger hum;//相对温度
                                                       @property NSInteger pcpn;//降水量
                                                       @property NSInteger pres;//气压
                                                       @property NSInteger tmp;//温度
                                                       @property NSInteger vis;//能见度
                                                       
                                                       @property NSInteger deg;//风向 360度
                                                       @property NSString *dir;//风向  北风等
                                                       @property NSString *sc;//风级 风力
                                                       @property NSInteger spd;//风速
                                                       
                                                       @property NSString *status;

                                                       */
//                                                      @"now.fl":@"fl",
                                                      @"now.hum":@"hum",
                                                      @"now.pcpn":@"pcpn",
//                                                      @"now.vis":@"vis",
                                                      @"now.pres":@"pres",
                                                      @"now.tmp":@"tmp",
                                                      
                                                      /**
                                                       *  @property NSInteger deg;//风向 360度
                                                       @property NSString *dir;//风向  北风等
                                                       @property NSString *sc;//风级 风力
                                                       @property NSInteger spd;//风速
                                                       
                                                       @property NSString *status;
                                                       */
//                                                      @"now.wind.deg":@"deg",
                                                      @"now.wind.dir":@"dir",
                                                      @"now.wind.sc":@"sc",
                                                      @"now.wind.spd":@"spd",
                                                      @"status":@"status",
                                                      @"daily_forecast":@"daily",
                                                      
                                                      /**
                                                       *  @property NSString *comfbrf;//较不舒适", 简介
                                                       @property NSString *comftxt;//白天天气多云，同时会感到有些热，不很舒适。" //详细描述
                                                       
                                                       //穿衣指数
                                                       @property NSString *drsgbrf;//
                                                       @property NSString *drsgtxt;//
                                                       
                                                       ///洗车指数
                                                       @property NSString *cwbrf;//较适宜",
                                                       @property NSString *cwtxt;//"较适宜洗车未来一天无雨，风力较小，擦洗一新的汽车至少能保持一天。
                                                       
                                                       //感冒指数
                                                       @property NSString *flubrf;//
                                                       @property NSString *flutxt;//
                                                       
                                                       //运动指数
                                                       @property NSString *sportbrf;//
                                                       @property NSString *sporttxt;//
                                                       
                                                       //旅游指数
                                                       @property NSString *travbrf;//
                                                       @property NSString *travtxt;//
                                                       
                                                       //紫外线指数
                                                       @property NSString *uvbrf;//
                                                       @property NSString *uvtxt;//
                                                       
                                                       @property NSArray *dailyForecast;//
                                                       @property NSArray *hourlyForecast;//
                                                       */
                                                      @"suggestion.comf.brf":@"comfbrf",
                                                      @"suggestion.comf.txt":@"comftxt",
                                                      
                                                      /**
                                                       *  @property NSString *cwbrf;//较适宜",
                                                       @property NSString *cwtxt;
                                                       */
                                                      
                                                      @"suggestion.cw.brf":@"cwbrf",
                                                      @"suggestion.cw.txt":@"cwtxt",
                                                      
                                                      @"suggestion.drsg.brf":@"drsgbrf",
                                                      @"suggestion.drsg.txt":@"drsgtxt",
                                                      
                                                      @"suggestion.flu.brf":@"flubrf",
                                                      @"suggestion.flu.txt":@"flutxt",
                                                      
                                                      @"suggestion.sport.brf":@"sportbrf",
                                                      @"suggestion.sport.txt":@"sporttxt",
                                                      
                                                      @"suggestion.trav.brf":@"travbrf",
                                                      @"suggestion.trav.txt":@"travtxt",
                                                      
                                                      @"suggestion.uv.brf":@"uvbrf",
                                                      @"suggestion.uv.txt":@"uvtxt",
                                                      
                                                      
                                                      
                                                      }];
}

@end
