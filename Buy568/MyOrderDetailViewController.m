//
//  MyOrderDetailViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/14.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "MyOrderDetailViewController.h"
#import "OrderService.h"
#import "Order.h"

@interface MyOrderDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) OrderService *orderS;
@property (nonatomic,strong) Order *order;
@end

@implementation MyOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.orderS = [[OrderService alloc] init];
    self.order = [[Order alloc] init];
    __weak typeof(self) MySelf = self;
    [self.orderS getOrderDetailInfo:self.order_sn success:^(Order *order) {
        MySelf.order = order;
        [MySelf.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
    self.tableView.tableFooterView = [[UIView alloc] init];
}
#pragma tableView-代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 1){
        NSArray *goodArry = self.order.listgoods;
        return goodArry.count;
    }else{
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell" forIndexPath:indexPath];
            UILabel *snL = (UILabel *)[cell viewWithTag:10];
            UILabel *orderStatusL = (UILabel *)[cell viewWithTag:11];
            UILabel *payStatusL = (UILabel *)[cell viewWithTag:12];
            UILabel *totalPL = (UILabel *)[cell viewWithTag:13];
            UIButton *onlinePayBtn = (UIButton *)[cell viewWithTag:14];
            
            snL.text = [NSString stringWithFormat:@"订单号：%@",self.order.order_sn];
            
            orderStatusL.text = [NSString stringWithFormat:@"订单状态：%@",self.order.order_status_text];
            
            payStatusL.text = [NSString stringWithFormat:@"支付状态：%@",self.order.order_pay_status_text];
           
            totalPL.text = [NSString stringWithFormat:@"商品总价：%0.0lf", self.order.order_amount];
            
            onlinePayBtn.layer.borderColor = [UIColor blueColor].CGColor;
            onlinePayBtn.layer.borderWidth = 1.0;
            [onlinePayBtn addTarget:self action:@selector(onlinePayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"goodsCell" forIndexPath:indexPath];
            NSArray *goodsArry = self.order.listgoods;
            Goods *goods = goodsArry[indexPath.row];
            
            UIImageView *imageV = (UIImageView *)[cell viewWithTag:10];
            UILabel *titleL = (UILabel *)[cell viewWithTag:11];
            UILabel *priceL = (UILabel *)[cell viewWithTag:12];
            UILabel *marketPriceL = (UILabel *)[cell viewWithTag:13];
            
            [imageV sd_setImageWithURL:[NSURL URLWithString:goods.goods_imgs] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
            
            titleL.text = goods.goods_name;
            
            priceL.text = [NSString stringWithFormat:@"¥%0.0lf",goods.goods_price];
           
            marketPriceL.text = [NSString stringWithFormat:@"¥%0.0lf",goods.goods_marke_price];
            
            
        }
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
            UILabel *nameL = (UILabel *)[cell viewWithTag:10];
            UILabel *phoneL = (UILabel *)[cell viewWithTag:11];
            UILabel *addressL = (UILabel *)[cell viewWithTag:12];
            
            nameL.text = self.order.order_consignee;
            
            phoneL.text = self.order.order_tel;
            
            addressL.text = self.order.order_address;
        }
            break;
        default:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"btnCell" forIndexPath:indexPath];
            UIButton *waitSendBtn = (UIButton *)[cell viewWithTag:10];
            
            waitSendBtn.layer.borderColor = [UIColor blueColor].CGColor;
            waitSendBtn.layer.borderWidth = 1.0;
        }
            break;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return nil;
        }
            break;
        case 1:
        {
            return @"商品列表";
        }
            break;
        case 2:
        {
            return @"收货信息";
        }
            break;
            
        default:
        {
            return nil;
        }
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            return 150;
        }
            break;
        case 1:
        {
            return 80;
        }
            break;
        case 2:
        {
            return 70;
        }
            break;
        default:
        {
            return 44;
        }
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return 0;
        }
            break;
        case 1:
        {
            return 20;
        }
            break;
        case 2:
        {
            return 20;
        }
            break;
        default:
        {
            return 10;
        }
            break;
    }
}
#pragma button-点击事件
//在线支付按钮事件
-(void)onlinePayBtnClick:(UIButton *)button{
    
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
