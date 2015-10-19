//
//  CompanyTypeTableViewCell.m
//  Buy568
//
//  Created by echo23 on 15/9/26.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "CompanyTypeTableViewCell.h"

@implementation CompanyTypeTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContentView];
    }
    return self;
}
-(void)addContentView{
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(8, 14, 85, 21)];
    titleL.tag = 50;
    [self.contentView addSubview:titleL];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(117, 10, 76, 30);
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:15.0];
    button1.tag = 51;
    [self.contentView addSubview:button1];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:15.0];
    button2.frame = CGRectMake(117+76, 10, 76, 30);
    button2.tag = 52;
    [self.contentView addSubview:button2];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button3.titleLabel.font = [UIFont systemFontOfSize:15.0];
    button3.frame = CGRectMake(117, 10+76*2, 76, 30);
    button3.tag = 53;
    [self.contentView addSubview:button3];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
