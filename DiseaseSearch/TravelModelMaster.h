//
//  TravelModelMaster.h
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/18.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Books.h"

@interface TravelModelMaster : JSONModel
@property NSArray<Books,Optional> *books;

@property NSInteger count;
@end
