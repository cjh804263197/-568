//
//  RecommendCompanyCollectionViewCell.m
//  Buy568
//
//  Created by echo23 on 15/9/26.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "RecommendCompanyCollectionViewCell.h"

@implementation RecommendCompanyCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addContentView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)addContentView{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(2.5, 2.5, 25, 25)];
    imageV.tag = 20;
    [self.contentView addSubview:imageV];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 82, 30)];
    titleL.tag = 21;
    titleL.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:titleL];
}
@end
