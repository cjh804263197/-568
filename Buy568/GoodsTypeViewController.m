//
//  GoodsTypeViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/7.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "GoodsTypeViewController.h"
#import "GoodService.h"
#import "Goods.h"
#import "GoodsTypeListTableViewController.h"


@interface GoodsTypeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *listGoodsArry;//该分类下的所有商品数组
@property (nonatomic,assign) BOOL isHidden;
@property (nonatomic,strong) GoodService *goodS;
@property (nonatomic,assign) int listOrder;//选择栏分类
@property (nonatomic,assign) int pageNum;//当前页数
@property (nonatomic,assign) BOOL isFooterRefresh;//是否是上拉加载
@property (nonatomic,strong) GoodsTypeListTableViewController *goodsTypeListTVC;
@property (nonatomic,strong) UIView *bgView;
@end

@implementation GoodsTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidden = YES;
    self.listOrder = 1;
    self.pageNum = 1;
    self.listGoodsArry = [NSMutableArray array];
    self.goodS = [[GoodService alloc] init];
    __weak typeof(self) MySelf = self;
    [self.goodS getGoodsTypeList:self.city_id goodsTypePid:self.goods_type_pid goodsTypeId:self.goods_type_id listOrder:self.listOrder pageNum:self.pageNum pageSize:10 success:^(NSArray *goodsArry, NSArray *goodsListArry){
        MySelf.listGoodsArry = (NSMutableArray *)goodsArry;
        [MySelf.tableView reloadData];
        [SVProgressHUD dismiss];
        MySelf.goodsTypeListTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GoodsTypeListTableViewController"];
        MySelf.goodsTypeListTVC.view.frame = CGRectMake(ScreenWidth-100, 0, 100, 120);
        MySelf.goodsTypeListTVC.view.hidden = MySelf.isHidden;
        MySelf.goodsTypeListTVC.goodsListArry = goodsListArry;
        MySelf.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight-104)];
        MySelf.bgView.backgroundColor = [UIColor lightGrayColor];
        MySelf.bgView.alpha = 0.5;
        MySelf.bgView.hidden = MySelf.isHidden;
        [MySelf.bgView addSubview:MySelf.goodsTypeListTVC.view];
        [MySelf.view addSubview:MySelf.bgView];
    }];
    [self tableViewRefresh];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectGoodsType:) name:@"selectGoodsType" object:nil];
}
//用户选择所有分类后点击相应的分类所返回过来的分类号
-(void)selectGoodsType:(NSNotification *)notification{
    self.goods_type_id = [[notification object] intValue];
    __weak typeof(self) MySelf = self;
    [self.goodS getGoodsTypeList:self.city_id goodsTypePid:self.goods_type_pid goodsTypeId:self.goods_type_id listOrder:self.listOrder pageNum:1 pageSize:10 success:^(NSArray *goodsArry, NSArray *goodsListArry) {
        MySelf.listGoodsArry = (NSMutableArray *)goodsArry;
        [MySelf.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
    self.isHidden = YES;
    self.bgView.hidden = self.isHidden;
}
//TableView上拉加载
-(void)tableViewRefresh{
    //如果当前正在上拉刷新，就直接返回不作任何操作
    if(self.isFooterRefresh){
        return ;
    }
    __weak typeof(self) MySelf = self;
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        MySelf.isFooterRefresh = YES;
        MySelf.pageNum++;
        [MySelf.goodS getGoodsTypeList:MySelf.city_id goodsTypePid:MySelf.goods_type_pid goodsTypeId:MySelf.goods_type_id listOrder:MySelf.listOrder pageNum:MySelf.pageNum pageSize:10 success:^(NSArray *goodsArry, NSArray *goodsListArry) {
            [MySelf.listGoodsArry addObjectsFromArray:goodsArry];
            [MySelf.tableView reloadData];
            [MySelf tableViewRefreshEnd];
            [SVProgressHUD dismiss];
        }];
    }];
}
//结束上、下拉刷新
-(void)tableViewRefreshEnd{
    if (self.isFooterRefresh){
        self.isFooterRefresh = NO;
        [_tableView footerEndRefreshing];
    }
}
#pragma tableView-代理
//返回块内行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listGoodsArry.count;
}
//返回Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsCell" forIndexPath:indexPath];
    Goods *good = self.listGoodsArry[indexPath.row];
    UIImageView *imageV = (UIImageView *)[cell viewWithTag:10];
    [imageV sd_setImageWithURL:[NSURL URLWithString:good.goods_imgs] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
    UILabel *title = (UILabel *)[cell viewWithTag:11];
    UILabel *price = (UILabel *)[cell viewWithTag:12];
    UILabel *payNum = (UILabel *)[cell viewWithTag:13];
    UILabel *time = (UILabel *)[cell viewWithTag:14];
    
    title.text = good.goods_title;
    price.text = [NSString stringWithFormat:@"¥%0.0lf",good.goods_price];
    payNum.text = [NSString stringWithFormat:@"%d人付款",good.goods_sales];
    NSString *timeStr = [[good.goods_addtime componentsSeparatedByString:@" "] firstObject];
    time.text = timeStr;
    
    return cell;
}
//Cell选择代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Goods *good = self.listGoodsArry[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getGoodsIDNotification" object:[NSString stringWithFormat:@"%d",good.goods_id] userInfo:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma button-点击事件
//选择栏Button点击事件
- (IBAction)menuBtnClick:(UIButton *)sender {
    for(int i = 10;i < 14;i++){
        if(sender.tag == i){
            sender.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }else{
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            btn.backgroundColor = [UIColor whiteColor];
        }
    }
    //前三个Button刷新TableView
    if(sender.tag>=10&&sender.tag<=12){
        self.listOrder = (int)sender.tag-9;
        __weak typeof(self) MySelf = self;
        [self.goodS getGoodsTypeList:self.city_id goodsTypePid:self.goods_type_pid goodsTypeId:self.goods_type_id listOrder:self.listOrder pageNum:1 pageSize:10 success:^(NSArray *goodsArry, NSArray *goodsListArry) {
            MySelf.listGoodsArry = (NSMutableArray *)goodsArry;
            [MySelf.tableView reloadData];
            [SVProgressHUD dismiss];
        }];
    }else{
        if(self.isHidden){
            self.isHidden = NO;
            self.goodsTypeListTVC.view.hidden = self.isHidden;
            self.bgView.hidden = self.isHidden;
        }else{
            self.isHidden = YES;
            self.goodsTypeListTVC.view.hidden = self.isHidden;
            self.bgView.hidden = self.isHidden;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
