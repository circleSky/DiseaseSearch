//
//  RouteOfCity.h
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/19.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RouteOfCity : JSONModel
@property NSString *date;
@property NSInteger cityId;
@property NSString *cityName;

@property NSInteger star;
@property NSString *url;
@property NSString *abstract;
@property NSString *descrip;

@property NSArray *itineraries;



@end
