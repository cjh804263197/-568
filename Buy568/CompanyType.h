//
//  CompanyType.h
//  Buy568
//
//  Created by echo23 on 15/9/26.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "SmallCompanyType.h"

@interface CompanyType : NSObject
/**
 一级分类id
 */
@property (nonatomic,assign) int company_type_id;
/**
 一级分类名称
 */
@property (nonatomic,strong) NSString *company_type_name;
/**
 一级分类图标
 */
@property (nonatomic,strong) NSString *company_type_ico;
/**
 一级分类连接
 */
@property (nonatomic,strong) NSString *company_type_url;
/**
 一级分类下的动态广告（滑动广告）
 */
@property (nonatomic,strong) NSMutableArray *add_company;
/**
 一级分类下的二级分类
 */
@property (nonatomic,strong) NSMutableArray *small_company_type;
/**
 TableView当前块是否被打开
 */
@property (nonatomic,assign) BOOL isClose;

//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary;
@end
