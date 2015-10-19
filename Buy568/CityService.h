//
//  CityService.h
//  Buy568
//
//  Created by echo23 on 15/9/25.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityService : NSObject
/**
 获取已开通城市
 */
-(void)getOpenCity:(void(^)(NSArray *cityArry))allCity;
@end
