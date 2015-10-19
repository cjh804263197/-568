//
//  User.m
//  Buy568
//  会员类
//  Created by echo23 on 15/9/29.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "User.h"

@implementation User
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:[NSString stringWithFormat:@"%d",self.user_id] forKey:@"user_id"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%d",self.user_num] forKey:@"user_num"];
    [aCoder encodeObject:self.user_name forKey:@"user_name"];
    [aCoder encodeObject:self.user_password forKey:@"user_password"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%d",self.user_status] forKey:@"user_status"];
    [aCoder encodeObject:self.user_integral forKey:@"user_integral"];
    [aCoder encodeObject:self.user_qq forKey:@"user_qq"];
    [aCoder encodeObject:self.user_mail forKey:@"user_mail"];
    [aCoder encodeObject:self.user_phone forKey:@"user_phone"];
    [aCoder encodeObject:self.user_address forKey:@"user_address"];
    [aCoder encodeObject:self.user_phone2 forKey:@"user_phone2"];
    [aCoder encodeObject:self.user_address2 forKey:@"user_address2"];
    [aCoder encodeObject:self.user_addtime forKey:@"user_addtime"];
    [aCoder encodeObject:self.vip forKey:@"vip"];
    [aCoder encodeObject:self.next_integral forKey:@"next_integral"];
    [aCoder encodeObject:self.vip_content forKey:@"vip_content"];
    [aCoder encodeObject:self.user_sex forKey:@"user_sex"];
    [aCoder encodeObject:self.user_birthday forKey:@"user_birthday"];
    [aCoder encodeObject:self.mybill forKey:@"mybill"];
    
}
//解档
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        self.user_id = [[aDecoder decodeObjectForKey:@"user_id"] intValue];
        self.user_num = [[aDecoder decodeObjectForKey:@"user_num"] intValue];
        self.user_name = [aDecoder decodeObjectForKey:@"user_name"];
        self.user_password = [aDecoder decodeObjectForKey:@"user_password"];
        self.user_status = [[aDecoder decodeObjectForKey:@"user_status"] intValue];
        self.user_integral = [aDecoder decodeObjectForKey:@"user_integral"];
        self.user_qq = [aDecoder decodeObjectForKey:@"user_qq"];
        self.user_mail = [aDecoder decodeObjectForKey:@"user_mail"];
        self.user_phone = [aDecoder decodeObjectForKey:@"user_phone"];
        self.user_address = [aDecoder decodeObjectForKey:@"user_address"];
        self.user_phone2 = [aDecoder decodeObjectForKey:@"user_phone2"];
        self.user_address2 = [aDecoder decodeObjectForKey:@"user_address2"];
        self.user_addtime = [aDecoder decodeObjectForKey:@"user_addtime"];
        self.vip = [aDecoder decodeObjectForKey:@"vip"];
        self.next_integral = [aDecoder decodeObjectForKey:@"next_integral"];
        self.vip_content = [aDecoder decodeObjectForKey:@"vip_content"];
        self.user_sex = [aDecoder decodeObjectForKey:@"user_sex"];
        self.user_birthday = [aDecoder decodeObjectForKey:@"user_birthday"];
        self.mybill = [aDecoder decodeObjectForKey:@"mybill"];
    }
    return self;
}
//通过dictionary给实体类赋值
-(void)setValueForDictionary:(NSDictionary *)dictionary{
    self.user_id = [dictionary[@"user_id"] intValue];
    self.user_num = [dictionary[@"user_num"] intValue];
    self.user_name = dictionary[@"user_name"];
    self.user_password = dictionary[@"user_password"];
    self.user_status = [dictionary[@"user_status"] intValue];
    self.user_integral = dictionary[@"user_integral"];
    if([dictionary[@"user_qq"] isEqual:[NSNull null]]||[dictionary[@"user_qq"] isEqualToString:@"<null>"]){
        self.user_qq = @"";
    }else{
        self.user_qq = dictionary[@"user_qq"];
    }
    
    if([dictionary[@"user_mail"] isEqual:[NSNull null]]||[dictionary[@"user_mail"] isEqualToString:@"<null>"]){
        self.user_mail = @"";
    }else{
        self.user_mail = dictionary[@"user_mail"];
    }
    self.user_phone = dictionary[@"user_phone"];
    if([dictionary[@"user_address"] isEqual:[NSNull null]]||[dictionary[@"user_address"] isEqualToString:@"<null>"]){
        self.user_address = @"";
    }else{
        self.user_address = dictionary[@"user_address"];
    }
    if([dictionary[@"user_phone2"] isEqual:[NSNull null]]||[dictionary[@"user_phone2"] isEqualToString:@"<null>"]){
        self.user_phone2 = @"";
    }else{
        self.user_phone2 = dictionary[@"user_phone2"];
    }
    if([dictionary[@"user_address2"] isEqual:[NSNull null]]||[dictionary[@"user_address2"] isEqualToString:@"<null>"]){
        self.user_address2 = @"";
    }else{
        self.user_address2 = dictionary[@"user_address2"];
    }
    self.user_addtime = dictionary[@"user_addtime"];
    self.vip = dictionary[@"vip"];
    self.next_integral = dictionary[@"next_integral"];
    self.vip_content = dictionary[@"vip_content"];
    self.user_sex = dictionary[@"user_sex"];
    self.user_birthday = dictionary[@"user_birthday"];
    self.mybill = dictionary[@"mybill"];
}
@end
