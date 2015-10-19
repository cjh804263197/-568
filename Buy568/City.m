//
//  City.m
//  Buy568
//
//  Created by echo23 on 15/9/25.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "City.h"

@implementation City
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.city_id = [dictionary[@"city_id"] intValue];
    self.city_name = dictionary[@"city_name"];
}
@end
