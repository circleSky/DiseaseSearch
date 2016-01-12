//
//  EmptyDataView.m
//  SmartHome
//
//  Created by 李海龙 on 15/11/2.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import "EmptyDataView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation EmptyDataView

@synthesize imageView;
@synthesize lblMessage;
@synthesize lblDescription;
@synthesize button;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((SCREEN_WIDTH-150)/2, 200, 150, 150);
        [self addSubview:imageView];
        lblMessage = [[UILabel alloc] init];
        lblMessage.frame = CGRectMake(20, 380, SCREEN_WIDTH-40, 30);
        lblMessage.textAlignment = NSTextAlignmentCenter;
        lblMessage.font = [UIFont systemFontOfSize:18];
        lblMessage.textColor = [UIColor darkGrayColor];
        [self addSubview:lblMessage];
        
        lblDescription = [[UILabel alloc] init];
        lblDescription.frame = CGRectMake(20, 420, SCREEN_WIDTH-40, 50);
        lblDescription.textAlignment = NSTextAlignmentCenter;
        lblDescription.font = [UIFont systemFontOfSize:14];
        lblDescription.textColor = [UIColor grayColor];
        lblDescription.numberOfLines = 3;
        [self addSubview:lblDescription];
        
        button = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 480, 100, 30)];
        button.layer.borderColor = [UIColor grayColor].CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 5;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [self addSubview:button];
    }
    return self;
}

@end
