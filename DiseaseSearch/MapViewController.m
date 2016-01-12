//
//  MapViewController.m
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/29.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "SearchAroundViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "CallBackDataToMapView.h"

#import "TwoTableViewController.h"


#define SCR_H [UIScreen mainScreen].bounds.size.height
#define SCR_W [UIScreen mainScreen].bounds.size.width

@interface MapViewController ()<MAMapViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate,UIPopoverPresentationControllerDelegate,CallBackDataToMapView>
{
    MAMapView *mmapView;
    //初始化查询对象
    AMapSearchAPI *search;
    AMapLocationManager *locationManager;
    BOOL typeOfMap;
    NSMutableArray *arrayM;
    
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    
    [AMapLocationServices sharedServices].apiKey = @"a1d4e442b9980d0136a954efd12f83c7";
    //定位功能
    locationManager = [[AMapLocationManager alloc] init];
    locationManager.delegate = self;
    //开启持续定位
    [locationManager startUpdatingLocation];
    //暂停持续定位
//    [self.locationManager stopUpdatingLocation];
    
    
    //开启定位功能
//    mmapView.showsUserLocation = YES;
    
    
    [MAMapServices sharedServices].apiKey = @"a1d4e442b9980d0136a954efd12f83c7";
    mmapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    mmapView.delegate = self;
    
    //地图显示到当前位置
    mmapView.region = MACoordinateRegionMake(CLLocationCoordinate2DMake(_lat, _lon), MACoordinateSpanMake(0.1, 0.1));
    
//   mmapView.logoCenter = CGPointMake(CGRectGetWidth(self.view.bounds)-55, 450);
    mmapView.logoCenter = CGPointMake(50, 70);
    [self.view addSubview:mmapView];
    
    //添加大头针
    //地图样式  卫星图
//    mmapView.mapType = MAMapTypeSatellite;
    MAPointAnnotation *ann1 = [[MAPointAnnotation alloc] init];
    ann1.coordinate = CLLocationCoordinate2DMake(_lat,  _lon);
    ann1.title = @"aaaa";
    ann1.subtitle = @"bbbbb";
    [mmapView addAnnotation:ann1];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
}

#pragma mark- 定位回调函数
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation) {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
   }
//    [locationManager stopUpdatingLocation];
}


#pragma mark- 对POI搜索对应的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    
    arrayM = [[NSMutableArray alloc] init];
    if(response.pois.count == 0)
    {
        return;
    }
    
//    通过 AMapPOISearchResponse 对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %ld",response.count];
    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion];
    NSString *strPoi = @"";
    for (AMapPOI *p in response.pois) {
        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.description];
        //将获取的poi存储到可变数组中，方便传到下一个界面
        [arrayM addObject:p];
        NSLog(@"%@%@%@",p.location,p.name,p.citycode);
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
//    NSLog(@"%@",arrayM);
    TwoTableViewController *target = [[TwoTableViewController alloc] init];
    
    target.arrayM = arrayM;
    target.modalPresentationStyle = UIModalPresentationPopover;
    target.preferredContentSize = CGSizeMake(SCR_W, SCR_W);
    UIPopoverPresentationController *pop = target.popoverPresentationController;
    
    pop.sourceRect = CGRectMake(0, 0, 0, 0);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0 , SCR_H - 400, SCR_W, 200)];
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    pop.sourceView = view;
    pop.permittedArrowDirections = UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown | UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight;
    pop.delegate = self;
    
    
    [self presentViewController:target animated:YES completion:nil];
    
}
- (void)btn_touch:(UIButton *)sender {
    
    SearchAroundViewController *target = [[SearchAroundViewController alloc] init];
    target.delegate = self;
    if (sender.tag == 100) {
        NSLog(@"100");
        
        target.modalPresentationStyle = UIModalPresentationPopover;
        target.preferredContentSize = CGSizeMake(SCR_W, 300);
        UIPopoverPresentationController *pop = target.popoverPresentationController;
       
        pop.sourceRect = CGRectMake(100, 200, 100, 100);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SCR_W - 400, SCR_H - 400, 300, 200)];
        self.view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
        pop.sourceView = view;
        pop.permittedArrowDirections = UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown | UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight;
        pop.delegate = self;
        
        
        [self presentViewController:target animated:YES completion:nil];
        
    }
    else {
        
    }
}
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}
#pragma mark- 添加segmented按键
- (void)viewWillAppear:(BOOL)animated {
    UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [segmented insertSegmentWithTitle:@"普通" atIndex:0 animated:YES];
    [segmented insertSegmentWithTitle:@"卫星" atIndex:1 animated:YES];
    [segmented addTarget:self action:@selector(segmented_touch:) forControlEvents:UIControlEventValueChanged];
    [segmented setSelectedSegmentIndex:0];
    segmented.tintColor = [UIColor blueColor];
    //    self.navigationItem.titleView.hidden = NO;
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
   
    rightImageView.image = [UIImage imageNamed:@"fujin"];
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithCustomView:rightImageView];
     rightImageView.userInteractionEnabled = YES;
    //创建手势，给imageView添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRight_touch)];
    [rightImageView addGestureRecognizer:tap];
    self.navigationItem.titleView = segmented;
    self.navigationItem.rightBarButtonItem = btnRight;
}
- (void)tapRight_touch {
    SearchAroundViewController *target = [[SearchAroundViewController alloc] init];
    target.delegate = self;
    
        NSLog(@"100");
        
        target.modalPresentationStyle = UIModalPresentationPopover;
        target.preferredContentSize = CGSizeMake(SCR_W, 300);
        UIPopoverPresentationController *pop = target.popoverPresentationController;
        
        pop.sourceRect = CGRectMake(100, 200, 100, 100);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SCR_W - 400, SCR_H - 400, 300, 200)];
        self.view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
        pop.sourceView = view;
        pop.permittedArrowDirections = UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown | UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight;
        pop.delegate = self;
        
        
        [self presentViewController:target animated:YES completion:nil];
        
    
}
- (void)segmented_touch:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 1) {
        mmapView.mapType = MAMapTypeSatellite;
    }
    else {
        mmapView.mapType = MAMapTypeStandard;
    }
    
}
- (void)viewDidDisappear:(BOOL)animated {
    self.navigationItem.titleView = nil;
}
#pragma mark- 自选择界面返回的数据
- (void)cllBackDataWithcategory:(NSString *)type {
    NSLog(@"==========================");
    NSLog(@"%@",type);
    [AMapSearchServices sharedServices].apiKey = @"a1d4e442b9980d0136a954efd12f83c7";
    //初始化检索对象
    search = [[AMapSearchAPI alloc] init];
    search.delegate = self;
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:_lat longitude:_lon];
//    request.keywords = @"方恒";
    request.types = type;
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //    发起周边搜索
    [search AMapPOIAroundSearch:request];
//    MAPolyline *polyine = [[MAPolyline polylineWithCoordinates:<#(CLLocationCoordinate2D *)#> count:<#(NSUInteger)#>];
//    AMapPath
    
}






@end
