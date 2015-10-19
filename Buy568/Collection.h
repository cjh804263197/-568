//
//  Collection.h
//  Buy568
//
//  Created by echo23 on 15/10/14.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Collection : NSObject
@property (nonatomic,assign) int collect_id;
@property (nonatomic,assign) int user_id;
@property (nonatomic,assign) int goods_id;
@property (nonatomic,strong) NSString *collect_addtime;
@property (nonatomic,strong) NSString *goods_name;
@property (nonatomic,assign) float goods_price;
@property (nonatomic,strong) NSString *goods_imgs;

//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary;
@end
