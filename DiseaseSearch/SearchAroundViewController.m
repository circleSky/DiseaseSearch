//
//  SearchAroundViewController.m
//  DiseaseSearch
//
//  Created by 吴卓 on 15/12/29.
//  Copyright © 2015年 吴卓. All rights reserved.
//

#import "SearchAroundViewController.h"

#import "SearchAroundCollectionViewCell.h"


#define SCR_H [UIScreen mainScreen].bounds.size.height
#define SCR_W [UIScreen mainScreen].bounds.size.width

@interface SearchAroundViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *maincollectionView;
    NSArray *array;
}
@end

@implementation SearchAroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    array = @[@"汽车服务",@"汽车销售",@"汽车维修",@"摩托车服务",@"餐饮服务",@"购物服务",@"生活服务",@"体育休闲服务",@"医疗保健服务",@"住宿服务",@"风景名胜",@"商务住宅",@"政府机构及社会团体",@"科教文化服务",@"交通设施服务",@"金融保险服务",@"公司企业",@"道路附属设施",@"地名地址信息",@"公共设施"];
    /**
     汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
     // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
     // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
     
     */
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 50, 30)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btn_touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self creatCollectionView];
}

- (void)btn_touch {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark- 创建collectionView
- (void)creatCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    
    maincollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H) collectionViewLayout:flowLayout];
    maincollectionView.backgroundColor = [UIColor clearColor];
    maincollectionView.delegate = self;
    maincollectionView.dataSource = self;
    [self.view addSubview:maincollectionView];
    [maincollectionView registerNib:[UINib nibWithNibName:@"SearchAroundCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"COLLECTION_CELL"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchAroundCollectionViewCell *cell = (SearchAroundCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"COLLECTION_CELL" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.label.text = array[indexPath.row];
    return cell;
}
#pragma mark 设置cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return CGSizeMake((SCR_W - 6) / 4, 50);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%@",array[indexPath.row]);
    NSUserDefaults *userdefults = [NSUserDefaults standardUserDefaults];
    [userdefults setObject:array[indexPath.row] forKey:@"TYPE"];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate cllBackDataWithcategory:array[indexPath.row]];
        
    }];
}

@end
