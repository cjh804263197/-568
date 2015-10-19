//
//  Comment.h
//  Buy568
//  评论类
//  Created by echo23 on 15/9/27.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
/**
 评论id
 */
@property (nonatomic,assign)NSInteger comment_id;
/**
 店铺id
 */
@property (nonatomic,assign)NSInteger company_id;
/**
 会员id
 */
@property (nonatomic,assign)NSInteger user_id;
/**
 评论时间
 */
@property (nonatomic,copy)NSString *comment_addtime;
/**
 评论内容
 */
@property (nonatomic,copy)NSString *comment_content;
/**
 会员名称
 */
@property (nonatomic,copy)NSString *user_name;

//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary;
@end
