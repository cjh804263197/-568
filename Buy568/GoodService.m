//
//  GoodService.m
//  Buy568
//
//  Created by echo23 on 15/10/5.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "GoodService.h"
#import "Goods.h"
#import "GoodsType.h"
#import "Collection.h"
#import "Cart.h"

//获取所有商品分类以及商品的服务器内地址
#define GoodsTypeURL @"index.php/Home/APIgoods/goodsType/city_id/"
//获取指定商品详细内容的服务器内地址
#define GoodsDetailInfoURL @"index.php/Home/APIgoods/contentGoods/goods_id/"
//将指定商品加入购物车的服务器内地址
#define AddGoodsIntoCartURL @"index.php/Home/APIgoods/addcart/goods_id/"
//收藏指定商品的服务器内地址
#define CollectGoodsURL @"index.php/Home/APIuser/add_collect/goods_id/"
//获取指定商品分类（一级分类，二级分类都指定）的商品列表的服务器内地址
#define GetGoodsTypeListURL @"index.php/Home/APIgoods/listGoods/goods_type_pid/"
//获取收藏列表的服务器内地址
#define MyCollectionListURL @"index.php/Home/APIuser/list_collect/user_id/"
//取消收藏的服务器内地址
#define CancelCollectionURL @"index.php/Home/APIuser/cancle_collect/collect_id/"
//获取购物车列表服务器地址
#define CartListURL @"index.php/Home/APIgoods/listcart/user_id/"
//编辑购物车商品购买数量服务器内地址
#define EditCartGoodsNumberURL @"Home/APIgoods/updatecartgoods/goods_id/"
//删除购物车单个商品服务器内地址
#define DeleteGoodsInCartURL @"Home/APIgoods/deletecartgoods/goods_id/"

@implementation GoodService
/**
 获取所有商品分类以及商品（添加了广告商品）
 city_id 城市id
 */
-(void)getAllGoodsType:(int)city_id success:(void(^)(NSArray *GoodTypeArry))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *goodsTypeURL_str = [NSString stringWithFormat:@"%@/%@%d",ServerURL,GoodsTypeURL,city_id];
    [HttpTools getWithURl:goodsTypeURL_str parameter:nil success:^(id responseObject) {
        NSArray *arry = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *goodsTypeArry = [NSMutableArray array];
        for(NSDictionary *dic in arry){
            GoodsType *goodType = [[GoodsType alloc] init];
            [goodType setValueForDictionary:dic];
            [goodsTypeArry addObject:goodType];
        }
        success(goodsTypeArry);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 获取指定商品详细内容
 goods_id 商品id
 */
-(void)getGoodsDetailInfo:(int)goods_id success:(void(^)(Goods *goods))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *goodsDetailInfoURL_str = [NSString stringWithFormat:@"%@/%@%d",ServerURL,GoodsDetailInfoURL,goods_id];
    [HttpTools getWithURl:goodsDetailInfoURL_str parameter:nil success:^(id responseObject) {
        NSDictionary *goodDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        Goods *goods = [[Goods alloc] init];
        [goods setValueForDictionary:goodDic];
        success(goods);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 将指定商品加入购物车
 goods_id 商品ID
 goods_number 商品数量
 user_id 当前登录的用户ID
 */
-(void)addGoodsIntoCart:(int)goods_id goodsNumber:(int)goods_number userID:(int)user_id success:(void(^)(BOOL isSuccess))success{
    NSString *addGoodsIntoCartURL_str = [NSString stringWithFormat:@"%@/%@%d/goods_number/%d/user_id/%d",ServerURL,AddGoodsIntoCartURL,goods_id,goods_number,user_id];
    [HttpTools getWithURl:addGoodsIntoCartURL_str parameter:nil success:^(id responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if([result isEqualToString:@"\"success\""]){
            success(YES);
        }else{
            success(NO);
        }
    } failure:^(NSError *error) {
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 收藏指定商品
 goods_id 商品ID
 user_id 当前登录的用户ID
 */
-(void)collectGoods:(int)goods_id userID:(int)user_id success:(void(^)(BOOL isSuccess,NSString *content))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *collectGoodsURL_str = [NSString stringWithFormat:@"%@/%@%d/user_id/%d",ServerURL,CollectGoodsURL,goods_id,user_id];
    [HttpTools getWithURl:collectGoodsURL_str parameter:nil success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([dic[@"status"] intValue]){
            success(YES,dic[@"content"]);
        }else{
            success(NO,dic[@"content"]);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
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
-(void)getGoodsTypeList:(int)city_id goodsTypePid:(int)goods_type_pid goodsTypeId:(int)goods_type_id listOrder:(int)list_order pageNum:(int)Page_num pageSize:(int)Page_size success:(void(^)(NSArray *goodsArry,NSArray *goodsListArry))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *getGoodsTypeListURL_str = [NSString stringWithFormat:@"%@/%@%d/goods_type_id/%d/city_id/%d/list_order/%d/page_num/%d/page_size/%d",ServerURL,GetGoodsTypeListURL,goods_type_pid,goods_type_id,city_id,list_order,Page_num,Page_size];
    [HttpTools getWithURl:getGoodsTypeListURL_str parameter:nil success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *arry1 = dic[@"listGoods"];
        NSMutableArray *listGoodsArry = [NSMutableArray array];
        for(NSDictionary *dictionary in arry1){
            Goods *good = [[Goods alloc] init];
            [good setValueForDictionary:dictionary];
            [listGoodsArry addObject:good];
        }
        NSArray *arry2 = dic[@"listType"];
        NSMutableArray *goodsListArry = [NSMutableArray array];
        for(NSDictionary *dictionary in arry2){
            GoodsType *goodsType = [[GoodsType alloc] init];
            [goodsType setValueForDictionary:dictionary];
            [goodsListArry addObject:goodsType];
        }
        success(listGoodsArry,goodsListArry);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 获取我的收藏列表
 */
-(void)getMyCollectionList:(int)user_id success:(void(^)(NSArray *collectionList))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *myCollectionListURL_str = [NSString stringWithFormat:@"%@/%@%d",ServerURL,MyCollectionListURL,user_id];
    [HttpTools getWithURl:myCollectionListURL_str parameter:nil success:^(id responseObject) {
        NSArray *arry = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *collectionList = [NSMutableArray array];
        for(NSDictionary *dic in arry){
            Collection *collection = [[Collection alloc] init];
            [collection setValueForDictionary:dic];
            [collectionList addObject:collection];
        }
        success(collectionList);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 取消收藏
 */
-(void)cancelCollection:(int)collect_id success:(void(^)(BOOL isSuccess,NSString *content))success{
    NSString *cancelCollectionURL_str = [NSString stringWithFormat:@"%@/%@%d",ServerURL,CancelCollectionURL,collect_id];
    [HttpTools getWithURl:cancelCollectionURL_str parameter:nil success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([dic[@"status"] intValue] == 1){
            success(YES,dic[@"content"]);
        }else{
            success(NO,dic[@"content"]);
        }
    } failure:^(NSError *error) {
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 获取我的购物车列表
 */
-(void)getCartList:(int)user_id success:(void(^)(NSArray *cartArry,float totalPrice))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *cartListURL_str = [NSString stringWithFormat:@"%@/%@%d",ServerURL,CartListURL,user_id];
    [HttpTools getWithURl:cartListURL_str parameter:nil success:^(id responseObject) {
        NSArray *arry = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *cartArry = [NSMutableArray array];
        float totalP = 0;
        for (NSDictionary *dic in arry) {
            Cart *cart = [[Cart alloc] init];
            [cart setValueForDictionary:dic];
            totalP += cart.goods_price*cart.goods_number;
            [cartArry addObject:cart];
        }
        success(cartArry,totalP);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 编辑购物车商品购买数量
 */
-(void)editCartGoodsNumber:(int)goods_id GoodsNumber:(int)goods_number userID:(int)user_id success:(void(^)(BOOL isSuccess))success{
    NSString *editCartGoodsNumberURL_str = [NSString stringWithFormat:@"%@/%@%d/goods_number/%d/user_id/%d",ServerURL,EditCartGoodsNumberURL,goods_id,goods_number,user_id];
    [HttpTools getWithURl:editCartGoodsNumberURL_str parameter:nil success:^(id responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if([str isEqualToString:@"\"success\""]){
            success(YES);
        }else{
            success(NO);
        }
    } failure:^(NSError *error) {
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 删除购物车单个商品
 */
-(void)deleteGoodsInCart:(int)goods_id userID:(int)user_id success:(void(^)(BOOL isSuccess))success{
    NSString *deleteGoodsInCartURL_str = [NSString stringWithFormat:@"%@/%@%d/user_id/%d",ServerURL,DeleteGoodsInCartURL,goods_id,user_id];
    [HttpTools getWithURl:deleteGoodsInCartURL_str parameter:nil success:^(id responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if([str isEqualToString:@"\"success\""]){
            success(YES);
        }else{
            success(NO);
        }
    } failure:^(NSError *error) {
        NSLog(@"错误信息:%@",error);
    }];
}
@end
