//
//  User.h
//  Buy568
//
//  Created by echo23 on 15/9/29.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>
/**
 会员id
 */
@property (nonatomic,assign) int user_id;
/**
会员编号
 */
@property (nonatomic,assign) int user_num;
/**
姓名
 */
@property (nonatomic,strong) NSString *user_name;
/**
密码
 */
@property (nonatomic,strong) NSString *user_password;
/**
 状态
 0 自来哦不完整
 1正常
 99 禁止登陆
 */
@property (nonatomic,assign) int user_status;
/**
积分
 */
@property (nonatomic,strong) NSString *user_integral;
/**
QQ
 */
@property (nonatomic,strong) NSString *user_qq;
/**
邮箱
 */
@property (nonatomic,strong) NSString *user_mail;
/**
 电话
 */
@property (nonatomic,strong) NSString *user_phone;
/**
 地址
 */
@property (nonatomic,strong) NSString *user_address;
/**
 备用电话
 */
@property (nonatomic,strong) NSString *user_phone2;
/**
 会员备用地址
 */
@property (nonatomic,strong) NSString *user_address2;
/**
 会员加入时间
 */
@property (nonatomic,strong) NSString *user_addtime;
/**
 Vip等级
 */
@property (nonatomic,strong) NSString *vip;
/**
 距下一级别差多少分
 */
@property (nonatomic,strong) NSString *next_integral;
/**
 vip内容
 */
@property (nonatomic,strong) NSString *vip_content;
/**
 会员性别
 男    女
 */
@property (nonatomic,strong) NSString *user_sex;
/**
 会员生日
 格式  1970-01-01
 */
@property (nonatomic,strong) NSString *user_birthday;
/**
 我的账单
 打开网址即可
 */
@property (nonatomic,strong) NSString *mybill;

//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary;
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder;
//解档
- (id)initWithCoder:(NSCoder *)aDecoder;

@end
