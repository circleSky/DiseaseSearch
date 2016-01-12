//
//  TravelModelMaster.m
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/18.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import "TravelModelMaster.h"

@implementation TravelModelMaster
+ (JSONKeyMapper *)keyMapper {
    NSDictionary *dict = @{
                           @"data.books":@"books",
                           @"data.count":@"count"
                           };
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}
@end
