//
//  TwoTableViewController.m
//  DiseaseSearch
//
//  Created by 吴卓 on 16/1/4.
//  Copyright © 2016年 吴卓. All rights reserved.
//

#import "TwoTableViewController.h"

#import <AMapSearchKit/AMapSearchKit.h>

#define SCR_W [UIScreen mainScreen].bounds.size.width
#define SCR_H [UIScreen mainScreen].bounds.size.height

@interface TwoTableViewController ()<UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate>
{
    UITableView *tableViewOne;
    UITableView *tableViewTwo;
    NSMutableArray *arrayTwo;
    NSMutableArray *arrayTwo2;
     AMapSearchAPI *search;
    BOOL bol;
}
@end

@implementation TwoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayTwo = [[NSMutableArray alloc] init];
    bol = YES;
    
    
    
    NSLog(@"%@",_arrayM);
    self.view.backgroundColor = [UIColor clearColor];
    
    //tableViewOne右侧图片
    UIImageView *imageViewP = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 5) * 2, 40, 10, SCR_H - 200)];
    imageViewP.image = [UIImage imageNamed:@"footerView"];
    [self.view addSubview:imageViewP];
    
   
    
    
    [self creatLabel];
    [self creatTableView];
    
}
#pragma mark- btn1\btn2的点击事件
- (void)btn1_touch {
    bol = YES;
    [tableViewTwo reloadData];
}
- (void)btn2_touch {
    bol = NO;
    [tableViewTwo reloadData];
}
#pragma mark- 创建tableView
- (void)creatLabel {
    NSUserDefaults *userdefults = [NSUserDefaults standardUserDefaults];
    NSString *str = [userdefults objectForKey:@"TYPE"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    label.backgroundColor = [UIColor redColor];
    label.text = str;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}
- (void)creatTableView {
    tableViewOne = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, (self.view.frame.size.width / 5) * 2, SCR_W - 40) style:UITableViewStylePlain];
    tableViewOne.backgroundColor = [UIColor clearColor];
    tableViewOne.delegate = self;
    tableViewOne.dataSource = self;
    tableViewOne.tag = 111;
//    tableViewOne.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
   
    [self.view addSubview:tableViewOne];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 111) {
        return _arrayM.count;
    }
    if (tableView.tag == 222) {
        if (bol) {
            return arrayTwo.count;
        }
        else {
            return arrayTwo2.count;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CELL"];
    }
    cell.backgroundColor = [UIColor clearColor];
    if (tableView.tag == 111) {
        AMapPOI *p = _arrayM[indexPath.row];
        cell.textLabel.text = p.name;
        
    }
    cell.backgroundColor = [UIColor clearColor];
    if (tableView.tag == 222) {
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        if (bol) {
            cell.textLabel.text = arrayTwo[indexPath.row];
        }
        else {
            cell.textLabel.text = arrayTwo2[indexPath.row];
        }
    }
   return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 111) {
        arrayTwo = [[NSMutableArray alloc] init];
        arrayTwo2 = [[NSMutableArray alloc] init];
        AMapPOI *p = _arrayM[indexPath.row];
        [arrayTwo addObject:@"到这里"];
        [arrayTwo addObject:[NSString stringWithFormat:@"ID:%@",p.uid]];
        [arrayTwo addObject:[NSString stringWithFormat:@"类型:%@",p.type]];
        [arrayTwo addObject:[NSString stringWithFormat:@"经纬度%@",p.location]];
        [arrayTwo addObject:[NSString stringWithFormat:@"地址:%@",p.address]];
        [arrayTwo addObject:[NSString stringWithFormat:@"电话:%@",p.tel]];
        [arrayTwo addObject:[NSString stringWithFormat:@"距城市地理中心%ld米",p.distance]];
        /**
         // 扩展信息
         @property (nonatomic, copy)   NSString     *postcode; //!< 邮编
         @property (nonatomic, copy)   NSString     *website; //!< 网址
         @property (nonatomic, copy)   NSString     *email;    //!< 电子邮件
         @property (nonatomic, copy)   NSString     *province; //!< 省
         @property (nonatomic, copy)   NSString     *pcode;   //!< 省编码
         @property (nonatomic, copy)   NSString     *city; //!< 城市名称
         @property (nonatomic, copy)   NSString     *citycode; //!< 城市编码
         @property (nonatomic, copy)   NSString     *district; //!< 区域名称
         @property (nonatomic, copy)   NSString     *adcode;   //!< 区域编码
         @property (nonatomic, copy)   NSString     *gridcode; //!< 地理格ID
         @property (nonatomic, copy)   AMapGeoPoint *enterLocation; //!< 入口经纬度
         @property (nonatomic, copy)   AMapGeoPoint *exitLocation; //!< 出口经纬度
         @property (nonatomic, copy)   NSString     *direction; //!< 方向
         @property (nonatomic, assign) BOOL          hasIndoorMap; //!< 是否有室内地图
         @property (nonatomic, copy)   NSString     *businessArea; //!< 所在商圈
         
         */
        NSLog(@"%@",p.postcode);
        [arrayTwo2 addObject:[NSString stringWithFormat:@"省/市/区:%@,%@,%@",p.province,p.city,p.district]];
        [arrayTwo2 addObject:[NSString stringWithFormat:@"区邮编:%@",p.adcode]];
        [arrayTwo2 addObject:[NSString stringWithFormat:@"所在商圈:%@",p.businessArea]];
        
        NSLog(@"%@",arrayTwo2);
        //添加tableViewTwo上方的两个按钮
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 5) * 2 + 10, 40, ((self.view.frame.size.width / 5) * 3 - 10) / 2, 40)];
        [btn1 setTitle:@"基本信息" forState:UIControlStateNormal];
        btn1.backgroundColor = [UIColor lightGrayColor];
        [btn1 addTarget:self action:@selector(btn1_touch) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn1];
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame), 40, ((self.view.frame.size.width / 5) * 3 - 10) / 2, 40)];
        [btn2 setTitle:@"扩展信息" forState:UIControlStateNormal];
        NSLog(@"%f",CGRectGetMaxX(btn1.frame));
        btn2.backgroundColor = [UIColor redColor];
        [btn2 addTarget:self action:@selector(btn2_touch) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn2];
        [self creatTableViewTwo];
    }
    if (tableView.tag == 222) {
        if (indexPath.row == 0) {
            NSLog(@"==============");
           
            [AMapSearchServices sharedServices].apiKey = @"a1d4e442b9980d0136a954efd12f83c7";
            
            //初始化检索对象
            search = [[AMapSearchAPI alloc] init];
            search.delegate = self;
            
            //构造AMapDrivingRouteSearchRequest对象，设置驾车路径规划请求参数
            AMapDrivingRouteSearchRequest *request = [[AMapDrivingRouteSearchRequest alloc] init];
            
            
            request.origin = [AMapGeoPoint locationWithLatitude:39.934949 longitude:116.447265];
            request.destination = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
            request.strategy = 2;//距离优先
            request.requireExtension = YES;
            
            //发起路径搜索
            [search AMapDrivingRouteSearch: request];
            
            //将amapath获得，但是并没有进行处理
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }
}
//实现路径搜索的回调函数
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if(response.route == nil)
    {
         NSLog(@"wrong");
        return;
       
    }
    
    //通过AMapNavigationSearchResponse对象处理搜索结果
    NSString *route = [NSString stringWithFormat:@"Navi: %@", response.route.paths[0]];
    NSLog(@"%@", route);
}



- (void)creatTableViewTwo {
    tableViewTwo = [[UITableView alloc] initWithFrame:CGRectMake( (self.view.frame.size.width / 5) * 2 + 20, 80, (self.view.frame.size.width / 5) * 3 - 10, SCR_W - 80) style:UITableViewStylePlain];
    tableViewTwo.delegate = self;
    tableViewTwo.dataSource = self;
    tableViewTwo.tag = 222;
//    tableViewTwo.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableViewTwo];
    
}







@end
