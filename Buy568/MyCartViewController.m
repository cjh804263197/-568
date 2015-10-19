//
//  MyCartViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/15.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "MyCartViewController.h"
#import "GoodService.h"
#import "Cart.h"
#import "EditGoodsNumberViewController.h"
#import "ConfirmOrderViewController.h"
#import "UserService.h"

@interface MyCartViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *cartArry;
@property (nonatomic,strong) GoodService *goodS;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceL;
@property (nonatomic,assign) BOOL isAllSelected;
@property (nonatomic,strong) NSMutableArray *selectedCartArry;
@property (nonatomic,assign) int editIndex;
@end

@implementation MyCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isAllSelected = YES;
    self.cartArry = [NSArray array];
    self.goodS = [[GoodService alloc] init];
    __weak typeof(self) MySelf = self;
    [self.goodS getCartList:self.user_id success:^(NSArray *cartArry,float totalPrice) {
        MySelf.totalPriceL.text = [NSString stringWithFormat:@"¥%0.1lf",totalPrice];
        MySelf.cartArry = cartArry;
        MySelf.selectedCartArry = [NSMutableArray arrayWithArray:cartArry];
        [MySelf.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editFinish:) name:@"edit" object:nil];
}
//编辑完成通知调用的方法
-(void)editFinish:(NSNotification *)notification{
    int isSuccess = (int)[notification object];
    if(isSuccess){
        __weak typeof(self) MySelf = self;
        [self.goodS getCartList:self.user_id success:^(NSArray *cartArry,float totalPrice) {
            MySelf.totalPriceL.text = [NSString stringWithFormat:@"¥%0.1lf",totalPrice];
            MySelf.cartArry = cartArry;
            MySelf.selectedCartArry = [NSMutableArray arrayWithArray:cartArry];
            [MySelf.tableView reloadData];
            [SVProgressHUD dismiss];
        }];
    }else{
        NSLog(@"编辑失败");
    }
    [self.tableView reloadData];
}


#pragma tableView-代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cartArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cartCell" forIndexPath:indexPath];
    Cart *cart = self.cartArry[indexPath.row];
    
    UIButton *selectBtn = (UIButton *)[cell viewWithTag:10];
    UIImageView *imageV  = (UIImageView *)[cell viewWithTag:11];
    UILabel *titleL = (UILabel *)[cell viewWithTag:12];
    UILabel *priceL = (UILabel *)[cell viewWithTag:13];
    UILabel *marketPL = (UILabel *)[cell viewWithTag:14];
    UILabel *numL = (UILabel *)[cell viewWithTag:15];
    UIButton *editBtn = (UIButton *)[cell viewWithTag:16];
    UIButton *deleteBtn = (UIButton *)[cell viewWithTag:17];
    
    [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if(_isAllSelected){
        selectBtn.selected = NO;
    }
    else{
        selectBtn.selected = YES;
    }
    
    [imageV sd_setImageWithURL:[NSURL URLWithString:cart.goods_imgs] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
    
    titleL.text = cart.goods_name;
    
    priceL.text = [NSString stringWithFormat:@"商品价格：¥%0.0lf",cart.goods_price];
    
    marketPL.text = [NSString stringWithFormat:@"市场价格：¥%0.0lf",cart.goods_marke_price];
    
    numL.text = [NSString stringWithFormat:@"购买数量：%d",cart.goods_number];
    
    [editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma button-点击事件
//是否选中Button按钮
-(void)selectBtnClick:(UIButton *)button{
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    Cart *cart = self.cartArry[index.row];
    if(button.selected){
        button.selected = NO;
        [self.selectedCartArry addObject:cart];
    }else{
        button.selected = YES;
        [self.selectedCartArry removeObject:cart];
    }
    self.totalPriceL.text = [NSString stringWithFormat:@"¥%0.1lf",[self getSelectedTotalPrice]];
}
//编辑按钮事件
-(void)editBtnClick:(UIButton *)button{
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    self.editIndex = (int)index.row;
    Cart *cart = self.cartArry[index.row];
    EditGoodsNumberViewController *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditGoodsNumberViewController"];
    editVC.cart = cart;
    [self addChildViewController:editVC];
    [self.view addSubview:editVC.view];
}
//删除按钮事件
-(void)deleteBtnClick:(UIButton *)button{
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    Cart *cart = self.cartArry[index.row];
    __weak typeof(self) MySelf = self;
    [self.goodS deleteGoodsInCart:cart.goods_id userID:cart.user_id success:^(BOOL isSuccess) {
        if(isSuccess){
            [MySelf.goodS getCartList:MySelf.user_id success:^(NSArray *cartArry,float totalPrice) {
                MySelf.totalPriceL.text = [NSString stringWithFormat:@"¥%0.1lf",totalPrice];
                MySelf.cartArry = cartArry;
                MySelf.selectedCartArry = [NSMutableArray arrayWithArray:cartArry];
                [MySelf.tableView reloadData];
                [SVProgressHUD dismiss];
            }];
 
        }else{
            NSLog(@"删除商品失败");
        }
    }];
}
//全选按钮事件
- (IBAction)selectAllBtnClick:(UIButton *)sender {
    if(sender.selected){
        self.selectedCartArry = [NSMutableArray arrayWithArray:self.cartArry];
        _isAllSelected = YES;
        sender.selected = NO;
    }else{
        self.selectedCartArry = [NSMutableArray array];
        _isAllSelected = NO;
        sender.selected = YES;
    }
    self.totalPriceL.text = [NSString stringWithFormat:@"¥%0.1lf",[self getSelectedTotalPrice]];
    [self.tableView reloadData];
}
//结算按钮事件
- (IBAction)payBtnClick:(UIButton *)sender {
    [self performSegueWithIdentifier:@"GoToMakeSureOrder" sender:self];
}
//计算当前选中goods的总价
-(float)getSelectedTotalPrice{
    float totalP = 0;
    for(Cart *cart in self.selectedCartArry){
        totalP += cart.goods_price*cart.goods_number;
    }
    return totalP;
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
    if([segue.identifier isEqualToString:@"GoToMakeSureOrder"]){
        ConfirmOrderViewController *confirmVC = segue.destinationViewController;
        confirmVC.cartArry = self.selectedCartArry;
        UserService *userS = [[UserService alloc] init];
        [userS currentUserIsLogin:^(BOOL isLogin, User *user) {
            confirmVC.user = user;
        }];
    }
}


@end
