//
//  Info.m
//  Buy568
//
//  Created by echo23 on 15/10/9.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "Info.h"

@implementation Info
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.info_id = [dictionary[@"info_id"] intValue];
    self.info_title = dictionary[@"info_title"];
    if([dictionary[@"info_imgs"] isEqual:[NSNull null]]||[dictionary[@"info_imgs"] isEqualToString:@"<null>"]){
        self.info_imgs = @"";
    }else{
        self.info_imgs = [NSString stringWithFormat:@"%@/%@",ServerURL,dictionary[@"info_imgs"]];
    }
    self.info_link = dictionary[@"info_link"];
    self.info_type = [dictionary[@"info_type"] intValue];
    self.info_addtime = dictionary[@"info_addtime"];
    self.info_money = [dictionary[@"info_money"] floatValue];
    self.info_address = dictionary[@"info_address"];
    
    self.user_id = [dictionary[@"user_id"] intValue];
    self.info_type_id = [dictionary[@"info_type_id"] intValue];
    self.info_home_price = dictionary[@"info_home_price"];
    self.info_home_address = dictionary[@"info_home_address"];
    self.info_home_explain = dictionary[@"info_home_explain"];
    self.info_job_position = dictionary[@"info_job_position"];
    self.info_job_salary = dictionary[@"info_job_salary"];
    self.info_job_requirement = dictionary[@"info_job_requirement"];
    self.info_job_companyname = dictionary[@"info_job_companyname"];
    self.info_job_companyintro = dictionary[@"info_job_companyintro"];
    self.info_job_weal_new = [NSMutableArray array];
    NSArray *arry1 = dictionary[@"info_job_weal_new"];
    for(NSDictionary *dic in arry1){
        [self.info_job_weal_new addObject:dic[@"text"]];
    }
    self.info_contact = dictionary[@"info_contact"];
    self.info_tel = dictionary[@"info_tel"];
    self.info_edittime = dictionary[@"info_edittime"];
    self.info_status = [dictionary[@"info_status"] intValue];
    self.info_hits = [dictionary[@"info_hits"] intValue];
    self.city_id = [dictionary[@"city_id"] intValue];
    self.info_job_number= dictionary[@"info_job_number"];
    self.info_type_pid= [dictionary[@"info_type_pid"] intValue];
    self.info_type_name = dictionary[@"info_type_name"];
    self.info_home_config_new = [NSMutableArray array];
    NSArray *arry2 = dictionary[@"info_home_config_new"];
    for(NSDictionary *dic in arry2){
        [self.info_home_config_new addObject:dic[@"text"]];
    }
    self.info_imgs_new = [NSMutableArray array];
    NSArray *arry3 = dictionary[@"info_imgs_new"];
    for(NSDictionary *dic in arry3){
        [self.info_imgs_new addObject:[NSString stringWithFormat:@"%@%@",ServerURL,dic[@"img"]]];
    }
    self.share_title = dictionary[@"share_title"];
    self.share_img = dictionary[@"share_img"];
    self.share_url = dictionary[@"share_url"];
    self.share_content = dictionary[@"share_content"];
}
@end
