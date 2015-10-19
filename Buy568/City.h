//
//  City.h
//  Buy568
//  城市实体类
//  Created by echo23 on 15/9/25.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject
/**
 城市ID
 */
@property (nonatomic,assign) int city_id;
/**
 城市名称
 */
@property (nonatomic,strong) NSString *city_name;

//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary;
@end
