//
//  GoodsTypeViewController.h
//  Buy568
//
//  Created by echo23 on 15/10/7.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsTypeViewController : UIViewController
@property (nonatomic,assign) int goods_type_pid;//获取前一个页面传过来的商品一级分类id
@property (nonatomic,assign) int goods_type_id;//获取前一个页面传过来的商品二级分类id
@property (nonatomic,assign) int city_id;//获取前一个页面传过来的商品所在城市的id
@end
