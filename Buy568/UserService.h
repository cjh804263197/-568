//
//  UserService.h
//  Buy568
//
//  Created by echo23 on 15/9/29.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserService : NSObject
/**
 用户登录
 成功 在block块中返回YES并返回该用户的对象
 失败 在block块中返回NO
 */
-(void)userLoginCheck:(User *)user success:(void(^)(BOOL isSuccess,User *user))success;
/**
 验证当前是否有用户登录
 有用户登录 返回YES
 无用户登录 返回NO
 */
-(void)currentUserIsLogin:(void(^)(BOOL isLogin,User *user))success;
/**
 当前登录用户退出
 */
-(void)exitCurrentUser;
/**
 用户发布评论
 成功 block块内返回YES
 失败 block块内返回NO
 */
-(void)userWriteComment:(int)user_id company_id:(int)company_id comment_content:(NSString *)comment_content success:(void(^)(BOOL isSuccess))success;
/**
 用户举报店铺
 所需参数
 user_id 用户的id
 company_id 店铺的id
 report_content 举报内容
 返回参数
 成功 block块内返回YES
 失败 block块内返回NO
 */
-(void)userTipCompany:(int)user_id company_id:(int)company_id report_content:(NSString *)report_content success:(void(^)(BOOL isSuccess,NSString *content))success;

/**
 修改用户信息
 所需参数 user对象
 返回参数
 成功 block块内返回YES
 失败 block块内返回NO
 */
-(void)alterUserInfo:(User *)user success:(void(^)(BOOL isSuccess,NSString *content,User *user))success;

/**
 修改用户密码
 所需参数 user_id 旧密码 新密码 新密码确认
 返回参数
 成功 block块内返回YES
 失败 block块内返回NO
 */
-(void)alterUserPassword:(int)user_id OldPassword:(NSString *)oldpass NewPassword:(NSString *)newpass RepartNewPassword:(NSString *)newpass2 success:(void(^)(BOOL isSuccess,NSString *content))success;
@end
