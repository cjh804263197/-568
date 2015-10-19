//
//  SmallCompanyType.m
//  Buy568
//
//  Created by echo23 on 15/9/26.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "SmallCompanyType.h"

@implementation SmallCompanyType
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.company_type_id = [dictionary[@"company_type_id"] intValue];
    self.company_type_name = dictionary[@"company_type_name"];
    self.company_type_ico = dictionary[@"company_type_ico"];
    self.company = [NSMutableArray array];
    NSArray *arry = dictionary[@"company"];
    for(NSDictionary *dic in arry){
        Company *companyObct = [[Company alloc] init];
        [companyObct setValueForDictionary:dic];
        [self.company addObject:companyObct];
    }
}
@end
