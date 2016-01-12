
//  LeftViewController.m
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/12.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import "LeftViewController.h"
#import "DatabaseControl.h"
#import "UIImageView+WebCache.h"
#import "LeftTableViewCell.h"
#import "AppDelegate.h"
#import "DataAccess.h"
#import "Zero.h"
#import "DailyForecast.h"
#import "HeaderView.h"
//刷新
#import <MJRefresh.h>
#import "YRSideViewController.h"
#import "DetailInfoViewController.h"
#import "RootViewController.h"
#import "NetWorkCallbackDelegate.h"
#import <TencentOpenAPI/TencentOAuth.h>

#import <UIImageView+WebCache.h>

#define SCR_W [UIScreen mainScreen].bounds.size.width
#define SCR_H [UIScreen mainScreen].bounds.size.height

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource,NetWorkCallbackDelegate>
{
    UITableView *maintableView;
    NSMutableArray *arrayM;
    DatabaseControl *database;
    BOOL _editing;
    //选中的第几个cell的button
    NSInteger *count;
    
    UIImageView *headerImageView;
    UILabel *nameLabel;
   
}
@end

@implementation LeftViewController



- (void)viewDidLoad {
    [super viewDidLoad];
   
    arrayM = [[NSMutableArray alloc] init];
    database = [[DatabaseControl alloc] init];
    //注册通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotification:) name:@"HEADER_IMAGEVIEW" object:nil];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = YES;
    maintableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self creatTableView];
    
    
}
#pragma mark- 通知中心实现的方法
- (void)getNotification:(NSNotification *)sender {
    [self creatUserHeaderImageView];
    
    
}
#pragma mark- 添加用户头像
- (void)creatUserHeaderImageView {
    NSUserDefaults *userdefults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userdefults objectForKey:@"UserHeaderImage"];
    NSLog(@"%@",dict);
    headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCR_W / 6, 10, SCR_W / 3, SCR_W / 3)];
    
    [headerImageView sd_setImageWithURL:[dict objectForKey:@"figureurl_qq_2"] placeholderImage:[UIImage imageNamed:@"xiaoren"]];
    headerImageView.layer.cornerRadius = SCR_W / 6;
    headerImageView.layer.borderColor = [[UIColor orangeColor] CGColor];
    headerImageView.layer.borderWidth = 2;
    headerImageView.clipsToBounds = YES;
    [self.view addSubview:headerImageView];
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCR_W / 6, CGRectGetMaxY(headerImageView.frame), SCR_W / 3, 40)];
    nameLabel.backgroundColor = [UIColor redColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    NSString *str = [dict objectForKey:@"nickname"];
    //        NSURL *iamgeUrl = [dict objectForKey:@"figureurl_qq_2"];
    //        NSData *data = [NSData dataWithContentsOfURL:iamgeUrl];
    //        headerImageView.image = [UIImage imageWithData:data];
    
    
    nameLabel.text = str;
    [self.view addSubview:nameLabel];
}
- (void)creatTableView
{
    maintableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    maintableView.delegate = self;
    maintableView.dataSource = self;
    maintableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:maintableView];
    
    [maintableView registerNib:[UINib nibWithNibName:@"LeftTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL_ID"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayM.count;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine"]];
    return imageV;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LeftTableViewCell *cell = (LeftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CELL_ID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    NSArray *arra = arrayM[indexPath.row];
    cell.nameLabel.text = arra[1];
    cell.editing = YES;
    [cell.btn addTarget:self action:@selector(btn_touch:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn.tag = indexPath.row;

    return cell;
}
- (void)btn_touch:(LeftTableViewCell *)sender {
    [database deleteWeatherData:[arrayM[sender.tag] objectAtIndex:1]];
    [arrayM removeObjectAtIndex:sender.tag];
    [maintableView reloadData];
//    [maintableView deleteRowsAtIndexPaths:@[sender.tag] withRowAnimation:UITableViewRowAnimationTop];
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSArray *arr = arrayM[indexPath.row];
//    NSLog(@"%@",arr[0]);
//    [DataAccess getDataWithCityName:arr[0] requestCode:2 callbackDelegate:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"leftData" object:arr];
    
    YRSideViewController *slide = (YRSideViewController*)(self.parentViewController.parentViewController);
    [slide hideSideViewController:YES];
    NSArray *arrayy = [[NSArray alloc] init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TAB" object:arrayy];
    
}
- (void)callBackWithData:(id)data requestCode:(NSInteger)requestCode {
    Zero *zero = data;
    
//    HeaderView *header = [[HeaderView alloc] initWithFrame:CGRectMake(-20, 0, 300, 200) Zero:zero];
//    view = header;
//    [maintableView reloadData];
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [database deleteWeatherData:[arrayM[indexPath.row] objectAtIndex:1]];
    [arrayM removeObjectAtIndex:indexPath.row];
    [maintableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}



- (void)viewWillAppear:(BOOL)animated
{
    // [self creatDeleteAndEditBtn];
    [self getDataFromSqlite3];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"您已收藏的城市" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = barButton;
    [self creatUserHeaderImageView];
   
}

- (void)getDataFromSqlite3
{
    arrayM = [[NSMutableArray alloc] init];
    NSArray *arrayBack = [[NSArray alloc] init];
    arrayBack = [database weatherDatas];
    NSLog(@"%@",arrayBack);
    [arrayM addObjectsFromArray:arrayBack];
   
    [maintableView reloadData];
}


@end
