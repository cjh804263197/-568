//
//  UserService.m
//  Buy568
//
//  Created by echo23 on 15/9/29.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "UserService.h"
//登录验证服务器内路径
#define LoginCheckURL @"index.php/Home/APIuser/loginUser/"
//发表评论服务器内地址
#define WriteCommentURL @"index.php/Home/API/add_comment"
//添加举报服务器内地址
#define TipCompanyURL @"index.php/Home/API/add_report"
//修改个人资料服务器内地址
#define AlterUserInfoURL @"index.php/Home/APIuser/updateinfo/"
//修改用户密码服务器内地址
#define AlterUserPasswordURL @"Home/APIuser/updatepass/"

@implementation UserService
/**
 用户登录
 成功 在block块中返回YES并返回该用户的对象
 失败 在block块中返回NO
 */
-(void)userLoginCheck:(User *)user success:(void(^)(BOOL isSuccess,User *user))success{
    [SVProgressHUD showWithStatus:@"正在登录.."];
    NSString *loginCheckURL_str = [NSString stringWithFormat:@"%@/%@user_phone/%@/user_password/%@",ServerURL,LoginCheckURL,user.user_phone,user.user_password];
    [HttpTools getWithURl:loginCheckURL_str parameter:nil success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"status"] isEqualToString:@"1"]) {
//            User *userObjc = [[User alloc] init];
            [user setValueForDictionary:dic[@"userinfo"]];
            success(YES,user);
        }else
            success(NO,nil);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
         NSLog(@"错误信息:%@",error);
    }];
}

/**
 验证当前是否有用户登录
 有用户登录 block块内返回YES,并返回当前登录用户对象
 无用户登录 block块内返回NO
 */
-(void)currentUserIsLogin:(void(^)(BOOL isLogin,User *user))success{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    //从沙盒中取出存储的user对象,并进行解档操作
    User *user =  [NSKeyedUnarchiver unarchiveObjectWithData:[userD objectForKey:@"user"]];
    //如果取出的对象为空，或者取出的用户不在线
    if(user == nil){
        success(NO,nil);
    }else{
        success(YES,user);
    }
}

/**
当前登录用户退出
 */
-(void)exitCurrentUser{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    [userD removeObjectForKey:@"user"];
}

/**
 用户发布评论
 所需参数
 user_id 用户的id
 company_id 店铺的id
 comment_content 评论内容
 返回参数
 成功 block块内返回YES
 失败 block块内返回NO
 */
-(void)userWriteComment:(int)user_id company_id:(int)company_id comment_content:(NSString *)comment_content success:(void(^)(BOOL isSuccess))success{
    NSString *writeCommentURL_str = [NSString stringWithFormat:@"%@/%@",ServerURL,WriteCommentURL];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:[NSString stringWithFormat:@"%d",user_id] forKey:@"user_id"];
    [paramDic setValue:[NSString stringWithFormat:@"%d",company_id] forKey:@"company_id"];
    [paramDic setValue:comment_content forKey:@"comment_content"];
    [HttpTools postWithURL:writeCommentURL_str parameter:paramDic success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([dic[@"status"] intValue] == 1){
            success(YES);
        }else{
            success(NO);
        }
    } failure:^(NSError *error) {
        NSLog(@"错误信息:%@",error);
    }];
}
/**
 用户举报店铺
 所需参数
 user_id 用户的id
 company_id 店铺的id
 report_content 举报内容
 返回参数
 成功 block块内返回YES,content返回的内容
 失败 block块内返回NO,content返回的内容
 */
-(void)userTipCompany:(int)user_id company_id:(int)company_id report_content:(NSString *)report_content success:(void(^)(BOOL isSuccess,NSString *content))success{
    NSString *tipCompanyURL_str = [NSString stringWithFormat:@"%@/%@",ServerURL,TipCompanyURL];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:[NSString stringWithFormat:@"%d",user_id] forKey:@"user_id"];
    [paramDic setValue:[NSString stringWithFormat:@"%d",company_id] forKey:@"company_id"];
    [paramDic setValue:report_content forKey:@"report_content"];
    [HttpTools postWithURL:tipCompanyURL_str parameter:paramDic success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([dic[@"status"] intValue] == 1){
            success(YES,dic[@"content"]);
        }else if ([dic[@"status"] intValue] == 0){
            success(YES,dic[@"content"]);
        }else{
            success(NO,dic[@"content"]);
        }
    } failure:^(NSError *error) {
        NSLog(@"错误信息:%@",error);
    }];
}

/**
 修改用户信息
 所需参数 user对象
 返回参数
 成功 block块内返回YES
 失败 block块内返回NO
 */
-(void)alterUserInfo:(User *)user success:(void(^)(BOOL isSuccess,NSString *content,User *user))success{
    [SVProgressHUD showWithStatus:@"正在修改.."];
    NSString *alterUserInfoURL_str = [NSString stringWithFormat:@"%@/%@",ServerURL,AlterUserInfoURL];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:[NSString stringWithFormat:@"%d",user.user_id] forKey:@"user_id"];
    [paramDic setValue:user.user_name forKey:@"user_name"];
    [paramDic setValue:user.user_qq forKey:@"user_qq"];
    [paramDic setValue:user.user_mail forKey:@"user_mail"];
    [paramDic setValue:user.user_phone forKey:@"user_phone"];
    [paramDic setValue:user.user_address forKey:@"user_address"];
    [paramDic setValue:user.user_phone2 forKey:@"user_phone2"];
    [paramDic setValue:user.user_address2 forKey:@"user_address2"];
    [paramDic setValue:user.user_sex forKey:@"user_sex"];
    [paramDic setValue:user.user_birthday forKey:@"user_birthday"];
    [HttpTools postWithURL:alterUserInfoURL_str parameter:paramDic success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        User *user = [[User alloc] init];
        [user setValueForDictionary:dic[@"userinfo"]];
        if([dic[@"status"] intValue] == 1){
            //将user对象转化为NSData类型
            NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
            //将当前用户存入本地
            NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
            [userD setObject:userData forKey:@"user"];
            success(YES,dic[@"content"],user);
        }else{
            success(NO,dic[@"content"],nil);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
         NSLog(@"错误信息:%@",error);
    }];
}

/**
 修改用户密码
 所需参数 user_id 旧密码 新密码 新密码确认
 返回参数
 成功 block块内返回YES
 失败 block块内返回NO
 */
-(void)alterUserPassword:(int)user_id OldPassword:(NSString *)oldpass NewPassword:(NSString *)newpass RepartNewPassword:(NSString *)newpass2 success:(void(^)(BOOL isSuccess,NSString *content))success{
    [SVProgressHUD showWithStatus:@"正在修改.."];
    NSString *alterUserPasswordURL_str = [NSString stringWithFormat:@"%@/%@",ServerURL,AlterUserPasswordURL];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:[NSString stringWithFormat:@"%d",user_id] forKey:@"user_id"];
    [paramDic setValue:oldpass forKey:@"oldpass"];
    [paramDic setValue:newpass forKey:@"newpass"];
    [paramDic setValue:newpass2 forKey:@"newpass2"];
    [HttpTools postWithURL:alterUserPasswordURL_str parameter:paramDic success:^(id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([dic[@"status"] intValue] == 1){
            success(YES,dic[@"content"]);
        }else{
            success(NO,dic[@"content"]);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
@end
