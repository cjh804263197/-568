//
//  OrderService.h
//  Buy568
//
//  Created by echo23 on 15/10/14.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"

@interface OrderService : NSObject
/**
 获取用户的所有订单
 */
-(void)getUserAllOrder:(int)user_id success:(void(^)(NSArray *orderArry))success;
/**
 获取订单详细信息
 */
-(void)getOrderDetailInfo:(NSString *)order_sn success:(void(^)(Order *order))success;
/**
 取消订单
 */
-(void)cancleOrder:(NSString *)order_sn success:(void(^)(BOOL isSuccess))success;
/**
 购物车提交订单
 返回 order_sn
 */
-(void)cartSubmitOrder:(NSDictionary *)dictionary success:(void(^)(BOOL isSuccess,NSString *content,NSString *order_sn))success;
@end
