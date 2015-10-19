//
//  GoodsType.m
//  Buy568
//
//  Created by echo23 on 15/10/5.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "GoodsType.h"

@implementation GoodsType
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.goods_type_id = [dictionary[@"goods_type_id"] intValue];
    self.goods_type_name = dictionary[@"goods_type_name"];
    self.add_goods = [NSMutableArray array];
    for(NSDictionary *dic in dictionary[@"add_goods"]){
        Goods *good = [[Goods alloc] init];
        [good setValueForDictionary:dic];
        [self.add_goods addObject:good];
    }
    self.listgoods = [NSMutableArray array];
    for(NSDictionary *dic in dictionary[@"listgoods"]){
        Goods *good = [[Goods alloc] init];
        [good setValueForDictionary:dic];
        [self.listgoods addObject:good];
    }
    self.good_type_link = dictionary[@"good_type_link"];
}
@end
