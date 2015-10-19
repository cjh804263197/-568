
//
//  Shop.m
//  Buy568
//
//  Created by echo23 on 15/10/6.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "Shop.h"

@implementation Shop
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.shop_id = [dictionary[@"shop_id"] intValue];
    self.shop_name = dictionary[@"shop_name"];
    self.shop_password = dictionary[@"shop_password"];
    self.shop_contact = dictionary[@"shop_contact"];
    self.shop_tel = dictionary[@"shop_tel"];
    self.shop_address = dictionary[@"shop_address"];
    self.shop_about = dictionary[@"shop_about"];
    self.shop_main = dictionary[@"shop_main"];
    self.city_id = [dictionary[@"city_id"] intValue];
    self.shop_status = [dictionary[@"shop_status"] intValue];
    self.shop_listorder = [dictionary[@"shop_listorder"] intValue];
    self.shop_ico = [NSString stringWithFormat:@"%@%@",ServerURL,dictionary[@"shop_ico"]];
}
@end
