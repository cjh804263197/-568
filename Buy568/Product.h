//
//  Product.h
//  Buy568
//  产品类
//  Created by echo23 on 15/9/27.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
/**
 产品id
 */
@property (nonatomic,assign) int company_pro_id;
/**
 产品图片路径
 */
@property (nonatomic,strong) NSString *company_pro_imgsrc;
/**
 产品名称
 */
@property (nonatomic,strong) NSString *company_pro_title;
/**
 产品内容
 */
@property (nonatomic,strong) NSString *company_pro_content;
/**
 产品备注
 */
@property (nonatomic,strong) NSString *company_pro_remarks;
/**
 所属公司id
 */
@property (nonatomic,assign) int company_id;
/**
 产品排序
 */
@property (nonatomic,assign) int company_pro_listorder;

//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary;
@end
