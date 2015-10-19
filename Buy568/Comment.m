//
//  Comment.m
//  Buy568
//
//  Created by echo23 on 15/9/27.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "Comment.h"

@implementation Comment
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.comment_addtime=dictionary[@"comment_addtime"];
    self.comment_content=dictionary[@"comment_content"];
    self.user_name=dictionary[@"user_name"];
    self.comment_id=[dictionary[@"comment_id"] integerValue];
    self.company_id=[dictionary[@"company_id"] integerValue];
    self.user_id=[dictionary[@"user_id"] integerValue];
}
@end
