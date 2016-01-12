//
//  HeaderView.h
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/10.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Zero.h"
#import "DailyForecast.h"

@interface HeaderView : UIView

{
    Zero *zeroNow;
    DailyForecast *dily;
}
- (instancetype)initWithFrame:(CGRect)frame Zero:(Zero *)zero;
@end
