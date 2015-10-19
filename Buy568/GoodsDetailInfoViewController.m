//
//  GoodsDetailInfoViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/6.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "GoodsDetailInfoViewController.h"
#import "GoodService.h"
#import "Goods.h"
#import "Shop.h"
#import "UserService.h"
#import "User.h"
#import "GoodsTypeViewController.h"
#import "ConfirmOrderViewController.h"
#import "Cart.h"

@interface GoodsDetailInfoViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) Goods *goods;
@property (nonatomic,strong) UIPageControl *pageC;
@property (nonatomic,strong) User *user;
@end

@implementation GoodsDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GoodService *goodS = [[GoodService alloc] init];
    __weak typeof(self) MySelf = self;
    [goodS getGoodsDetailInfo:self.goods_id success:^(Goods *goods) {
        MySelf.goods = goods;
        [MySelf addScrollHeadView:goods.goods_imgs_new];
        [MySelf.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getGoodsID:) name:@"getGoodsIDNotification" object:nil];
}
//通知的事件监听
-(void)getGoodsID:(NSNotification *)notification{
    self.goods_id = [[notification object] intValue];
    GoodService *goodS = [[GoodService alloc] init];
    __weak typeof(self) MySelf = self;
    [goodS getGoodsDetailInfo:self.goods_id success:^(Goods *goods) {
        MySelf.goods = goods;
        [MySelf addScrollHeadView:goods.goods_imgs_new];
        [MySelf.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
}
//添加headView图片展示
-(void)addScrollHeadView:(NSArray *)imgArry{
    //创建一个View用来承载scrollview和pageView
    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    //创建一个ScrollView
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    scrollV.delegate = self;//为scrollview添加代理
    scrollV.pagingEnabled = YES;//设置scrollview为整页滚动
    scrollV.showsHorizontalScrollIndicator = NO;//设置scrollview的水平滚动条消失
    scrollV.showsVerticalScrollIndicator = NO;//设置scrollview的垂直滚动条消失
    [scrollV setContentSize:CGSizeMake(imgArry.count*ScreenWidth, 200)];
    [headV addSubview:scrollV];
    for(int i = 0; i < imgArry.count; i++){
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, 200)];
        [imageV sd_setImageWithURL:[NSURL URLWithString:imgArry[i]] placeholderImage:[UIImage imageNamed:@"grzx_topbg.png"]];
        imageV.tag = 30+i;
        [scrollV addSubview:imageV];
    }
    
    //在scrollView上添加一个蒙版
    UIView *mengV = [[UIView alloc] initWithFrame:CGRectMake(0, 150, ScreenWidth, 50)];
    mengV.backgroundColor = [UIColor lightGrayColor];
    mengV.alpha = 0.6;
    [headV addSubview:mengV];
    //添加UIPageControl
    _pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(250, 10, 125, 30)];
    _pageC.currentPage = 0;//设置当前页数为0
    _pageC.numberOfPages = imgArry.count;//设置总页数
    [mengV addSubview:_pageC];
    
    _tableView.tableHeaderView = headV;
    
}
#pragma tableView-代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 1;
            break;
        default:
            return 2;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
        {
            if(indexPath.row == 0){
                cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsTitleCell" forIndexPath:indexPath];
                UILabel *goodTitleL = (UILabel *)[cell viewWithTag:10];
                goodTitleL.text = self.goods.goods_title;
                UIButton *collectBtn = (UIButton *)[cell viewWithTag:11];
                [collectBtn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
            }else if (indexPath.row == 1){
                cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsTypeCell" forIndexPath:indexPath];
                UILabel *goodTypeTitleL = (UILabel *)[cell viewWithTag:10];
                goodTypeTitleL.text = self.goods.goods_typename;
                
            }else if (indexPath.row == 2){
                cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsPriceAndNumberCell" forIndexPath:indexPath];
                UILabel *goodPriceTitleL = (UILabel *)[cell viewWithTag:10];//现价
                UILabel *goodMarketPriceTitleL = (UILabel *)[cell viewWithTag:11];//市场价
                UILabel *goodNumTitleL = (UILabel *)[cell viewWithTag:13];//数量
                UIButton *minusBtn = (UIButton *)[cell viewWithTag:12];//减
                UIButton *addBtn = (UIButton *)[cell viewWithTag:14];//加
                
                goodPriceTitleL.text = [NSString stringWithFormat:@"%0.1lf元",self.goods.goods_price];
                goodMarketPriceTitleL.text = [NSString stringWithFormat:@"%0.1lf元",self.goods.goods_marke_price];
                //给市场价上面添加一条删除线
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, goodMarketPriceTitleL.bounds.size.height/2.0, goodMarketPriceTitleL.bounds.size.width, 1)];
                line.backgroundColor = [UIColor blackColor];
                [goodMarketPriceTitleL addSubview:line];
                
                if([goodNumTitleL.text intValue] == 1){
                    [minusBtn setBackgroundImage:[UIImage imageNamed:@"jian_gray.png"] forState:UIControlStateNormal];
                    minusBtn.enabled = NO;
                }else{
                    [minusBtn setBackgroundImage:[UIImage imageNamed:@"jian.png"] forState:UIControlStateNormal];
                    minusBtn.enabled = YES;
                }
                if([goodNumTitleL.text intValue] == self.goods.goods_number){
                    [addBtn setBackgroundImage:[UIImage imageNamed:@"plus_gray.png"] forState:UIControlStateNormal];
                    addBtn.enabled = NO;
                }else{
                    [addBtn setBackgroundImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
                    addBtn.enabled = YES;
                }
                [minusBtn addTarget:self action:@selector(opBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [addBtn addTarget:self action:@selector(opBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
            }else{
                cell = [tableView dequeueReusableCellWithIdentifier:@"BuyGoodsGetCreditCell" forIndexPath:indexPath];
                UILabel *getCridetTitleL = (UILabel *)[cell viewWithTag:10];
                getCridetTitleL.text = [NSString stringWithFormat:@"购买可以获得%0.1lf积分",self.goods.goods_price];
                
            }
        }
            break;
        case 1:
        {
            if(indexPath.row == 0){
                cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsIntroductionTitleCell" forIndexPath:indexPath];
            }else{
                cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsIntroductionCell" forIndexPath:indexPath];
                UILabel *goodsIntroTitleL = (UILabel *)[cell viewWithTag:10];
                goodsIntroTitleL.text = self.goods.goods_content;
            }
        }
            break;
        case 2:
        {
            if(indexPath.row == 0){
                cell = [tableView dequeueReusableCellWithIdentifier:@"ShopIntroductionTitleCell" forIndexPath:indexPath];
                //张开与闭合按钮
                UIButton *isCloseBtn = (UIButton *)[cell viewWithTag:10];
                [isCloseBtn addTarget:self action:@selector(isCloseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                cell = [tableView dequeueReusableCellWithIdentifier:@"ShopIntroductionCell" forIndexPath:indexPath];
                UILabel *shopNameTitleL = (UILabel *)[cell viewWithTag:10];//店铺名称
                UILabel *shopAddressTitleL = (UILabel *)[cell viewWithTag:11];//店铺地址
                Shop *shop = self.goods.contentShop;
                shopNameTitleL.text = shop.shop_name;
                shopAddressTitleL.text = shop.shop_address;
            }
        }
            break;
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ContactAndPhoneCell" forIndexPath:indexPath];
            UILabel *contactNameTitleL = (UILabel *)[cell viewWithTag:10];//联系人
            UILabel *contactPhoneTitleL = (UILabel *)[cell viewWithTag:11];//电话
            Shop *shop = self.goods.contentShop;
            contactNameTitleL.text = shop.shop_contact;
            contactPhoneTitleL.text = shop.shop_tel;
        }
            break;
        default:
        {
            if(indexPath.row == 0){
                cell = [tableView dequeueReusableCellWithIdentifier:@"ShopJiaIntroductionTitleCell" forIndexPath:indexPath];
            }else{
                cell = [tableView dequeueReusableCellWithIdentifier:@"ShopJiaIntroductionCell" forIndexPath:indexPath];
                UILabel *shopIntroTitleL = (UILabel *)[cell viewWithTag:10];//商家介绍
                Shop *shop = self.goods.contentShop;
                shopIntroTitleL.text = shop.shop_about;
            }
        }
            break;
    }

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            if(indexPath.row == 0){
                return 44;
            }else if (indexPath.row == 1){
                return 44;
            }else if (indexPath.row == 2){
                return 44;
            }else{
                return 44;
            }
        }
            break;
        case 1:
        {
            if(indexPath.row == 0){
                return 44;
            }else{
                CGFloat height = 22.0;
                height += [LZXHelper textHeightFromTextString:self.goods.goods_content width:336.0 fontSize:16.0];
                return height;
            }
        }
            break;
        case 2:
        {
            if(indexPath.row == 0){
                return 44;
            }else{
                return 64;
            }
        }
            break;
        case 3:
        {
            return 60;
        }
            break;
        default:
        {
            if(indexPath.row == 0){
                return 44;
            }else{
                CGFloat height = 22.0;
                Shop *shop = self.goods.contentShop;
                height += [LZXHelper textHeightFromTextString:shop.shop_about width:333.0 fontSize:16.0];
                return height;
            }
        }
            break;
    }
}
//返回sectionHeadView的高度
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0&&indexPath.row == 1){
        [self performSegueWithIdentifier:@"GoToGoodsType" sender:self];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}
#pragma button-点击事件
//收藏商品按钮事件
-(void)collectBtnClick:(UIButton *)sender{
    //首先判断当前是否有用户登录
    UserService *userS = [[UserService alloc] init];
    [userS currentUserIsLogin:^(BOOL isLogin, User *user) {
        if(isLogin){
            GoodService *goodS = [[GoodService alloc] init];
            [goodS collectGoods:self.goods_id userID:user.user_id success:^(BOOL isSuccess, NSString *content) {
                if(isSuccess){
                    NSLog(@"success == %@",content);
                }else{
                    NSLog(@"faile == %@",content);
                }
            }];
        }else{
            [self performSegueWithIdentifier:@"GoodsInfoGoToLogin" sender:self];
        }
    }];
}
//加减按钮事件
-(void)opBtnClick:(UIButton *)sender{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UILabel *goodNumTitleL = (UILabel *)[cell viewWithTag:13];//数量
    if(sender.tag == 12){//减btn
        if([goodNumTitleL.text intValue]>1){//可以减
            goodNumTitleL.text = [NSString stringWithFormat:@"%d",[goodNumTitleL.text intValue]-1];
        }
    }else{
        if([goodNumTitleL.text intValue]<self.goods.goods_number){
            goodNumTitleL.text = [NSString stringWithFormat:@"%d",[goodNumTitleL.text intValue]+1];
        }
    }
    [self.tableView reloadData];
}
//张开与闭合按钮事件
-(void)isCloseBtnClick:(UIButton *)sender{
    
}
//加入购物车按钮事件
- (IBAction)addCartBtnClick:(UIButton *)sender {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UILabel *goodNumTitleL = (UILabel *)[cell viewWithTag:13];//数量
    //首先判断当前是否有用户登录
    UserService *userS = [[UserService alloc] init];
    [userS currentUserIsLogin:^(BOOL isLogin, User *user) {
        if(isLogin){
            GoodService *goodS = [[GoodService alloc] init];
            [goodS addGoodsIntoCart:self.goods_id goodsNumber:[goodNumTitleL.text intValue] userID:user.user_id success:^(BOOL isSuccess) {
                if(isSuccess){
                    NSLog(@"加入购物车成功");
                }else{
                    NSLog(@"加入购物车失败");
                }
            }];
        }else{
            [self performSegueWithIdentifier:@"GoodsInfoGoToLogin" sender:self];
        }
    }];
}
//立即购买
- (IBAction)inTimeBuyBtnClick:(UIButton *)sender {
    UserService *userS = [[UserService alloc] init];
    __weak typeof(self) MySelf = self;
    [userS currentUserIsLogin:^(BOOL isLogin, User *user) {
        if(isLogin){
            MySelf.user = user;
            [self performSegueWithIdentifier:@"GoToConfirmOrder" sender:self];
        }else{
            [self performSegueWithIdentifier:@"GoodsInfoGoToLogin" sender:self];
        }
    }];
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
    if([segue.identifier isEqualToString:@"GoToGoodsType"]){
        GoodsTypeViewController *goodsTypeVC = segue.destinationViewController;
        goodsTypeVC.goods_type_pid = self.goods.goods_type_pid;
        goodsTypeVC.goods_type_id = self.goods.goods_type_id;
        goodsTypeVC.city_id = self.goods.city_id;
    }else if ([segue.identifier isEqualToString:@"GoToConfirmOrder"]){
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        UILabel *goodNumTitleL = (UILabel *)[cell viewWithTag:13];//数量
        ConfirmOrderViewController *confirmOrederVC = segue.destinationViewController;
        confirmOrederVC.user = self.user;
        NSMutableArray *cartArry = [NSMutableArray array];
        Cart *cart = [[Cart alloc] init];
        cart.goods_id = self.goods.goods_id;
        cart.goods_number = [goodNumTitleL.text intValue];
        cart.goods_price = self.goods.goods_price;
        cart.goods_marke_price = self.goods.goods_marke_price;
        cart.goods_name = self.goods.goods_name;
        cart.goods_imgs = self.goods.goods_imgs;
        [cartArry addObject:cart];
        confirmOrederVC.cartArry = cartArry;
    }
}

@end
