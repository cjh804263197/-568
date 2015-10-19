//
//  Shop.h
//  Buy568
//
//  Created by echo23 on 15/10/6.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop : NSObject
/**
 商店id
 */
@property (nonatomic,assign) int shop_id;
/**
 商店名称
 */
@property (nonatomic,strong) NSString *shop_name;
/**
 商店密码
 */
@property (nonatomic,strong) NSString *shop_password;
/**
 商店联系人
 */
@property (nonatomic,strong) NSString *shop_contact;
/**
 商店电话
 */
@property (nonatomic,strong) NSString *shop_tel;
/**
 商店地址
 */
@property (nonatomic,strong) NSString *shop_address;
/**
 商店介绍
 */
@property (nonatomic,strong) NSString *shop_about;
/**
 
 */
@property (nonatomic,strong) NSString *shop_main;
/**
 城市id
 */
@property (nonatomic,assign) int city_id;
/**
 商店状态
 */
@property (nonatomic,assign) int shop_status;
/**
 商店排序
 */
@property (nonatomic,assign) int shop_listorder;
/**
 商店图标
 */
@property (nonatomic,strong) NSString *shop_ico;

//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary;
@end
