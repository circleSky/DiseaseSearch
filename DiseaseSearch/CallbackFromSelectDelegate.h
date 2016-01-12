//
//  CallbackFromSelectDelegate.h
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/16.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CallbackFromSelectDelegate <NSObject>
- (void)callbackPinyin:(NSString *)cityNamePinyin;

@end
