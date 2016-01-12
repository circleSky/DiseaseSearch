//
//  DetailInfoViewController.m
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/10.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import "DetailInfoViewController.h"

#import "HeaderView.h"
#import "DetailTableViewCell.h"

#import "CityInfoViewController.h"

#import "MapViewController.h"

@interface DetailInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *maintableView;
}
@end

@implementation DetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:238/255.0 green:246/255.0 blue:231/255.0 alpha:1];
    self.title = [NSString stringWithFormat:@"%@市天气详情",_zero.city];
    [self creatTableView];
    
    

}

- (void)viewDidAppear:(BOOL)animated {
    UIBarButtonItem *btnToNextPage = [[UIBarButtonItem alloc] initWithTitle:@"地图详情" style:UIBarButtonItemStylePlain target:self action:@selector(btnToNextPage_touch)];
    self.navigationItem.rightBarButtonItem = btnToNextPage;
}
- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:231/255.0 green:250/255.0 blue:255/255.0 alpha:1];
    
    
}

- (void)btnToNextPage_touch {
    MapViewController *mapV = [[MapViewController alloc] init];
    
    mapV.lat = _zero.lat;
    mapV.lon = _zero.lon;
    [self.navigationController pushViewController:mapV animated:YES];
}

//- (void)btnToNextPage_touch {
//    CityInfoViewController *next = [[CityInfoViewController alloc]init];
//    next.zero = _zero;
//    
//    [self.navigationController pushViewController:next animated:YES];
//}
#pragma mark 添加tableView
- (void)creatTableView {
    maintableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    maintableView.delegate = self;
    maintableView.dataSource = self;
    maintableView.backgroundColor = [UIColor colorWithRed:238/255.0 green:246/255.0 blue:231/255.0 alpha:1];
    [maintableView registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"DETAIL_CELL"];
    [self.view addSubview:maintableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 63;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = @[@"晨练指数",@"紫外线强度",@"旅游指数",@"穿衣指数",@"感冒指数",@"舒适度指数",@"洗车指数"];
    DetailTableViewCell *cell = (DetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DETAIL_CELL" forIndexPath:indexPath];
    cell.titlelabel.text = array[indexPath.row];
    cell.iamgeViewF.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row + 10]];
    switch (indexPath.row) {
        case 0:
        {
            cell.otherLabel.text = _zero.sportbrf;
            cell.introLabel.text = _zero.sporttxt;
        }
            break;
        case 1:
        {
            cell.otherLabel.text = _zero.uvbrf;
            cell.introLabel.text = _zero.uvtxt;
        }
            break;
        case 2:
        {
            cell.otherLabel.text = _zero.travbrf;
            cell.introLabel.text = _zero.travbrf;
        }
            break;
        case 3:
        {
            cell.otherLabel.text = _zero.drsgbrf;
            cell.introLabel.text = _zero.drsgtxt;
        }
            break;
        case 4:
        {
            cell.otherLabel.text = _zero.flubrf;
            cell.introLabel.text = _zero.flutxt;
        }
            break;
        case 5:
        {
            cell.otherLabel.text = _zero.comfbrf;
            cell.introLabel.text = _zero.comftxt;
        }
            break;
        case 6:
        {
            cell.otherLabel.text = _zero.cwbrf;
            cell.introLabel.text = _zero.cwtxt;
        }
            break;
            
        default:
            break;
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
#pragma mark 头视图设置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        HeaderView *view = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) Zero:_zero] ;
        NSLog(@"headerView");
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 200;
    }
    return 8;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
