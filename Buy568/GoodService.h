//
//  GoodService.h
//  Buy568
//
//  Created by echo23 on 15/10/5.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Goods.h"

@interface GoodService : NSObject
/**
 获取所有商品分类以及商品（添加了广告商品）
 city_id 城市id
 */
-(void)getAllGoodsType:(int)city_id success:(void(^)(NSArray *GoodTypeArry))success;
/**
 获取指定商品详细内容
 goods_id 商品id
 */
-(void)getGoodsDetailInfo:(int)goods_id success:(void(^)(Goods *goods))success;
/**
 将指定商品加入购物车
 goods_id 商品ID
 goods_number 商品数量
 user_id 当前登录的用户ID
 */
-(void)addGoodsIntoCart:(int)goods_id goodsNumber:(int)goods_number userID:(int)user_id success:(void(^)(BOOL isSuccess))success;
/**
 收藏指定商品
 goods_id 商品ID
 user_id 当前登录的用户ID
 */
-(void)collectGoods:(int)goods_id userID:(int)user_id success:(void(^)(BOOL isSuccess,NSString *content))success;
/**
 用于获取指定商品分类（一级分类，二级分类都指定）的商品列表
 city_id 
 goods_type_pid 商品一级分类id
 goods_type_id 商品二级分类id
 list_order 排序字段 参数传1 2 3 1 ---》价格 2 ---》销量 3 ---》时间
 Page_num 分页页数（第几页）
 Page_size 分页数（每页几个）
 在block块中返回商品数组以及商品类型数组
 */
-(void)getGoodsTypeList:(int)city_id goodsTypePid:(int)goods_type_pid goodsTypeId:(int)goods_type_id listOrder:(int)list_order pageNum:(int)Page_num pageSize:(int)Page_size success:(void(^)(NSArray *goodsArry,NSArray *goodsListArry))success;
/**
 获取我的收藏列表
 */
-(void)getMyCollectionList:(int)user_id success:(void(^)(NSArray *collectionList))success;
/**
 取消收藏
 */
-(void)cancelCollection:(int)collect_id success:(void(^)(BOOL isSuccess,NSString *content))success;
/**
 获取我的购物车列表
 */
-(void)getCartList:(int)user_id success:(void(^)(NSArray *cartArry,float totalPrice))success;
/**
 编辑购物车商品购买数量
 */
-(void)editCartGoodsNumber:(int)goods_id GoodsNumber:(int)goods_number userID:(int)user_id success:(void(^)(BOOL isSuccess))success;
/**
 删除购物车单个商品
 */
-(void)deleteGoodsInCart:(int)goods_id userID:(int)user_id success:(void(^)(BOOL isSuccess))success;
@end
