//
//  Goods.m
//  Buy568
//
//  Created by echo23 on 15/10/5.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "Goods.h"

@implementation Goods
//给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.goods_id = [dictionary[@"goods_id"] intValue];
    self.goods_ad = [NSString stringWithFormat:@"%@%@",ServerURL,dictionary[@"goods_ad"]];
    self.goods_name = dictionary[@"goods_name"];
    self.goods_url = dictionary[@"goods_url"];
    self.goods_imgs = [NSString stringWithFormat:@"%@%@",ServerURL,dictionary[@"goods_imgs"]];
    self.goods_type_id = [dictionary[@"goods_type_id"] intValue];
    self.goods_title = dictionary[@"goods_title"];
    self.goods_isnew = [dictionary[@"goods_isnew"] intValue];
    self.goods_sales = [dictionary[@"goods_sales"] intValue];
    self.goods_addtime = dictionary[@"goods_addtime"];
    self.goods_ishot = [dictionary[@"goods_ishot"] intValue];
    self.goods_price = [dictionary[@"goods_price"] floatValue];
    self.goods_marke_price = [dictionary[@"goods_marke_price"] floatValue];
    self.goods_number = [dictionary[@"goods_number"] intValue];
    self.goods_content = dictionary[@"goods_content"];
    self.goods_status = [dictionary[@"goods_status"] intValue];
    self.shop_id = [dictionary[@"shop_id"] intValue];
    self.city_id = [dictionary[@"city_id"] intValue];
    Shop *shop = [[Shop alloc] init];
    [shop setValueForDictionary:dictionary[@"contentShop"]];
    self.contentShop = shop;
    self.goods_typename = dictionary[@"goods_typename"];
    self.goods_type_url = dictionary[@"goods_type_url"];
    self.goods_type_pid = [dictionary[@"goods_type_pid"] intValue];
    self.goods_imgs_new = [NSMutableArray array];
    NSArray *arry = dictionary[@"goods_imgs_new"];
    for(NSDictionary *dic in arry){
        [self.goods_imgs_new addObject:[NSString stringWithFormat:@"%@%@",ServerURL,dic[@"img"]]];
    }
    self.share_title = dictionary[@"share_title"];
    self.share_img = dictionary[@"share_img"];
    self.share_url = dictionary[@"share_url"];
    self.share_content = dictionary[@"share_content"];
}
@end
