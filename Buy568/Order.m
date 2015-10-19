//
//  Order.m
//  Buy568
//
//  Created by echo23 on 15/10/8.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "Order.h"

@implementation Order
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.order_sn = dictionary[@"order_sn"];
    self.order_amount = [dictionary[@"order_amount"] floatValue];
    self.order_edittime = dictionary[@"order_edittime"];
    self.order_status = [dictionary[@"order_status"] intValue];
    self.order_pay_status = [dictionary[@"order_pay_status"] intValue];
    self.order_status_text = dictionary[@"order_status_text"];
    self.order_pay_status_text = dictionary[@"order_pay_status_text"];
    
    self.order_id = [dictionary[@"order_id"] intValue];
    self.user_id = [dictionary[@"user_id"] intValue];
    self.order_consignee = dictionary[@"order_consignee"];
    if([dictionary[@"order_address"] isEqual:[NSNull null]]||[dictionary[@"order_address"] isEqualToString:@"<null>"]){
        self.order_address = @"";
    }else
        self.order_address = dictionary[@"order_address"];
    self.order_tel = dictionary[@"order_tel"];
    self.order_pay_id = [dictionary[@"order_pay_id"] intValue];
    self.order_delivery = [dictionary[@"order_delivery"] intValue];
    self.order_addtime = dictionary[@"order_addtime"];
    self.order_remarks = dictionary[@"order_remarks"];
    self.listgoods = [NSMutableArray array];
    NSArray *arry = dictionary[@"listgoods"];
    for(NSDictionary *dic in arry){
        Goods *goods = [[Goods alloc] init];
        [goods setValueForDictionary:dic];
        [self.listgoods addObject:goods];
    }
}
@end
