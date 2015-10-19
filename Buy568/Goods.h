//
//  Goods.h
//  Buy568
//  商品类
//  Created by echo23 on 15/10/5.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shop.h"

@interface Goods : NSObject
/**
 商品id
 */
@property (nonatomic,assign) int goods_id;
/**
 商品名称
 */
@property (nonatomic,strong) NSString *goods_name;
/**
 商品广告图片
 */
@property (nonatomic,strong) NSString *goods_ad;
/**
 商品链接（到内容页）
 */
@property (nonatomic,strong) NSString *goods_url;
/**
 商品缩略图
 */
@property (nonatomic,strong) NSString *goods_imgs;
/**
商品二级分类id
 */
@property (nonatomic,assign) int goods_type_id;
/**
 商品标题（内容也显示这个）
 */
@property (nonatomic,strong) NSString *goods_title;
/**
 是否新品
 */
@property (nonatomic,assign) int goods_isnew;
/**
 是否打折
 */
@property (nonatomic,assign) int goods_sales;
/**
 商品上架时间
 */
@property (nonatomic,strong) NSString *goods_addtime;
/**
 是否热卖
 */
@property (nonatomic,assign) int goods_ishot;
/**
 价格
 */
@property (nonatomic,assign) CGFloat goods_price;
/**
 市场价
 */
@property (nonatomic,assign) CGFloat goods_marke_price;
/**
 库存
 */
@property (nonatomic,assign) int goods_number;
/**
 商品介绍
 */
@property (nonatomic,strong) NSString *goods_content;
/**
 商品状态
 */
@property (nonatomic,assign) int goods_status;
/**
 商店id
 */
@property (nonatomic,assign) int shop_id;
/**
 城市id
 */
@property (nonatomic,assign) int city_id;
/**
 
 */
@property (nonatomic,strong) Shop *contentShop;
/**
 商品分类（一级目录/二级目录）
 */
@property (nonatomic,strong) NSString *goods_typename;
/**
 商品分类链接到列表页
 */
@property (nonatomic,strong) NSString *goods_type_url;
/**
 商品一级分类id
 */
@property (nonatomic,assign) int goods_type_pid;
/**
 商品图集
 */
@property (nonatomic,strong) NSMutableArray *goods_imgs_new;
/**
 分享标题
 */
@property (nonatomic,strong) NSString *share_title;
/**
 分享图片
 */
@property (nonatomic,strong) NSString *share_img;
/**
 分享链接
 */
@property (nonatomic,strong) NSString *share_url;
/**
 分享内容
 */
@property (nonatomic,strong) NSString *share_content;

//给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary;
@end
