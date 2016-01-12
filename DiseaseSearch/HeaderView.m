//
//  HeaderView.m
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/10.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import "HeaderView.h"

#import "Masonry.h"
#import <UIImageView+WebCache.h>



@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame Zero:(Zero *)zero{
    
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor colorWithRed:86.47/255.0 green:85.84/255.0 blue:89.85/255.0 alpha:1];
//        self.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        self.backgroundColor = [UIColor clearColor];
        zeroNow = zero;
        dily = zeroNow.daily[0];
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    //温度区间
    UILabel *tmpLabel = [[UILabel alloc] init];
    tmpLabel.frame = CGRectMake(self.frame.size.width / 2 +50, 10, 150, 40) ;
    tmpLabel.backgroundColor = [UIColor clearColor];
    NSLog(@"%ld~%ld",dily.min,dily.max);
    tmpLabel.text = [NSString stringWithFormat:@"%ld~%ld℃",dily.min,dily.max];
    tmpLabel.font = [UIFont systemFontOfSize:30];
    tmpLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:tmpLabel];
    [tmpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-60);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(250);
    }];
    
    //温度 一个数
    UILabel *nowTmp = [[UILabel alloc] init];
    nowTmp.frame = CGRectMake(self.frame.size.width / 2 +70, 50, self.frame.size.width / 2 - 70, 30);
    nowTmp.backgroundColor = [UIColor clearColor];
    NSLog(@"%ld",zeroNow.tmp);
    nowTmp.text = [NSString stringWithFormat:@"当前温度:%ld℃",zeroNow.tmp];
    nowTmp.font = [UIFont systemFontOfSize:15];
    nowTmp.textAlignment = NSTextAlignmentLeft;
    [self addSubview:nowTmp];
    [nowTmp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-40);
        make.top.mas_equalTo(50);
        make.height.mas_equalTo(30);
        //        make.width.mas_equalTo(250);
    }];
    
    //风向和风力
    UILabel *wind = [[UILabel alloc] init];
    wind.frame = CGRectMake(self.frame.size.width / 2 +70, 80, self.frame.size.width / 2 - 70, 30);
    wind.backgroundColor = [UIColor clearColor];
    wind.text = [NSString stringWithFormat:@"%@ %@级",zeroNow.dir,zeroNow.sc];
    wind.font = [UIFont systemFontOfSize:15];
    wind.textAlignment = NSTextAlignmentLeft;
    [self addSubview:wind];
    [wind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-40);
        make.top.mas_equalTo(80);
        make.height.mas_equalTo(30);
        //        make.width.mas_equalTo(250);
    }];
    
    //气压
    UILabel *pres = [[UILabel alloc] init];
    pres.frame = CGRectMake(self.frame.size.width / 2 +70, 110, self.frame.size.width / 2 - 70, 30);
    pres.backgroundColor = [UIColor clearColor];
    pres.text = [NSString stringWithFormat:@"日出时间:%@",dily.sr];
    pres.font = [UIFont systemFontOfSize:13];
    pres.textAlignment = NSTextAlignmentLeft;
    [self addSubview:pres];
    [pres mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-40);
        make.top.mas_equalTo(110);
        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(250);
    }];
    UILabel *riluo = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2, 130, self.frame.size.width / 2 - 130, 30)];
    riluo.backgroundColor = [UIColor clearColor];
    riluo.text = [NSString stringWithFormat:@"日落时间:%@",dily.ss];
    riluo.font = [UIFont systemFontOfSize:13];
    riluo.textAlignment = NSTextAlignmentLeft;
    [self addSubview:riluo];
    [riluo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-40);
        make.top.mas_equalTo(140);
        make.height.mas_equalTo(20);
        //        make.width.mas_equalTo(250);
    }];
    
   

    UIImageView *imageViewP = [[UIImageView alloc] init];
    imageViewP.frame = CGRectMake(20, 0, 150, 120);
    
    if (dily.txtDay) {
        NSString *str = [NSString stringWithString:dily.txtDay];
        NSString *pinyin = [str mutableCopy];
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
        //去除音标
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripDiacritics, NO);
        NSArray *array = [pinyin componentsSeparatedByString:@" "];
        str = [array componentsJoinedByString:@""];
        NSString *url = [NSString stringWithFormat:@"http://php.weather.sina.com.cn/images/yb3/180_180/%@_0.png",str];
        
        [imageViewP sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil] ;
    }
    else {
        imageViewP.image = [UIImage imageNamed:@"无数据"];
        
    }
    

    
    
//
//    NSLog(@"pinyin= %@",pinyin);
    //tupian
   
//    if ([dily.txtDay isEqualToString:@"毛毛雨/细雨"]) {
//        dily.txtDay = @"小雨";
//    }
    
    
    
    [self addSubview:imageViewP];
    [imageViewP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(120);
        make.width.mas_equalTo(150);
    }];
    
    //天气状况描述
    UILabel *txtDay = [[UILabel alloc] init];
    txtDay.frame = CGRectMake(30, 120, 100, 30);
    txtDay.text = [NSString stringWithFormat:@"白天:%@",dily.txtDay];
    txtDay.backgroundColor = [UIColor clearColor];
    txtDay.textAlignment = NSTextAlignmentCenter;
    [self addSubview:txtDay];
    [txtDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.bottom.mas_equalTo(-50);
        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(100);
    }];
    
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 110, 120, 40)];
    cityLabel.text = zeroNow.city;
//    cityLabel.font = [UIFont systemFontOfSize:30];
    
    //粗体
//    cityLabel.font = [UIFont fontWithName:@"Courier-BoldOblique" size:30];
    cityLabel.font = [UIFont fontWithName:@"Trebuchet-BoldItalic" size:30];
    
    
    cityLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:cityLabel];
    [cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
//        make.bottom.mas_equalTo(-50);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(120);
      }];
    
    //晚上天气
    UILabel *txtLabel = [[UILabel alloc] init];
    txtLabel.frame = CGRectMake(30, 150, 100, 30);
    txtLabel.text = [NSString stringWithFormat:@"晚上:%@",dily.txtNight];
    txtLabel.backgroundColor = [UIColor clearColor];
    txtLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:txtLabel];
    [txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.bottom.mas_equalTo(-20);
        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(100);
    }];
    
    //当前城市
    UILabel *city = [[UILabel alloc] init];
    city.frame = CGRectMake(90, 150, 270, 30);
    city.backgroundColor = [UIColor clearColor];
    city.textAlignment = NSTextAlignmentCenter;
    city.font = [UIFont systemFontOfSize:12];
    city.text = [NSString stringWithFormat:@"当前城市:%@%@ 更新时间:%@",zeroNow.cnty,zeroNow.city,zeroNow.loc];
    [self addSubview:city];
    
    [city mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(290);
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
