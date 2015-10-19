//
//  HttpTools.h
//  Buy568
//
//  Created by echo23 on 15/9/25.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTools : NSObject
/**
 发送一个post请求
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)postWithURL:(NSString *)url parameter:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
/**
 发送一个get请求
 *  @param url     请求路径
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)getWithURl:(NSString *)url parameter:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
