//
//  InfoService.m
//  Buy568
//
//  Created by echo23 on 15/10/9.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "InfoService.h"
#import "InfoType.h"
#import "Info.h"


#define TypeInfoURL @"index.php/Home/APIinfo/typeInfo/city_id/"
#define InfoDetailURL @"index.php/Home/APIinfo/contentInfo/info_id/"
#define MyReleaseInfoListURL @"index.php/Home/APIuser/list_myinfo/user_id/"
#define DeleteMyReleaseURL @"index.php/Home/APIuser/delete_myinfo/info_id/"
#define GetInfoConfigURL @"index.php/Home/APIinfo/addInfoconfig/info_type_pid/"
#define GetTypeInfoListURL @"index.php/Home/APIinfo/typelistInfo/info_type_pid/"

@implementation InfoService
/**
 获取信息一级分类--二级分类以及信息列表（大分类切换。下面列表页切换）
 city_id 城市id
 block块内返回infotype数组
 */
-(void)getTypeInfo:(int)city_id success:(void(^)(NSArray *infoTypeArry))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *typeInfoURL_str = [NSString stringWithFormat:@"%@/%@%d",ServerURL,TypeInfoURL,city_id];
    [HttpTools getWithURl:typeInfoURL_str parameter:nil success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *arry = dic[@"type"];
        NSMutableArray *infoTypeArry = [NSMutableArray array];
        for(NSDictionary *dictionary in arry){
            InfoType *infoType = [[InfoType alloc] init];
            [infoType setValueForDictionary:dictionary];
            [infoTypeArry addObject:infoType];
        }
        success(infoTypeArry);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}

/**
 获取信息详细内容
 info_id 信息id
 block块中返回Info对象
 */
-(void)getInfoDetail:(int)info_id success:(void(^)(Info *info))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *infoDetailURL_str = [NSString stringWithFormat:@"%@/%@%d",ServerURL,InfoDetailURL,info_id];
    [HttpTools getWithURl:infoDetailURL_str parameter:nil success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        Info *info = [[Info alloc] init];
        [info setValueForDictionary:dic];
        success(info);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 获取房屋配置或者工作福利
 */
-(void)getInfoConfig:(int)info_type_pid InfoTypeID:(int)info_type_id success:(void(^)(NSArray *configArry))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *getInfoConfigURL_str = [NSString stringWithFormat:@"%@/%@%d/info_type_id/%d",ServerURL,GetInfoConfigURL,info_type_pid,info_type_id];
    [HttpTools getWithURl:getInfoConfigURL_str parameter:nil success:^(id responseObject) {
        NSArray *arry = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *configArry = [NSMutableArray array];
        for(NSDictionary *dic in arry){
            [configArry addObject:dic[@"name"]];
        }
        success(configArry);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 获取我的发布列表
 */
-(void)getMyReleaseInfoList:(int)user_id success:(void(^)(NSArray *releaseInfoArry))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *myReleaseInfoListURL_str = [NSString stringWithFormat:@"%@/%@%d",ServerURL,MyReleaseInfoListURL,user_id];
    [HttpTools getWithURl:myReleaseInfoListURL_str parameter:nil success:^(id responseObject) {
        NSArray *arry = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *releaseInfoArry = [NSMutableArray array];
        for(NSDictionary *dic in arry){
            Info *info = [[Info alloc] init];
            [info setValueForDictionary:dic];
            [releaseInfoArry addObject:info];
        }
        success(releaseInfoArry);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 删除我的发布
 */
-(void)deleteMyRelease:(int)info_id success:(void(^)(BOOL isSuccess,NSString *content))success{
    NSString *deleteMyReleaseURL_str = [NSString stringWithFormat:@"%@/%@%d",ServerURL,DeleteMyReleaseURL,info_id];
    [HttpTools getWithURl:deleteMyReleaseURL_str parameter:nil success:^(id responseObject) {
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
 用于获取当前定位城市指定分类id下的信息列表以及同级栏目
 */
-(void)getTypeInfoList:(int)info_type_pid InfoTypeID:(int)info_type_id CityID:(int)city_id PageNum:(int)page_num PageSize:(int)page_size success:(void(^)(NSArray *infoArry))success{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *getTypeInfoListURL_str = [NSString stringWithFormat:@"%@/%@%d/info_type_id/%d/city_id/%d/page_num/%d/page_size/%d",ServerURL,GetTypeInfoListURL,info_type_pid,info_type_id,city_id,page_num,page_size];
    [HttpTools getWithURl:getTypeInfoListURL_str parameter:nil success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *arry = dic[@"listInfo"];
        NSMutableArray *infoArry = [NSMutableArray array];
        for(NSDictionary *dictionary in arry){
            Info *info = [[Info alloc] init];
            [info setValueForDictionary:dictionary];
            [infoArry addObject:info];
        }
        success(infoArry);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
@end
