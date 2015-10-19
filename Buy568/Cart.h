//
//  Cart.h
//  Buy568
//
//  Created by echo23 on 15/10/15.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cart : NSObject
@property (nonatomic,assign) int cart_id;
@property (nonatomic,assign) int user_id;
@property (nonatomic,assign) int goods_id;
@property (nonatomic,assign) int goods_number;
@property (nonatomic,assign) float goods_price;
@property (nonatomic,assign) float goods_marke_price;
@property (nonatomic,strong) NSString *goods_name;
@property (nonatomic,strong) NSString *goods_imgs;

//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary;
@end
