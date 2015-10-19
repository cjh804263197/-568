//
//  CompanyType.m
//  Buy568
//
//  Created by echo23 on 15/9/26.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "CompanyType.h"

@implementation CompanyType
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.company_type_id = [dictionary[@"company_type_id"] intValue];
    self.company_type_name = dictionary[@"company_type_name"];
    self.company_type_ico = dictionary[@"company_type_ico"];
    self.company_type_url = dictionary[@"company_type_url"];
    self.add_company = [NSMutableArray array];
    NSArray *addArry = dictionary[@"add_company"];
    for(NSDictionary *dic in addArry){
        Company *company = [[Company alloc] init];
        [company setValueForDictionary:dic];
        [self.add_company addObject:company];
    }
    self.small_company_type = [NSMutableArray array];
    NSArray *smallArry = dictionary[@"small_company_type"];
    for(NSDictionary *dic in smallArry){
        SmallCompanyType *smallCT = [[SmallCompanyType alloc] init];
        [smallCT setValueForDictionary:dic];
        [self.small_company_type addObject:smallCT];
    }
}
@end
