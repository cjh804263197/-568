//
//  BuyMainViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/5.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "BuyMainViewController.h"
#import "GoodService.h"
#import "GoodsType.h"
#import "GoodsDetailInfoViewController.h"

@interface BuyMainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *GoodsTypeArry;
@property (nonatomic,strong) NSIndexPath *selectIndexPath;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation BuyMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];//设置默认选中第一行
    self.GoodsTypeArry = [NSArray array];
    [self addNavigationBar];
    GoodService *goodS = [[GoodService alloc] init];
    __weak typeof(self) MySelf = self;
    //获取到左边列表数据
    [goodS getAllGoodsType:2 success:^(NSArray *GoodTypeArry) {
        MySelf.GoodsTypeArry = GoodTypeArry;
        [MySelf.tableView reloadData];
        [MySelf.collectionView reloadData];
        [SVProgressHUD dismiss];
    }];
   
}
//设置首页NavigationBar
-(void)addNavigationBar{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 30);
    [btn setImage:[UIImage imageNamed:@"downArrow.png"] forState:UIControlStateNormal];
    [btn setTitle:@"淮滨县" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 20);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *city_bar_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *scan_bar_btn = [[UIBarButtonItem alloc] init];
    scan_bar_btn.image = [UIImage imageNamed:@"saoyisao.png"];
    scan_bar_btn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = scan_bar_btn;
    self.navigationItem.leftBarButtonItem = city_bar_btn;
    
}
//设置当没有数据返回一个imageview
-(UIView *)addImageView{
    UIView *myView = [[UIView alloc] initWithFrame:self.collectionView.bounds];
    myView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.collectionView.bounds.size.width/2.0-50, self.collectionView.bounds.size.height/2.0-50, 100, 100)];
    imageV.image = [UIImage imageNamed:@"net_error_icon.png"];
    [myView addSubview:imageV];
    UILabel *tipL = [[UILabel alloc] initWithFrame:CGRectMake(self.collectionView.bounds.size.width/2.0-50, self.collectionView.bounds.size.height/2.0+55, 100, 60)];
    tipL.text = @"没有更多的数据，请稍后再试！";
    tipL.textColor = [UIColor lightGrayColor];
    tipL.textAlignment = NSTextAlignmentCenter;
    tipL.numberOfLines = 0;
    tipL.font = [UIFont systemFontOfSize:15.0];
    [myView addSubview:tipL];
    return myView;
}
#pragma tableView-代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.GoodsTypeArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsTypeCell" forIndexPath:indexPath];
    UILabel *titleL = (UILabel *)[cell viewWithTag:10];
    UIView *line = (UIView *)[cell viewWithTag:11];
    if(indexPath == self.selectIndexPath){
        cell.backgroundColor = [UIColor whiteColor];
        titleL.textColor = [UIColor redColor];
        line.hidden = NO;
    }else{
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        titleL.textColor = [UIColor blackColor];
        line.hidden = YES;
    }
    GoodsType *goodT = self.GoodsTypeArry[indexPath.row];
    titleL.text = goodT.goods_type_name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndexPath = indexPath;
    [tableView reloadData];
    [self.collectionView reloadData];
}

#pragma collectionView-代理
//设置块数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if(self.GoodsTypeArry.count!=0){
        return 1;
    }else{
        collectionView.backgroundView = [self addImageView];
        collectionView.backgroundView.hidden = NO;
        return 0;
    }
}
//设置块内行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        GoodsType *goodType = self.GoodsTypeArry[self.selectIndexPath.row];
        NSArray *goodArry = goodType.listgoods;
        if(goodArry.count == 0){
            collectionView.backgroundView = [self addImageView];
            collectionView.backgroundView.hidden = NO;
        }else{
            collectionView.backgroundView.hidden = YES;
        }
        return goodArry.count;
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCell" forIndexPath:indexPath];
    GoodsType *goodType = self.GoodsTypeArry[self.selectIndexPath.row];
    NSArray *goodArry = goodType.listgoods;
    Goods *good = goodArry[indexPath.row];
    UIImageView *imageV = (UIImageView *)[cell viewWithTag:10];
    imageV.layer.masksToBounds = YES;
    imageV.layer.cornerRadius = 5.0;
    NSString *imgName = good.goods_imgs;
    if ([imgName isEqual:[NSNull null]] ||imgName.length == 0 || [imgName isEqualToString:@"<null>"] || imgName == nil ) {
        imageV.image = [UIImage imageNamed:@"net_error_icon.png"];
    }else{
        [imageV sd_setImageWithURL:[NSURL URLWithString:imgName] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
    }
    UILabel *titleL = (UILabel *)[cell viewWithTag:11];
    titleL.text = good.goods_name;
    return cell;
}
//返回collectionView的HeadView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
            GoodsType *goodType = self.GoodsTypeArry[self.selectIndexPath.row];
            UICollectionReusableView *collectionRV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ADScrollViewHeadView" forIndexPath:indexPath];
            UIScrollView *scrollV = (UIScrollView *)[collectionRV viewWithTag:50];
            [scrollV setContentSize:CGSizeMake(collectionRV.bounds.size.width*goodType.add_goods.count, collectionRV.bounds.size.height)];
            for(int i = 0; i < goodType.add_goods.count; i++){
                Goods *good = goodType.add_goods[i];
                UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(collectionRV.bounds.size.width*i, 0, collectionRV.bounds.size.width, collectionRV.bounds.size.height)];
                [imageV sd_setImageWithURL:[NSURL URLWithString:good.goods_ad] placeholderImage:[UIImage imageNamed:@"grzx_topbg.png"]];
                imageV.tag = 30+i;
                [scrollV addSubview:imageV];
            }
            return collectionRV;
}
//返回collectionView的HeadView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    GoodsType *goodType = self.GoodsTypeArry[self.selectIndexPath.row];
    if(goodType.add_goods.count == 0){
        return CGSizeMake(0, 0);
    }else{
        return CGSizeMake(275, 80);
    }
}
//点击选择
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"GoToGoodsDeatailInfo" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"GoToGoodsDeatailInfo"]){
        GoodsType *goodType = self.GoodsTypeArry[self.selectIndexPath.row];
        NSArray *goodArry = goodType.listgoods;
        NSIndexPath *index = [[self.collectionView indexPathsForSelectedItems] lastObject];
        Goods *good = goodArry[index.row];
        GoodsDetailInfoViewController *goodsDIVC = segue.destinationViewController;
        goodsDIVC.goods_id = good.goods_id;
    }
}


@end
