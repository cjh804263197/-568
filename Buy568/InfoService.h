//
//  InfoService.h
//  Buy568
//
//  Created by echo23 on 15/10/9.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Info.h"

@interface InfoService : NSObject
/**
 获取信息一级分类--二级分类以及信息列表（大分类切换。下面列表页切换）
 city_id 城市id
 block块内返回infotype数组
 */
-(void)getTypeInfo:(int)city_id success:(void(^)(NSArray *infoTypeArry))success;
/**
 获取信息详细内容
 info_id 信息id
 block块中返回Info对象
 */
-(void)getInfoDetail:(int)info_id success:(void(^)(Info *info))success;
/**
 获取房屋配置或者工作福利
 */
-(void)getInfoConfig:(int)info_type_pid InfoTypeID:(int)info_type_id success:(void(^)(NSArray *configArry))success;
/**
 获取我的发布列表
 */
-(void)getMyReleaseInfoList:(int)user_id success:(void(^)(NSArray *releaseInfoArry))success;
/**
 删除我的发布
 */
-(void)deleteMyRelease:(int)info_id success:(void(^)(BOOL isSuccess,NSString *content))success;
/**
 用于获取当前定位城市指定分类id下的信息列表以及同级栏目
 */
-(void)getTypeInfoList:(int)info_type_pid InfoTypeID:(int)info_type_id CityID:(int)city_id PageNum:(int)page_num PageSize:(int)page_size success:(void(^)(NSArray *infoArry))success;
@end
