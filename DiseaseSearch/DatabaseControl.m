//
//  DatabaseControl.m
//  Demo02_LocalFileAndSetting
//
//  Created by 李海龙 on 15/11/27.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import "DatabaseControl.h"
#import "FMDB.h"

@implementation DatabaseControl {
//    sqlite3 *db;
    FMDatabase *database;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //确定数据库保存位置
        NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"/weather.db"];
        
        //打开数据库
        database = [FMDatabase databaseWithPath:fileName];
        [database open];
        
        //创建表  infomations是表名 此处将desc更改为descp  因为系统存在关键字desc，排序的
        NSString *sql = @"CREATE TABLE IF NOT EXISTS weatherdata(pinyin text,shortName text)";
        //没有的话就创建
        [database executeUpdate:sql];
        
    }
    return self;
}

//在程序访问完表后自定关闭数据库
- (void)dealloc{
    [database close];
}
#pragma mark 向表中添加信息
- (void)insertInfoWithCityName:(NSString *)pinyin CityShortName:(NSString *)shortName {
       NSString *sql = @"insert into weatherdata values(?,?)";
    
    [database executeUpdate:sql,pinyin,shortName];
}


- (NSArray *)weatherDatas
{
    NSString *sql = @"select * from weatherdata";
    //返回的是一个结果集 返回多条数据时 FMDB会将数据存放在结果集之中 在对结果集进行操作
    FMResultSet *reslutSet = [database executeQuery:sql];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    while ([reslutSet next]) {

        NSMutableArray *array = [NSMutableArray array];
        NSString *pinyin = [[NSString alloc] init];
        NSString *shortName;
        
        pinyin = [reslutSet stringForColumn:@"pinyin"];
        shortName = [reslutSet stringForColumn:@"shortName"];
        [array addObject:pinyin];
        [array addObject:shortName];
        
        NSLog(@"======================");
        [resultArray addObject:array];
    }
    //关闭结果集
    [reslutSet close];
    return resultArray;
}

//在表中根据某一属性删除该行信息

- (void)deleteWeatherData:(NSString *)shortName {
    NSString *sql = @"delete from weatherdata where shortName=?";
    [database executeUpdate:sql,shortName];
}

























@end
