//
//  ViewController.m
//  Buy568
//  首页
//  Created by echo23 on 15/9/25.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "ViewController.h"
#import "CompanyService.h"
#import "Company.h"
#import "RecommendCompanyCollectionViewCell.h"
#import "CompanyTypeTableViewCell.h"
#import "CompanyDetailInfoViewController.h"
#import "CompanyTypeViewController.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UIView *headV;
@property (nonatomic,strong) UICollectionView *collectionV;
@property (nonatomic,strong) NSArray *recommendCompanyArry;//存放推荐店铺信息的数组
@property (nonatomic,strong) NSArray *scrollADCompanyArry;//存放可滚动广告展示信息的数组
@property (nonatomic,strong) NSArray *companyTypeArry;//存放店铺分类信息的数组
@property (nonatomic,strong) UIPageControl *pageC;
@property (nonatomic,assign) NSInteger section;//表示点击打开或闭合该块的块号
@property (nonatomic,assign) int company_id;//用来存放Button点击所获取的company_id
@property (nonatomic,strong) CompanyType *comType;//用来存放tableView的section的headView所点击的CompanyType对象
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.section = -1;
    self.recommendCompanyArry = [NSArray array];
    self.companyTypeArry = [NSArray array];
    [self addNavigationBar];
    CompanyService *comService = [[CompanyService alloc] init];
    __weak typeof(self) MySelf = self;
    //获取推荐店铺信息
    [comService getRecommendCompany:2 success:^(NSArray *companyArry) {
        MySelf.recommendCompanyArry = companyArry;
        //[MySelf.collectionV reloadData];
        [self addheadViewAnd];
        [SVProgressHUD dismiss];
    }];
    //获取可滚动广告展示信息
    [comService getScrollADCompanyObject:2 success:^(NSArray *companyArry) {
        MySelf.scrollADCompanyArry = companyArry;
        [MySelf addScrollViewOnHeadV:MySelf.scrollADCompanyArry];
        [SVProgressHUD dismiss];
    }];
    //获取店铺分类信息
    [comService getCompanyTypeObjects:2 success:^(NSArray *companyTypeArry) {
        MySelf.companyTypeArry = companyTypeArry;
        [MySelf.tableView reloadData];
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
//添加headview
-(void)addheadViewAnd{
    //headView上面分为两部分，首先上半部分是UICollectionView，下部分是scrollview
    _headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
    _headV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //创建一个UICollectionView流布局
    UICollectionViewFlowLayout *cvf = [[UICollectionViewFlowLayout alloc] init];
    //创建一个UICollectionView
    _collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 15, ScreenWidth-30, 200) collectionViewLayout:cvf];
    _collectionV.backgroundColor = [UIColor clearColor];
    [_collectionV registerClass:[RecommendCompanyCollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    [_headV addSubview:_collectionV];
    
    _tableView.tableHeaderView = _headV;//把_headV添加到tableview的headview上
}
//添加scrollview
-(void)addScrollViewOnHeadV:(NSArray *)comArry{
    //创建一个ScrollView
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 230, ScreenWidth, 70)];
    scrollV.delegate = self;//为scrollview添加代理
    scrollV.pagingEnabled = YES;//设置scrollview为整页滚动
    scrollV.showsHorizontalScrollIndicator = NO;//设置scrollview的水平滚动条消失
    scrollV.showsVerticalScrollIndicator = NO;//设置scrollview的垂直滚动条消失
    [_headV addSubview:scrollV];
    [scrollV setContentSize:CGSizeMake(comArry.count*ScreenWidth, 70)];
    for(int i = 0; i < comArry.count; i++){
        Company *company = comArry[i];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, 70)];
        [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerURL,company.company_ad]] placeholderImage:[UIImage imageNamed:@"grzx_topbg.png"]];
        imageV.tag = 30+i;
        [scrollV addSubview:imageV];
    }
    
    //添加UIPageControl
    _pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(137.5, 280, 100, 20)];
    _pageC.currentPage = 0;//设置当前页数为0
    _pageC.numberOfPages = comArry.count;//设置总页数
    [self.headV addSubview:_pageC];

    
}

#pragma tableView-代理
//设置块数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.companyTypeArry.count;
}
//设置块内行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CompanyType *comT = self.companyTypeArry[section];
    if(comT.isClose)
        return 0;
    NSArray *arry = comT.small_company_type;
    return arry.count;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    CompanyType *comT = self.companyTypeArry[indexPath.section];
    SmallCompanyType *smallT = comT.small_company_type[indexPath.row];
    UILabel *titleL = (UILabel *)[cell viewWithTag:50];
    titleL.text = smallT.company_type_name;
    //代码解决Cell复用问题
//    for (UIView *view in cell.contentView.subviews) {
//        if (view.tag == 90) {
//            [view removeFromSuperview];
//        }
//    }
//    for(int i = 0;i<smallT.company.count;i++){
//        Company *com = smallT.company[i];
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.backgroundColor = [UIColor clearColor];
//        button.frame = CGRectMake(117+76*i, 10, 76, 30);
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
//        button.tag = 90;
//        [button setTitle:com.company_name forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(selectCompanyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.contentView addSubview:button];
//    }
    //storyboard 解决Cell复用问题
    for(UIButton *button in cell.contentView.subviews){
        if(button.tag == 51||button.tag == 52||button.tag == 53){
            [button setTitle:@"" forState:UIControlStateNormal];
        }
    }
    for(int i = 0;i<smallT.company.count;i++){
        Company *com = smallT.company[i];
        UIButton *button = (UIButton *)[cell viewWithTag:51+i];
        [button setTitle:com.company_name forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectCompanyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
//返回section的headview的高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0;
}
//返回section的headview
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //获取相应的对象
    CompanyType *comType = self.companyTypeArry[section];
    UIView *secHeadV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    secHeadV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIImageView *iconV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    [iconV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerURL,comType.company_type_ico]] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
    [secHeadV addSubview:iconV];
    
//    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 100, 20)];
//    titleL.text = comType.company_type_name;
//    [secHeadV addSubview:titleL];
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.frame = CGRectMake(40, 0, 280, 40);
    [titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 200)];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleBtn.backgroundColor = [UIColor clearColor];
    [titleBtn setTitle:comType.company_type_name forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(headViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.tag = section +10;
    [secHeadV addSubview:titleBtn];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(ScreenWidth-40, 5, 30, 30);
    CompanyType *comT = self.companyTypeArry[section];
    if(!comT.isClose)
        [button setImage:[UIImage imageNamed:@"arrow_up.png"] forState:UIControlStateNormal];
    else
        [button setImage:[UIImage imageNamed:@"arrow_down.png"] forState:UIControlStateNormal];
    button.tag = section+100;
    [button addTarget:self action:@selector(openSectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [secHeadV addSubview:button];
    return secHeadV;
}
#pragma collectionView-代理
//设置块内行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.recommendCompanyArry.count;
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RecommendCompanyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    Company *company = self.recommendCompanyArry[indexPath.row];
    UIImageView *imageV = (UIImageView *)[cell viewWithTag:20];
    NSString *imgName = company.company_ico;
    
    if ([imgName isEqual:[NSNull null]] ||imgName.length == 0 || [imgName isEqualToString:@"<null>"] || imgName == nil ) {
        imageV.image = [UIImage imageNamed:@"net_error_icon.png"];
    }else{
        [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerURL,company.company_ico]] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
    }
    UILabel *titleL = (UILabel *)[cell viewWithTag:21];
    titleL.text = company.company_name;
    return cell;
}
//cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(112, 30);
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 4.0;
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 4.5;
}
//点击选择
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"CompanyDetailInfoID" sender:self];
}
#pragma scrollView-代理
//结束滚动触发的代理事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/scrollView.frame.size.width;
    _pageC.currentPage = page;
}

#pragma button事件处理
//点击店铺分类信息店铺名称所触发的点击事件
-(void)selectCompanyBtnClick:(UIButton *)button{
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
    NSIndexPath *index = [_tableView indexPathForCell:cell];
    CompanyType *CT = self.companyTypeArry[index.section];
    SmallCompanyType *smallT = CT.small_company_type[index.row];
    Company *com = smallT.company[button.tag-51];
    self.company_id = com.company_id;
    [self performSegueWithIdentifier:@"CompanyDetailInfoIDForBtn" sender:self];
}
//section headView点击事件
-(void)headViewBtnClick:(UIButton *)button{
    CompanyType *CT = self.companyTypeArry[button.tag - 10];
    self.comType = CT;
    [self performSegueWithIdentifier:@"CompanyTypeID" sender:self];
}
//点击tableSection控制当前块张开或闭合
-(void)openSectionBtnClick:(UIButton *)button{
    CompanyType *comT = self.companyTypeArry[button.tag-100];
    if(!comT.isClose){
        comT.isClose = YES;
    }else{
        comT.isClose = NO;
    }
    [_tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"CompanyDetailInfoID"]){
        CompanyDetailInfoViewController *comDetailInfoVC = segue.destinationViewController;
        NSIndexPath *indexPath = [[_collectionV indexPathsForSelectedItems] lastObject];
        Company *company = self.recommendCompanyArry[indexPath.row];
        comDetailInfoVC.company_id = company.company_id;
    }else if ([segue.identifier isEqualToString:@"CompanyDetailInfoIDForBtn"]){
        CompanyDetailInfoViewController *comDetailInfoVC = segue.destinationViewController;
        comDetailInfoVC.company_id = self.company_id;
    }else if ([segue.identifier isEqualToString:@"CompanyTypeID"]){
        CompanyTypeViewController *comTypeVC = segue.destinationViewController;
        comTypeVC.companyType = self.comType;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
