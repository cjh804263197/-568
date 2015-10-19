//
//  Collection.m
//  Buy568
//  收藏类
//  Created by echo23 on 15/10/14.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "Collection.h"

@implementation Collection
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.collect_id = [dictionary[@"collect_id"] intValue];
    self.user_id = [dictionary[@"user_id"] intValue];
    self.goods_id = [dictionary[@"goods_id"] intValue];
    self.collect_addtime = dictionary[@"collect_addtime"];
    self.goods_name = dictionary[@"goods_name"];
    self.goods_price = [dictionary[@"goods_price"] floatValue];
    self.goods_imgs = [NSString stringWithFormat:@"%@%@",ServerURL,dictionary[@"goods_imgs"]];
}
@end
