//
//  InfoType.m
//  Buy568
//
//  Created by echo23 on 15/10/9.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "InfoType.h"

@implementation InfoType
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.info_type_id = [dictionary[@"info_type_id"] intValue];
    self.info_type_pid = [dictionary[@"info_type_pid"] intValue];
    self.info_type_name = dictionary[@"info_type_name"];
    if([dictionary[@"info_type_ico"] isEqual:[NSNull null]]||[dictionary[@"info_type_ico"] isEqualToString:@"<null>"]){
        self.info_type_ico = @"";
    }else{
      self.info_type_ico = dictionary[@"info_type_ico"];
    }
    self.small_infp_type = [NSMutableArray array];
    NSArray *arry1 = dictionary[@"small_infp_type"];
    for(NSDictionary *dic in arry1){
        smallInfoType *small = [[smallInfoType alloc] init];
        [small setValueForDictionary:dic];
        [self.small_infp_type addObject:small];
    }
    
    self.listinfo = [NSMutableArray array];
    NSArray *arry2 = dictionary[@"listinfo"];
    for(NSDictionary *dic in arry2){
        Info *info = [[Info alloc] init];
        [info setValueForDictionary:dic];
        [self.listinfo addObject:info];
    }
    self.selectedCount = 0;
}
@end
