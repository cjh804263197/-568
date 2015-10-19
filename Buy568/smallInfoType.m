//
//  smallInfoType.m
//  Buy568
//
//  Created by echo23 on 15/10/9.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "smallInfoType.h"

@implementation smallInfoType
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.info_type_id = [dictionary[@"info_type_id"] intValue];
    self.info_type_pid = [dictionary[@"info_type_pid"] intValue];
    self.info_type_name = dictionary[@"info_type_name"];
    self.info_type_ico = dictionary[@"info_type_ico"];
    self.type_link = dictionary[@"type_link"];
}
@end
