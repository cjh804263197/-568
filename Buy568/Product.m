//
//  Product.m
//  Buy568
//  产品类
//  Created by echo23 on 15/9/27.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "Product.h"

@implementation Product
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.company_pro_id = [dictionary[@"company_pro_id"] intValue];
    self.company_pro_imgsrc = dictionary[@"company_pro_imgsrc"];
    self.company_pro_title = dictionary[@"company_pro_title"];
    self.company_pro_content = dictionary[@"company_pro_content"];
    self.company_pro_remarks = dictionary[@"company_pro_remarks"];
    self.company_id = [dictionary[@"company_id"] intValue];
    self.company_pro_listorder = [dictionary[@"company_pro_listorder"] intValue];
}
@end
