//
//  Cart.m
//  Buy568
//
//  Created by echo23 on 15/10/15.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "Cart.h"

@implementation Cart
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.cart_id = [dictionary[@"cart_id"] intValue];
    self.user_id = [dictionary[@"user_id"] intValue];
    self.goods_id = [dictionary[@"goods_id"] intValue];
    self.goods_number = [dictionary[@"goods_number"] intValue];
    self.goods_price = [dictionary[@"goods_price"] floatValue];
    self.goods_marke_price = [dictionary[@"goods_marke_price"] floatValue];
    self.goods_name = dictionary[@"goods_name"];
    self.goods_imgs = [NSString stringWithFormat:@"%@%@",ServerURL,dictionary[@"goods_imgs"]];
}
@end
