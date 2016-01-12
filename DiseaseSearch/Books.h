//
//  Books.h
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/18.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Books <NSObject>

@end
@interface Books : JSONModel
@property NSString *bookUrl;
@property NSString *title;
@property NSString *headImage;
@property NSString *userName;
@property NSString *userHeadImg;
@property NSString *startTime;
@property NSInteger routeDays;
@property NSInteger bookImgNum;
@property NSInteger viewCount;
@property NSInteger likeCount;
@property NSInteger commentCount;
@property NSString *text;

@property BOOL elite;

@end
