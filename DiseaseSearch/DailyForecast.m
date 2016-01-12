//
//  DailyForecast.m
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/8.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import "DailyForecast.h"

@implementation DailyForecast

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc]initWithDictionary:@{
                                                      
                                                      /**
                                                       * @property NSString *sr;//"04:50", 日出时间
                                                       @property NSString *ss;//19:47" 日落时间
                                                       @property NSInteger codeDay;//白天天气状况代码，参考http://www.heweather.com/documents/condition-code
                                                       @property NSInteger codeNight;//夜间天气状况代码
                                                       @property NSString *txtDay;//晴", 白天天气状况描述
                                                       @property NSString *txtNight;//"晴" 夜间天气状况描述
                                                       */
                                                      
                                                      
                                                      @"astro.sr":@"sr",
                                                      @"astro.ss":@"ss",
                                                      @"cond.code_d":@"codeDay",
                                                      @"cond.code_n":@"codeNight",
                                                      @"cond.txt_d":@"txtDay",
                                                      @"cond.txt_n":@"txtNight",
                                                      @"date":@"date",
                                                      @"hum":@"hum",
                                                      @"pcpn":@"pcpn",
                                                      @"pop":@"pop",
                                                      @"pres":@"pres",
                                                      @"tmp.max":@"max",
                                                      @"tmp.min":@"min",
                                                      @"vis":@"vis",
                                                      @"wind.deg":@"deg",
                                                      @"wind.dir":@"dir",
                                                      @"wind.sc":@"sc",
                                                      @"wind.spd":@"spd"
                                                      /**
                                                       *  @property NSString *date;//"2015-07-02", 预报日期
                                                       @property NSInteger hum;//相对湿度（%）
                                                       @property float pcpn;//降水量
                                                       @property NSInteger pop;//降水概率
                                                       @property NSInteger pres;//气压
                                                       
                                                       @property NSInteger max;//最高温度
                                                       @property NSInteger min;//
                                                       
                                                       @property NSInteger vis;//能见度
                                                       
                                                       @property NSInteger deg;//风向（360度）
                                                       @property NSString *dir;//西北风", 风向
                                                       @property NSString *sc;// "微风", 风力
                                                       @property NSInteger spd;// "12" 风速（kmph）

                                                       */
                                                      }];
    
    
}

@end