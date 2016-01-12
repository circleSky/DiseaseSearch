//
//  TravelDataAccess.h
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/18.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelDataDelegate.h"

@interface TravelDataAccess : NSObject
+ (void)getDataWithPage:(NSInteger)page Num:(NSInteger)num CallbackDelegate:(id<TravelDataDelegate>)delegate requestCode:(NSInteger)requestCode;
@end
