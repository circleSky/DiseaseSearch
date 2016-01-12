//
//  DatabaseControl.h
//  Demo02_LocalFileAndSetting
//
//  Created by 李海龙 on 15/11/27.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface DatabaseControl : NSObject

- (NSArray *)weatherDatas;
- (void)insertInfoWithCityName:(NSString *)pinyin CityShortName:(NSString *)shortName;
- (void)deleteWeatherData:(NSString *)shortName;

@end
