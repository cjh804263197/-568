//
//  InfoType.h
//  Buy568
//  招聘或房屋信息一级分类实体类
//  Created by echo23 on 15/10/9.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "smallInfoType.h"
#import "Info.h"

@interface InfoType : NSObject
@property (nonatomic,assign) int info_type_id;
@property (nonatomic,assign) int info_type_pid;
@property (nonatomic,strong) NSString *info_type_name;
@property (nonatomic,strong) NSString *info_type_ico;
@property (nonatomic,strong) NSMutableArray *small_infp_type;
@property (nonatomic,strong) NSMutableArray *listinfo;
@property (nonatomic,assign) int selectedCount;
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary;
@end
