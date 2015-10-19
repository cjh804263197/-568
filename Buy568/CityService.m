//
//  CityService.m
//  Buy568
//
//  Created by echo23 on 15/9/25.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "CityService.h"
#import "City.h"

#define OpenCityURL @"index.php/Home/API/openCity"

@implementation CityService
/**
 获取已开通城市
 */
-(void)getOpenCity:(void(^)(NSArray *cityArry))allCity{
    [SVProgressHUD showWithStatus:@"正在加载.."];
    NSString *openCityURL_str = [NSString stringWithFormat:@"%@/%@",ServerURL,OpenCityURL];
    [HttpTools getWithURl:openCityURL_str parameter:nil success:^(id responseObject) {
        NSArray *cityArry = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *allCityArry = [NSMutableArray array];
        for(NSDictionary *dic in cityArry){
            City *city = [[City alloc] init];
            [city setValueForDictionary:dic];
            [allCityArry addObject:city];
        }
        allCity(allCityArry);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"错误信息:%@",error);
    }];
}
@end
