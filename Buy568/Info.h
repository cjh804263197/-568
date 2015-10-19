//
//  Info.h
//  Buy568
//  招聘或房屋信息实体类
//  Created by echo23 on 15/10/9.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Info : NSObject
@property (nonatomic,assign) int info_id;
@property (nonatomic,strong) NSString *info_title;
@property (nonatomic,strong) NSString *info_imgs;
@property (nonatomic,strong) NSString *info_link;
@property (nonatomic,assign) int info_type;
@property (nonatomic,strong) NSString *info_addtime;
@property (nonatomic,assign) float info_money;
@property (nonatomic,strong) NSString *info_address;

@property (nonatomic,assign) int user_id;
@property (nonatomic,assign) int info_type_id;
@property (nonatomic,strong) NSString *info_home_price;
@property (nonatomic,strong) NSString *info_home_address;
@property (nonatomic,strong) NSString *info_home_explain;
@property (nonatomic,strong) NSString *info_job_position;
@property (nonatomic,strong) NSString *info_job_salary;
@property (nonatomic,strong) NSString *info_job_requirement;
@property (nonatomic,strong) NSString *info_job_companyname;
@property (nonatomic,strong) NSString *info_job_companyintro;
@property (nonatomic,strong) NSString *info_contact;
@property (nonatomic,strong) NSString *info_tel;
@property (nonatomic,strong) NSString *info_edittime;
@property (nonatomic,assign) int info_status;
@property (nonatomic,assign) int info_hits;
@property (nonatomic,assign) int city_id;
@property (nonatomic,strong) NSString *info_job_number;
@property (nonatomic,assign) int info_type_pid;
@property (nonatomic,strong) NSString *info_type_name;
@property (nonatomic,strong) NSMutableArray *info_job_weal_new;
@property (nonatomic,strong) NSMutableArray *info_home_config_new;
@property (nonatomic,strong) NSMutableArray *info_imgs_new;
@property (nonatomic,strong) NSString *share_title;
@property (nonatomic,strong) NSString *share_img;
@property (nonatomic,strong) NSString *share_url;
@property (nonatomic,strong) NSString *share_content;


//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary;
@end
