//
//  OrderService.m
//  Buy568
//
//  Created by echo23 on 15/10/14.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "OrderService.h"
//获取当前用户所有订单服务器地址
#define UserAllOrderURL @"index.php/Home/APIuser/listorder/user_id/"
//获取订单详细信息服务器内地址
#define OrderDetailInfoURL @"index.php/Home/APIuser/infoorder/order_sn/"
//取消订单
#define CancleOrderURL @"index.php/Home/APIuser/cancelorder/order_sn/"
//购物车提交订单
#define CartSubmitOrderURL @"index.php/Home/APIgoods/addorder"

@implementation OrderService
/**
 获取用户的所有订单
 */
-(void)getUserAllOrder:(int)user_id success:(void(^)(NSArray *orderArry))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *userAllOrderURL_str = [NSString stringWithFormat:@"%@/%@%d",ServerURL,UserAllOrderURL,user_id];
    [HttpTools getWithURl:userAllOrderURL_str parameter:nil success:^(id responseObject) {
        NSArray *arry = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *orderArry = [NSMutableArray array];
        for(NSDictionary *dic in arry){
            Order *order = [[Order alloc] init];
            [order setValueForDictionary:dic];
            [orderArry addObject:order];
        }
        success(orderArry);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 获取订单详细信息
 */
-(void)getOrderDetailInfo:(NSString *)order_sn success:(void(^)(Order *order))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *orderDetailInfoURL_str = [NSString stringWithFormat:@"%@/%@%@",ServerURL,OrderDetailInfoURL,order_sn];
    [HttpTools getWithURl:orderDetailInfoURL_str parameter:nil success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        Order *order = [[Order alloc] init];
        [order setValueForDictionary:dic];
        success(order);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 取消订单
 */
-(void)cancleOrder:(NSString *)order_sn success:(void(^)(BOOL isSuccess))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *cancleOrderURL_str = [NSString stringWithFormat:@"%@/%@%@",ServerURL,CancleOrderURL,order_sn];
    [HttpTools getWithURl:cancleOrderURL_str parameter:nil success:^(id responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if([str isEqualToString:@"\"success\""]){
            success(YES);
        }else{
            success(NO);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 购物车提交订单
 返回 order_sn
 */
-(void)cartSubmitOrder:(NSDictionary *)dictionary success:(void(^)(BOOL isSuccess,NSString *content,NSString *order_sn))success{
    NSString *cartSubmitOrderURL_str = [NSString stringWithFormat:@"%@/%@",ServerURL,CartSubmitOrderURL];
    NSString *dicStr = [LZXHelper DataTOjsonString:dictionary];
    [HttpTools postWithURL:cartSubmitOrderURL_str parameter:@{@"orderInfo":dicStr} success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([dic[@"status"] intValue] == 1){
            success(YES,dic[@"content"],dic[@"order_sn"]);
        }else{
            success(NO,dic[@"content"],nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"错误信息:%@",error);
    }];
}
@end
