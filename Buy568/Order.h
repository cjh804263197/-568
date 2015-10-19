//
//  Order.h
//  Buy568
//  订单类
//  Created by echo23 on 15/10/8.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Goods.h"

@interface Order : NSObject
@property (nonatomic,strong) NSString *order_sn;
@property (nonatomic,assign) float order_amount;
@property (nonatomic,strong) NSString *order_edittime;
@property (nonatomic,assign) int order_status;
@property (nonatomic,assign) int order_pay_status;
@property (nonatomic,strong) NSString *order_status_text;
@property (nonatomic,strong) NSString *order_pay_status_text;

@property (nonatomic,assign) int order_id;
@property (nonatomic,assign) int user_id;
@property (nonatomic,strong) NSString *order_consignee;
@property (nonatomic,strong) NSString *order_address;
@property (nonatomic,strong) NSString *order_tel;
@property (nonatomic,assign) int order_pay_id;
@property (nonatomic,assign) int order_delivery;
@property (nonatomic,strong) NSString *order_addtime;
@property (nonatomic,strong) NSString *order_remarks;
@property (nonatomic,strong) NSMutableArray *listgoods;

//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary;
@end
