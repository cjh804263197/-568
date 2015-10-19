//
//  Company.h
//  Buy568
//  店铺实体类
//  Created by echo23 on 15/9/25.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "Comment.h"

@interface Company : NSObject
/**
 店铺ID
 */
@property (nonatomic,assign) int company_id;
/**
 店铺名称
 */
@property (nonatomic,strong) NSString *company_name;
/**
 店铺简称
 */
@property (nonatomic,strong) NSString *company_shortname;
/**
 店铺链接
 */
@property (nonatomic,strong) NSString *company_url;
/**
 店铺logo
 */
@property (nonatomic,strong) NSString *company_ico;
/**
 店铺card
 */
@property (nonatomic,strong) NSString *company_card;
/**
 店铺广告图片
 */
@property (nonatomic,strong) NSString *company_ad;
/**
 会员id
 */
@property (nonatomic,assign) int user_id;
/**
 店铺申请时间
 */
@property (nonatomic,strong) NSString *company_applytime;
/**
 店铺开通时间
 */
@property (nonatomic,strong) NSString *company_throughtime;
/**
 店铺地址
 */
@property (nonatomic,strong) NSString *company_address;
/**
 店铺分类id
 */
@property (nonatomic,assign) int company_type_id;
/**
 店铺联系人
 */
@property (nonatomic,strong) NSString *company_contact;
/**
 店铺电话
 */
@property (nonatomic,strong) NSString *company_tel;
/**
 店铺介绍
 */
@property (nonatomic,strong) NSString *company_about;
/**
 店铺展示图
 */
@property (nonatomic,strong) NSMutableArray *company_imgs_new;
/**
 店铺视频链接
 */
@property (nonatomic,strong) NSString *company_video;
/**
 店铺等级
 */
@property (nonatomic,assign) int company_level;
/**
 店铺浏览量
 */
@property (nonatomic,assign) int company_hits;
/**
 店铺所在城市id
 */
@property (nonatomic,assign) int city_id;
/**
 店铺是否推荐
 0 否  1是
 */
@property (nonatomic,assign) int company_isrecommend;
/**
 店铺排序id
 */
@property (nonatomic,assign) int company_listorder;
/**
 店铺产品
 */
@property (nonatomic,strong) NSMutableArray *company_pro;
/**
 店铺评论
 */
@property (nonatomic,strong) NSMutableArray *company_comment;
/**
 分享标题
 */
@property (nonatomic,strong) NSString *share_title;
/**
 分享链接
 */
@property (nonatomic,strong) NSString *share_url;
/**
 分享内容
 */
@property (nonatomic,strong) NSString *share_content;
/**
 是否开启评论
 0  关闭
 1   开启
 */
@property (nonatomic,assign) int company_iscomment;
/**
 分享图片
 */
@property (nonatomic,strong) NSString *share_img;

//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary;
@end
