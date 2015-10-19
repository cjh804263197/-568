//
//  GoodsType.h
//  Buy568
//  商品分类实体类
//  Created by echo23 on 15/10/5.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Goods.h"

@interface GoodsType : NSObject
/**
 一级商品分类id
 */
@property (nonatomic,assign) int goods_type_id;
/**
 一级商品分类名称
 */
@property (nonatomic,strong) NSString *goods_type_name;
/**
 广告展示商品类数组
 */
@property (nonatomic,strong) NSMutableArray *add_goods;
/**
 该类型下的商品列表数组
 */
@property (nonatomic,strong) NSMutableArray *listgoods;
/**
 以及商品分类链接
 */
@property (nonatomic,strong) NSString *good_type_link;

//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary;
@end
