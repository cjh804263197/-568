//
//  SmallCompanyType.h
//  Buy568
//
//  Created by echo23 on 15/9/26.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"

@interface SmallCompanyType : NSObject
/**
二级分类id
 */
@property (nonatomic,assign) int company_type_id;
/**
 二级分类名称
 */
@property (nonatomic,strong) NSString *company_type_name;
/**
 二级分类图标
 */
@property (nonatomic,strong) NSString *company_type_ico;
/**
 二级分类下的所有店铺对象
 */
@property (nonatomic,strong) NSMutableArray *company;

//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary;
@end
