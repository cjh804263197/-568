//
//  AddPictureCollectionViewCell.m
//  Buy568
//
//  Created by echo23 on 15/10/10.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "AddPictureCollectionViewCell.h"

@implementation AddPictureCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addContentView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)addContentView{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 105, 105)];
    imageV.tag = 10;
    [self.contentView addSubview:imageV];
}
@end
