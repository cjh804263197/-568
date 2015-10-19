//
//  MyOrderViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/14.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "MyOrderViewController.h"
#import "OrderService.h"
#import "Order.h"
#import "MyOrderDetailViewController.h"

@interface MyOrderViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) OrderService *orderS;
@property (nonatomic,strong) NSArray *orderArry;
@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.orderArry = [NSArray array];
    self.orderS  = [[OrderService alloc] init];
    __weak typeof(self) MySelf = self;
    [self.orderS getUserAllOrder:self.user_id success:^(NSArray *orderArry) {
        MySelf.orderArry = orderArry;
        [MySelf.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}
#pragma tableView-代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell" forIndexPath:indexPath];
    Order *order = self.orderArry[indexPath.row];
    UILabel *snL = (UILabel *)[cell viewWithTag:10];
    UILabel *amoutL = (UILabel *)[cell viewWithTag:11];
    UILabel *timeL = (UILabel *)[cell viewWithTag:12];
    UILabel *statusL = (UILabel *)[cell viewWithTag:13
                                   ];
    UIButton *cancleBtn = (UIButton *)[cell viewWithTag:14];
    
    snL.text = [NSString stringWithFormat:@"订单号：%@",order.order_sn];
    
    amoutL.text = [NSString stringWithFormat:@"订单金额：%0.0lf",order.order_amount];
    
    timeL.text = [NSString stringWithFormat:@"下单时间：%@",order.order_edittime];
    
    statusL.layer.borderColor = [UIColor blueColor].CGColor;
    statusL.layer.borderWidth = 1.0;
    statusL.text = order.order_pay_status_text;
    
    cancleBtn.layer.borderColor = [UIColor blueColor].CGColor;
    cancleBtn.layer.borderWidth = 1.0;
    [cancleBtn addTarget:self action:@selector(cancleOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"GoToOrderDetail" sender:self];
}
#pragma button-点击事件
//取消订单按钮事件
-(void)cancleOrderBtnClick:(UIButton *)button{
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    Order *order = self.orderArry[index.row];
    OrderService *orderS = [[OrderService alloc] init];
    NSMutableArray *arry = (NSMutableArray *)self.orderArry;
    __weak typeof(self) MySelf = self;
    [orderS cancleOrder:order.order_sn success:^(BOOL isSuccess) {
        if(isSuccess){
            NSLog(@"取消成功");
            [arry removeObjectAtIndex:index.row];
            MySelf.orderArry = arry;
            [MySelf.tableView reloadData];
            [SVProgressHUD dismiss];
        }else{
            NSLog(@"取消失败");
            [SVProgressHUD dismiss];
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
    if([segue.identifier isEqualToString:@"GoToOrderDetail"]){
        MyOrderDetailViewController *orderDetailVC = segue.destinationViewController;
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        Order *order = self.orderArry[index.row];
        orderDetailVC.order_sn = order.order_sn;
    }
}


@end
