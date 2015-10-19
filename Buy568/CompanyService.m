//
//  CompanyService.m
//  Buy568
//
//  Created by echo23 on 15/9/25.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "CompanyService.h"

//获取引导页广告的服务器内路径
#define AD_URL @"index.php/Home/API/yindaoCompany/city_id/"
//获取推荐店铺信息的服务器内路径
#define RecommendCompany_URL @"index.php/Home/API/recommendCompany/city_id/"
//获取获取店铺分类及店铺广告展示信息服务器内路径
#define CompanyType_URl @"index.php/Home/API/CompanyType/city_id/"
//获取店铺详细内容服务器内路径
#define CompanyDetailInfo_URl @"index.php/Home/API/content_company/company_id/"
@implementation CompanyService
/**
 获取引导页广告company对象
 */
-(void)getADCompanyObject:(int)city_id success:(void(^)(Company *company))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    Company *company = [[Company alloc] init];
    //获取引导页广告的URL
    NSString *adUrlStr = [NSString stringWithFormat:@"%@/%@%d",ServerURL,AD_URL,city_id];
    //调用封装后的post连接服务器
    [HttpTools getWithURl:adUrlStr parameter:nil success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [company setValueForDictionary:dic];
        success(company);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 获取推荐店铺信息
 city_id 代表城市编号
 */
-(void)getRecommendCompany:(int)city_id success:(void(^)(NSArray *companyArry))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *recommendCompany_URL_str = [NSString stringWithFormat:@"%@/%@%d",ServerURL,RecommendCompany_URL,city_id];
    [HttpTools getWithURl:recommendCompany_URL_str parameter:nil success:^(id responseObject) {
        NSArray *arry = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *comArry = [NSMutableArray array];
        for(NSDictionary *dic in arry){
            Company *company = [[Company alloc] init];
            [company setValueForDictionary:dic];
            [comArry addObject:company];
        }
        success(comArry);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息%@",error);
    }];
}
/**
 获取广告展示店铺信息（可滚动广告展示）
 */
-(void)getScrollADCompanyObject:(int)city_id success:(void(^)(NSArray *companyArry))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *scrollADCompany_URL_str = [NSString stringWithFormat:@"%@/%@%d",ServerURL,CompanyType_URl,city_id];
    [HttpTools getWithURl:scrollADCompany_URL_str parameter:nil success:^(id responseObject) {
        NSArray *arry = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *comArry = [NSMutableArray array];
        for(NSDictionary *dic in arry){
            if(dic[@"add_company"] != nil){
                NSArray *nextArry = dic[@"add_company"];
                for(NSDictionary *nextDic in nextArry){
                    Company *company = [[Company alloc] init];
                    [company setValueForDictionary:nextDic];
                    [comArry addObject:company];
                }
            }
        }
        success(comArry);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息%@",error);
    }];
}
/**
 获取店铺分类信息
 city_id 代表城市编号
 */
-(void)getCompanyTypeObjects:(int)city_id success:(void(^)(NSArray *companyTypeArry))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *companyType_URL_str = [NSString stringWithFormat:@"%@/%@%d",ServerURL,CompanyType_URl,city_id];
    [HttpTools getWithURl:companyType_URL_str parameter:nil success:^(id responseObject) {
        NSArray *arry = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *comArry = [NSMutableArray array];
        for(NSDictionary *dic in arry){
            CompanyType *companyType = [[CompanyType alloc] init];
            [companyType setValueForDictionary:dic];
            [comArry addObject:companyType];
        }
        success(comArry);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息%@",error);
    }];
}
/**
 获取店铺详细信息
 commpany_id 代表店铺id
 */
-(void)getCompanyDetailInfo:(int)commpany_id success:(void(^)(Company *company))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *companyDetailInfo_URl_str = [NSString stringWithFormat:@"%@/%@%d",ServerURL,CompanyDetailInfo_URl,commpany_id];
    [HttpTools getWithURl:companyDetailInfo_URl_str parameter:nil success:^(id responseObject) {
        NSDictionary *companyDetailDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        Company *companyObjc = [[Company alloc] init];
        [companyObjc setValueForDictionary:companyDetailDic];
        success(companyObjc);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息%@",error);
    }];
}
@end
