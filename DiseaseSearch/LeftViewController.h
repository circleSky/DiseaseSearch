//
//  LeftViewController.h
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/12.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallbackFromSelectDelegate.h"

@interface LeftViewController : UIViewController
@property id<CallbackFromSelectDelegate>selectDelegate;
@end
