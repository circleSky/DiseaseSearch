//
//  SearchAroundViewController.h
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/29.
//  Copyright © 2015年 吴卓. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CallBackDataToMapView.h"

@interface SearchAroundViewController : UIViewController
@property id<CallBackDataToMapView>delegate;
@end
