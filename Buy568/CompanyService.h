//
//  CompanyService.h
//  Buy568
//
//  Created by echo23 on 15/9/25.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "CompanyType.h"

@interface CompanyService : NSObject
/**
 获取引导页广告company对象
 city_id 代表城市编号
 */
-(void)getADCompanyObject:(int)city_id success:(void(^)(Company *company))success;
/**
 获取推荐店铺信息
 city_id 代表城市编号
 */
-(void)getRecommendCompany:(int)city_id success:(void(^)(NSArray *companyArry))success;
/**
 获取广告展示店铺信息（可滚动广告展示）
 city_id 代表城市编号
 */
-(void)getScrollADCompanyObject:(int)city_id success:(void(^)(NSArray *companyArry))success;
/**
 获取店铺分类信息
 city_id 代表城市编号
 */
-(void)getCompanyTypeObjects:(int)city_id success:(void(^)(NSArray *companyTypeArry))success;
/**
 获取店铺详细信息
 commpany_id 代表店铺id
 */
-(void)getCompanyDetailInfo:(int)commpany_id success:(void(^)(Company *company))success;
@end
