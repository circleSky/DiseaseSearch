//
//  TravelDataDelegate.h
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/18.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TravelDataDelegate <NSObject>
- (void)callbackTravelData:(id)data requestCode:(NSInteger)requestCode;
- (void)callbackTravelErrorCode:(NSInteger)error;
@end
