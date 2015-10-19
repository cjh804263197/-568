//
//  ConfirmOrderViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/8.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "Cart.h"
#import "OrderService.h"
#import "MyOrderDetailViewController.h"

@interface ConfirmOrderViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) float totalP;
@property (nonatomic,strong) NSString *order_sn;
@end

@implementation ConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] init];
    UILabel *totalPL = (UILabel *)[self.view viewWithTag:10];
    self.totalP = 0;
    for(Cart *cart in self.cartArry){
        self.totalP += cart.goods_number*cart.goods_price;
    }
    totalPL.text = [NSString stringWithFormat:@"合计：¥%0.1lf",self.totalP];
}
#pragma tableView-代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.cartArry.count+1;
            break;
        default:
            return 3;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
        {
            if(indexPath.row == self.cartArry.count){
                cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsAllPriceCell" forIndexPath:indexPath];
                UILabel *totalPriceL = (UILabel *)[cell viewWithTag:10];
                totalPriceL.text = [NSString stringWithFormat:@"¥%0.1lf", self.totalP];
            }else{
                cell = [tableView dequeueReusableCellWithIdentifier:@"GoodIMGAndNameCell" forIndexPath:indexPath];
                Cart *cart = self.cartArry[indexPath.row];
                UIImageView *imageV = (UIImageView *)[cell viewWithTag:10];
                UILabel *nameL = (UILabel *)[cell viewWithTag:11];
                UILabel *numL = (UILabel *)[cell viewWithTag:12];
                UILabel *priceL = (UILabel *)[cell viewWithTag:13];
                UILabel *marketPriceL = (UILabel *)[cell viewWithTag:14];
                
                [imageV sd_setImageWithURL:[NSURL URLWithString:cart.goods_imgs] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
                nameL.text = cart.goods_name;
                numL.text = [NSString stringWithFormat:@"×%d",cart.goods_number];
                priceL.text = [NSString stringWithFormat:@"¥%0.1lf",cart.goods_price];
                marketPriceL.text = [NSString stringWithFormat:@"¥%0.1lf",cart.goods_marke_price];
            }
        }
            break;
            
        default:
        {
            if(indexPath.row == 0){
                cell = [tableView dequeueReusableCellWithIdentifier:@"reciveUserInfoCell" forIndexPath:indexPath];
                UILabel *userNameL = (UILabel *)[cell viewWithTag:10];
                UILabel *userPhoneL = (UILabel *)[cell viewWithTag:11];
                UILabel *userAddressL = (UILabel *)[cell viewWithTag:12];
                
                userNameL.text = self.user.user_name;
                userPhoneL.text = self.user.user_phone;
            }else if (indexPath.row == 1){
                cell = [tableView dequeueReusableCellWithIdentifier:@"payStyleCell"forIndexPath:indexPath];
                UILabel *payStyleL = (UILabel *)[cell viewWithTag:10];
            }else{
                cell = [tableView dequeueReusableCellWithIdentifier:@"sendStyleCell" forIndexPath:indexPath];
                UILabel *sendStyleL = (UILabel *)[cell viewWithTag:10];
            }
        }
            break;
    }
    return cell;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            if(indexPath.row == self.cartArry.count){
                return 44;
            }else{
                return 90;
            }
        }
            break;
        default:
        {
            if(indexPath.row == 0){
                return 67;
            }else if (indexPath.row == 1){
                return 44;
            }else{
                return 44;
            }
        }
            break;
    }
}
//cell section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"订单详情";
            break;
            
        default:
            return @"收货地址";
            break;
    }
}
//提交订单
- (IBAction)sumbitOrder:(UIButton *)sender {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%d",self.user.user_id] forKey:@"user_id"];
    NSMutableArray *arry = [NSMutableArray array];
    for(Cart *cart in self.cartArry){
        [arry addObject:[NSString stringWithFormat:@"%d",cart.goods_id]];
    }
    NSString *arryStr = [arry componentsJoinedByString:@","];
    [dic setValue:arryStr forKey:@"goods_id"];
    [dic setValue:self.user.user_name forKey:@"order_consignee"];
    [dic setValue:self.user.user_phone forKey:@"order_tel"];
    [dic setValue:self.user.user_address forKey:@"order_address"];
    [dic setValue:@"1" forKey:@"order_pay_id"];
    [dic setValue:@"" forKey:@"order_remarks"];
    [dic setValue:@"1" forKey:@"order_delivery"];
    OrderService *orderS = [[OrderService alloc] init];
    __weak typeof(self) MySelf = self;
    [orderS cartSubmitOrder:dic success:^(BOOL isSuccess, NSString *content, NSString *order_sn) {
        if(isSuccess){
            NSLog(@"%@",content);
            MySelf.order_sn = order_sn;
            [MySelf performSegueWithIdentifier:@"sureToOrderDetail" sender:MySelf];
        }else{
            NSLog(@"%@",content);
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
    if([segue.identifier isEqualToString:@"sureToOrderDetail"]){
        MyOrderDetailViewController *orderDetailVC = segue.destinationViewController;
        orderDetailVC.order_sn = self.order_sn;
    }
}


@end
