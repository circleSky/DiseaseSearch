//
//  Books.m
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/18.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import "Books.h"

@implementation Books
+ (JSONKeyMapper *)keyMapper {
    NSDictionary *dict = @{
                           @"bookUrl":@"bookUrl",
                           @"title":@"title",
                           @"headImage":@"headImage",
                           @"userName":@"userName",
                           @"userHeadImg":@"userHeadImg",
                           @"startTime":@"startTime",
                           @"routeDays":@"routeDays",
                           @"bookImgNum":@"bookImgNum",
                           @"viewCount":@"viewCount",
                           @"likeCount":@"likeCount",
                           @"commentCount":@"commentCount",
                           @"text":@"text",
                           @"elite":@"elite"
                           };
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}
@end
