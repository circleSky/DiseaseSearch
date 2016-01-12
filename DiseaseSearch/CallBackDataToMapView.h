//
//  CallBackDataToMapView.h
//  DiseaseSearch
//
//  Created by 吴卓 on 16/1/4.
//  Copyright © 2016年 吴卓. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CallBackDataToMapView <NSObject>

- (void)cllBackDataWithcategory:(NSString *)type;
- (void)callBackDataWithError:(NSString *)error;

@end
