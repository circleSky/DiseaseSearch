//
//  RootViewController.m
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/8.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import "AppDelegate.h"
#import "EmptyDataView.h"
#import "RootViewController.h"
#import "DetailInfoViewController.h"
#import "TLCityPickerController.h"

//刷新
#import <MJRefresh.h>

#import "NetWorkCallbackDelegate.h"
#import "DataAccess.h"

#import "NowWeatherTableViewCell.h"
#import "FirstTableViewCell.h"
#import "QulityTableViewCell.h"

#import "HeaderView.h"
#import "Zero.h"
#import "DailyForecast.h"

#import <UIImageView+WebCache.h>

#import "DatabaseControl.h"

#import "YRSideViewController.h"
#import "LeftViewController.h"
#import "CallbackFromSelectDelegate.h"
#import <TencentOpenAPI/TencentOAuth.h>
//小菊花
#import <MBProgressHUD.h>
#define SCR_W self.view.frame.size.width

@interface RootViewController ()<NetWorkCallbackDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,CallbackFromSelectDelegate,TencentSessionDelegate>
{
    NSInteger _pageNum;
    NSString *cityName;
    //记录收藏城市的个数
    NSMutableArray *arrayCityM;
    UIScrollView *scrollView;
    UITableView *maintableView;
    NSString *cityPinyin;
    //其中的元素是数组  pinyin 和shortName
    NSMutableArray *shortNameArray;
    
    DatabaseControl *database;
    
    EmptyDataView *emptyDataView;
    
    MBProgressHUD *progress;
    //腾讯对象
    TencentOAuth *tencentOauth;
    NSArray *permissions;
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //整个桌面的背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"maoboli"]];
    /**
     *  注册通知中心,接收从left界面中返回数据
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotification:) name:@"leftData" object:nil];
    self.navigationController.navigationBar.hidden = NO;
    
    [self addTableView];
    
    //可变数组的初始化
    arrayCityM = [[NSMutableArray alloc] init];
    shortNameArray = [NSMutableArray array];
    //数据库对象的初始化
    database = [[DatabaseControl alloc] init];
    //创建数据访问出错时的界面
//    [self creatEmptyView];
}
//#pragma mark创建数据访问出错时的界面
//- (void)creatEmptyView {
//    emptyDataView = [[EmptyDataView alloc] init];
//    emptyDataView.frame = self.view.frame;
//    emptyDataView.imageView.image = [UIImage imageNamed:@"mine"];
//    [emptyDataView.button setTitle:@"重新加载" forState:UIControlStateNormal];
//    [emptyDataView.button addTarget:self action:@selector(emptyButton_Touched:) forControlEvents:UIControlEventTouchUpInside];
//}
- (void)emptyButton_Touched {
    //请求数据前移除emptyDataView
    if (emptyDataView) {
        [emptyDataView removeFromSuperview];
    }
    [maintableView reloadData];
}

#pragma mark- 界面出现消失时需要进行的操作
- (void)viewDidAppear:(BOOL)animated {
    [self addBarButton];
    //设置titleView的图片
    UIImageView *imageVV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 120, 40)];
    imageVV.image = [UIImage imageNamed:@"title"];
    self.parentViewController.navigationItem.titleView = imageVV;
    NSLog(@"%@",[database weatherDatas]);
    //进行判断是不是第一次登录
    
    //判断是否是第一次登录，是的话设置默认城市
    NSUserDefaults *userdefults = [NSUserDefaults standardUserDefaults];
    if ([userdefults objectForKey:@"FIRST"] == nil) {
        
        //判断用户是否登录了，如果没有则进行登录模式选择
        if ([userdefults objectForKey:@"Login"] == nil) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"您还未进行登录" message:@"请选择登录模式" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *actionQQ = [UIAlertAction actionWithTitle:@"QQ登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

                tencentOauth = [[TencentOAuth alloc] initWithAppId:@"1105085944" andDelegate:self];
                permissions = [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
                [tencentOauth authorize:permissions inSafari:YES];
            }];
            UIAlertAction *actionUser = [UIAlertAction actionWithTitle:@"游客登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                //游客登录模式下进行查看天气
                UIAlertController *al = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"请点击右上角图标去搜索您关心的城市吧" preferredStyle:UIAlertControllerStyleAlert];
                
                [al addAction:[UIAlertAction actionWithTitle:@"不忙，一会再去" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [al addAction:[UIAlertAction actionWithTitle:@"直接去搜索" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
                    [cityPickerVC setDelegate:self];
                    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
                        
                    }];
                    
                }]];
                
                [self presentViewController:al animated:YES completion:^{
                }];

                
            }];
            [alertC addAction:actionQQ];
            [alertC addAction:actionUser];
            [self presentViewController:alertC animated:YES completion:^{

            }];

        }
        else {
            //游客登录模式下进行查看天气
            UIAlertController *al = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"请点击右上角图标去搜索您关心的城市吧" preferredStyle:UIAlertControllerStyleAlert];
            
            [al addAction:[UIAlertAction actionWithTitle:@"不忙，一会再去" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [al addAction:[UIAlertAction actionWithTitle:@"直接去搜索" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
                [cityPickerVC setDelegate:self];
                [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
                    
                }];
                
            }]];
            
            [self presentViewController:al animated:YES completion:^{
            }];
        }
        
    }
    else {
        
        NSMutableArray *arrayy = [userdefults objectForKey:@"FIRST"];
        NSLog(@"%@",arrayy);
        [DataAccess getDataWithCityName:arrayy[1] requestCode:0 callbackDelegate:self];
    }
    
    
}
- (void)tencentDidLogin

{
    NSLog(@"dengluwancheng");
    
    if (tencentOauth.accessToken)
        
    {
        //  记录登录用户的OpenID、Token以及过期时间
        
        NSLog(@"%@",tencentOauth.accessToken);
        [tencentOauth getUserInfo];
    }
    else
    {
        NSLog(@"%@",@"登录不成功没有获取accesstoken");
    }
}
//非网络错误导致登录失败：

-(void)tencentDidNotLogin:(BOOL)cancelled

{
    NSLog(@"tencentDidNotLogin");
    if (cancelled)
    {
        NSLog(@"用户取消登录");
    }else{
        NSLog(@"登录失败");
    }
}
// 网络错误导致登录失败：

-(void)tencentDidNotNetWork

{
    
    NSLog(@"tencentDidNotNetWork");
    
//    resultLable.text =@"无网络连接，请设置网络";
    
}

-(void)getUserInfoResponse:(APIResponse *)response
{
    NSUserDefaults *userdefults = [NSUserDefaults standardUserDefaults];
    [userdefults setObject:@"denglu" forKey:@"Login"];
    NSLog(@"%@",response.userData);
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [array insertObject:response atIndex:0];
    NSLog(@"%@",response.jsonResponse);
    
    //重新添加BarButton，从而使头像显示出来
    
    [userdefults setObject:response.jsonResponse forKey:@"UserHeaderImage"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HEADER_IMAGEVIEW" object:@"1"];
    [self addBarButton];
    //游客登录模式下进行查看天气
    UIAlertController *al = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"请点击右上角图标去搜索您关心的城市吧" preferredStyle:UIAlertControllerStyleAlert];
    
    [al addAction:[UIAlertAction actionWithTitle:@"不忙，一会再去" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [al addAction:[UIAlertAction actionWithTitle:@"直接去搜索" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
        [cityPickerVC setDelegate:self];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
            
        }];
        
    }]];
    
    [self presentViewController:al animated:YES completion:^{
    }];

}
- (void)viewWillDisappear:(BOOL)animated {
    self.parentViewController.navigationItem.rightBarButtonItem = nil;
    self.parentViewController.navigationItem.leftBarButtonItem = nil;
    self.parentViewController.navigationItem.titleView = nil;
}

#pragma mark- 网络加载小菊花现示
- (void)showProgressWithMessage:(NSString *)message {
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progress.mode = MBProgressHUDModeIndeterminate;
    progress.labelText = message;
    [progress show:YES];
}
- (void)hideProgress {
    if (progress) {
        [progress hide:YES];
    }
}
#pragma mark 通知中心实现的方法
- (void)getNotification:(NSNotification *)sender {
    NSArray *arra = sender.object;
    //请求数据前移除emptyDataView
    if (emptyDataView) {
        [emptyDataView removeFromSuperview];
    }
    
    [self showProgressWithMessage:@"正在加载数据，请稍候......."];
    [DataAccess getDataWithCityName:arra[0] requestCode:0 callbackDelegate:self];
    
    
    NSLog(@"%@",arra);
}
- (void)addBarButton {
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtn_touch)];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"添加城市" style:UIBarButtonItemStylePlain target:self action:@selector(addBtn_touch)];
    [barButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:13], NSFontAttributeName ,[ UIColor blackColor ],NSForegroundColorAttributeName , nil] forState:UIControlStateNormal];
    
    
    
    //从单例中取出存到里面的登录成功后的个人信息
    NSUserDefaults *userdefults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userdefults objectForKey:@"UserHeaderImage"];
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dict[@"figureurl_qq_2"]]] placeholderImage:[UIImage imageNamed:@"xiaoren"]];
    leftImageView.layer.cornerRadius = 15;
    leftImageView.clipsToBounds = YES;
    leftImageView.userInteractionEnabled = YES;
    //注册手势，并添加手势到leftImageView上
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap_touch)];
    [leftImageView addGestureRecognizer:tap];
    
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:leftImageView];
    
    
    self.parentViewController.navigationItem.rightBarButtonItem = barButton;
    self.parentViewController.navigationItem.leftBarButtonItem = leftBarbutton;
}

#pragma mark 程序执行结束，移除通知中心
- (void)dealloc
{
    //移除指定的通知中心
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"leftData" object:nil];
}
- (void)tap_touch {
   
    //点击收藏后左侧界面推出
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    YRSideViewController *sideViewController = [delegate sideViewController];
    sideViewController.leftViewShowWidth = 280;
    [sideViewController setRootViewMoveBlock:^(UIView *rootView, CGRect orginFrame, CGFloat xoffset) {
        
        LeftViewController *left = [[LeftViewController alloc] init];
        left.selectDelegate = self;
        //使用简单的平移动画
        rootView.frame=CGRectMake(xoffset, orginFrame.origin.y, orginFrame.size.width, orginFrame.size.height);
    }];
    [sideViewController showLeftViewController:true];
}
- (void)addBtn_touch {
    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
    [cityPickerVC setDelegate:self];
    
//    cityPickerVC.locationCityID = @"1400010000";
    //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
}
#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{
    //    [self.cityPickerButton setTitle:city.cityName forState:UIControlStateNormal];
    NSLog(@"%@  === %@",city.cityID,city.pinyin);
    cityPinyin = city.pinyin;
    
    NSString *shortName = city.shortName;
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:shortName];
    [arr addObject:city.pinyin];
    NSLog(@"%@",arr);
    
    
    //设置默认城市，第一次进行设置
    NSUserDefaults *userdefults = [NSUserDefaults standardUserDefaults];
    
    [userdefults setObject:arr forKey:@"FIRST"];
    
    for (int i = 0; i < shortNameArray.count; i ++) {
        
        NSArray *arrTmp = shortNameArray[i];
        
        if ([arrTmp[0] isEqualToString:city.shortName]) {
            [shortNameArray removeObjectAtIndex:i];
            
        }
        
    }
    [shortNameArray insertObject:arr atIndex:0];
    NSLog(@"========%@=============",shortNameArray);
    
    //请求数据前移除emptyDataView
    if (emptyDataView) {
        [emptyDataView removeFromSuperview];
    }
    
    
    [self showProgressWithMessage:@"正在加载数据，请稍候......."];
    [DataAccess getDataWithCityName:cityPinyin requestCode:0 callbackDelegate:self];
    
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark- 接收从leftViewController中返回的数据
- (void)callbackPinyin:(NSString *)cityNamePinyin {
    
    NSLog(@"%@",cityNamePinyin);
    
    //请求数据前移除emptyDataView
    if (emptyDataView) {
        [emptyDataView removeFromSuperview];
    }
    [self showProgressWithMessage:@"正在加载数据，请稍候......."];
    [DataAccess getDataWithCityName:cityNamePinyin requestCode:0 callbackDelegate:self];
}

- (void)callBackWithData:(id)data requestCode:(NSInteger)requestCode
{
    
    Zero *zero = [[Zero alloc] init];
    zero = data;
    //实现一个界面可以有多个城市的天气
//        for (int i = 0; i < arrayCityM.count; i ++) {
//            
//            Zero *zeroTmp = arrayCityM[i];
//            
//            if ([zeroTmp.city isEqualToString:zero.city]) {
//                [arrayCityM removeObjectAtIndex:i];
//            }
//            
//        }
//    [arrayCityM insertObject:zero atIndex:0];
    
    
    
    if (arrayCityM.count == 0) {
        [arrayCityM addObject:zero];
    }
    else {
        [arrayCityM replaceObjectAtIndex:0 withObject:zero];
    }

    
    [self hideProgress];
    
    [maintableView reloadData];
}

- (void)callBackWithErrorCode:(NSInteger)code message:(NSString *)message innerError:(NSError *)error requestCode:(NSInteger)requestCode {
    
    
    UIAlertController *alerView = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"网络或数据返回错误" preferredStyle:UIAlertControllerStyleAlert];
    [alerView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [progress hide:YES];
        
        
    }]];
    [self presentViewController:alerView animated:YES completion:^{
    }];

//    if (emptyDataView) {
//        emptyDataView.lblMessage.text = @"出错啦！";
//        emptyDataView.lblDescription.text = @"请点击按钮重新加载数据";
//        
//        [self.view addSubview:emptyDataView];
//    }
}

#pragma mark 添加tableView
- (void)addTableView {
    maintableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    maintableView.delegate = self;
    maintableView.dataSource = self;
    maintableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"雨背景"]];
    maintableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    maintableView.backgroundColor = [UIColor clearColor];
    //去除cell间的分割线
    maintableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [maintableView registerNib:[UINib nibWithNibName:@"NowWeatherTableViewCell" bundle:nil] forCellReuseIdentifier:@"NOW_CELL"];
    [maintableView registerNib:[UINib nibWithNibName:@"FirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"FIRST_CELL"];
    [maintableView registerNib:[UINib nibWithNibName:@"QulityTableViewCell" bundle:nil] forCellReuseIdentifier:@"QULITY_CELL"];
    
    [self.view addSubview:maintableView];
    
    //上拉刷新
    maintableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"Loading...");
        [self performSelector:@selector(loadCompleted) withObject:nil afterDelay:3];
    }];
    
}
- (void)loadCompleted
{
    
    [maintableView.mj_header endRefreshing];
    
    //    [mainTableView.header endEditing:NO];
}


#pragma mark 头视图设置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    Zero *zero = arrayCityM[section];
    HeaderView *view = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) Zero:zero] ;
    NSLog(@"headerView");
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200;
}
//#pragma mark 脚视图设置
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 10;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 10)];
//    view.layer.cornerRadius = 10;
//    view.backgroundColor = [UIColor lightGrayColor];
//    return view;
//}
#pragma mark tableView代理实现方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return arrayCityM.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Zero *zeroItem = arrayCityM[section];
    
    
    return zeroItem.daily.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        FirstTableViewCell *cell = (FirstTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FIRST_CELL" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
//        Zero *zero = arrayCityM[indexPath.section];
        //点击cell后颜色的变化
        cell.selectedBackgroundView = view;
        [cell.btn1 addTarget:self action:@selector(btn1_touch:) forControlEvents:UIControlEventTouchUpInside];
        cell.btn1.tag = indexPath.section;
        [cell.btn2 addTarget:self action:@selector(btn2_touch:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
    }
    else {
    
            NowWeatherTableViewCell *cell = (NowWeatherTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NOW_CELL" forIndexPath:indexPath];
//            cell.backgroundColor = [UIColor colorWithRed:85/255.0f green:133/255.0f blue:193/255.0f alpha:1];
            cell.alpha = 0.2;
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor clearColor];
        
            //点击cell后颜色的变化
            cell.selectedBackgroundView = view;
            cell.backgroundColor = [UIColor clearColor];
            //    cell.alpha = 0.0;

        Zero *zero = arrayCityM[indexPath.section];
        DailyForecast *daily = zero.daily[indexPath.row];
        NSString *str = [NSString stringWithString:daily.txtDay];
        NSString *pinyin = [str mutableCopy];
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
        //去除音标
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripDiacritics, NO);
        NSArray *array = [pinyin componentsSeparatedByString:@" "];
        str = [array componentsJoinedByString:@""];
        NSString *url = [NSString stringWithFormat:@"http://php.weather.sina.com.cn/images/yb3/180_180/%@_0.png",str];
       
        [cell.weatherImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    
        cell.dateLabel.text = daily.date;
        cell.txtDayLabel.text = daily.txtDay;
        cell.tmpLabel.text = [NSString stringWithFormat:@"%ld~%ld℃",daily.min,daily.max];

        return cell;
    }
    return nil;
  
}

#pragma mark btn1的点击事件，跳转到详情界面
- (void)btn1_touch:(FirstTableViewCell *)sender {
    NSLog(@"btn1_touch");
    NSLog(@"=====================%ld====================",sender.tag);
    DetailInfoViewController *nextVC = [[DetailInfoViewController alloc] init];
    Zero *zero = arrayCityM[sender.tag];
    nextVC.zero = zero;
    [self.navigationController pushViewController:nextVC animated:YES];
}
#pragma mark btn2点击事件收藏该城市
- (void)btn2_touch:(FirstTableViewCell *)sender {
    NSLog(@"btn2_touch");
    //第二次进入时，直接点击收藏会崩溃，此处进行判断，如果数组为0 从单例中去除存的数组付给此处
    if (shortNameArray.count == 0) {
        NSUserDefaults *userdefults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *aa = [userdefults objectForKey:@"FIRST"];
        NSLog(@"%@",aa);
        [shortNameArray addObject:aa];
    }
    
//    Zero *zero = arrayCityM[sender.tag];
    NSArray *array = shortNameArray[sender.tag];
    NSLog(@"%@===========%@",array[1],array[0]);
//    [database deleteWeatherData:array[0]];
    BOOL has = NO;
    NSArray *arrayTmp = [[NSArray alloc] init];
    arrayTmp = [database weatherDatas];
    
    NSLog(@"%@",arrayTmp);
   
    for (int i = 0; i < arrayTmp.count; i ++) {
        NSArray *arr = arrayTmp[i];
        if ([arr[0] isEqualToString:array[1]]) {
            has = YES;
        }
    }
    if (!has) {
        
        UIAlertController *al = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"确定将此城市添加到收藏" preferredStyle:UIAlertControllerStyleAlert];
        
        [al addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [database insertInfoWithCityName:array[1] CityShortName:array[0]];
            
            //点击收藏后左侧界面推出
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            YRSideViewController *sideViewController = [delegate sideViewController];
            [sideViewController setRootViewMoveBlock:^(UIView *rootView, CGRect orginFrame, CGFloat xoffset) {
                //使用简单的平移动画
                rootView.frame=CGRectMake(xoffset, orginFrame.origin.y, orginFrame.size.width, orginFrame.size.height);
            }];
            [sideViewController showLeftViewController:true];
            
        }]];
        [self presentViewController:al animated:YES completion:^{
        }];
        
        
    }
    else {
        
        UIAlertController *al = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"您已经收藏该城市" preferredStyle:UIAlertControllerStyleAlert];
        
        [al addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }]];
        [self presentViewController:al animated:YES completion:^{
        }];
    }
    
    
   
    
}




@end
