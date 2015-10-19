//
//  Company.m
//  Buy568
//
//  Created by echo23 on 15/9/25.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "Company.h"

@implementation Company
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.company_id = [dictionary[@"company_id"] intValue];
    self.company_name = dictionary[@"company_name"];
    self.company_shortname = dictionary[@"company_shortname"];
    self.company_url = dictionary[@"company_url"];
    self.company_ico = dictionary[@"company_ico"];
    self.company_ad = dictionary[@"company_ad"];
    self.user_id = [dictionary[@"user_id"] intValue];
    self.company_applytime = dictionary[@"company_applytime"];
    self.company_throughtime = dictionary[@"company_throughtime"];
    self.company_address = dictionary[@"company_address"];
    self.company_type_id = [dictionary[@"company_type_id"] intValue];
    self.company_contact = dictionary[@"company_contact"];
    self.company_tel = dictionary[@"company_tel"];
    self.company_about = dictionary[@"company_about"];
    self.company_imgs_new = [NSMutableArray array];
    NSArray *imgArry = dictionary[@"company_imgs_new"];
    for(NSDictionary *dic in imgArry){
        [self.company_imgs_new addObject:dic[@"img"]];
    }
    self.company_video = dictionary[@"company_video"];
    self.company_level = [dictionary[@"company_level"] intValue];
    self.company_hits = [dictionary[@"company_hits"] intValue];
    self.city_id = [dictionary[@"city_id"] intValue];
    self.company_isrecommend = [dictionary[@"company_isrecommend"] intValue];
    self.company_listorder = [dictionary[@"company_listorder"] intValue];
    self.company_iscomment = [dictionary[@"company_iscomment"] intValue];
    self.company_card = dictionary[@"company_card"];
    self.company_pro = [NSMutableArray array];
    NSArray *proArry = dictionary[@"company_pro"];
    for(NSDictionary *dic in proArry){
        Product *pro = [[Product alloc] init];
        [pro setValueForDictionary:dic];
        [self.company_pro addObject:pro];
    }
    self.company_comment = [NSMutableArray array];
    NSArray *commArry = dictionary[@"company_comment"];
    for(NSDictionary *dic in commArry){
        Comment *comm = [[Comment alloc] init];
        [comm setValueForDictionary:dic];
        [self.company_comment addObject:comm];
    }
    self.share_title = dictionary[@"share_title"];
    self.share_img = dictionary[@"share_img"];
    self.share_url = dictionary[@"share_url"];
    self.share_content = dictionary[@"share_content"];
}
@end
